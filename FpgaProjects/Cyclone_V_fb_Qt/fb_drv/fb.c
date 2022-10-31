

 #include<linux/init.h>
 #include<linux/module.h> 
 #include<linux/kernel.h>
 #include<linux/fb.h>
 #include<linux/delay.h>
 #include<linux/platform_device.h>


 #define BA_PERIPH 	0xfc000000
 #define LW_FPGA_SLAVES	0xff200000
 #define FPGA_SLAVES	0xc0000000
 #define PERIPH_SIZE 	0x04000000
 #define MASK 		(PERIPH_SIZE - 1)

 #define WIDTH			1024
 #define HEIGHT			600
 #define BYTE_DEPTH		4
 #define PAGE_COUNT		600
 #define FB_SIZE		(PAGE_SIZE * PAGE_COUNT)
 #define PIXELS_IN_PAGE		PAGE_SIZE/BYTE_DEPTH 



static unsigned int *pv, *pv_dma, *pfull,
		    *pstart, phys_addr;


 struct fb_info *pinfo;

 ssize_t lcd_write(struct fb_info *p, const char __user *pbuf, size_t count, loff_t *ppos);

/*
 static void lcd_fillrect(struct fb_info *p, const struct fb_fillrect *rect);

 static void lcd_copyarea(struct fb_info *p, const struct fb_copyarea *parea);

 static void lcd_imageblit(struct fb_info *p, const struct fb_image *pimage);

*/


 static void rtd2660_update(struct fb_info *p, struct list_head *pagelist);


 struct videopage {

    int 	  x, y;
    unsigned char *mem;
    unsigned long len;
    int           update;
 };


 struct rtd2660 {

    struct device *dev;
    struct fb_info *info;
    unsigned int pages_count;
    struct videopage pages[PAGE_COUNT];
    unsigned int *videomem;

 } *item;



 struct fb_ops lcd_ops = {

    .owner = THIS_MODULE,

    .fb_write = lcd_write,
//    .fb_fillrect = lcd_fillrect,
//    .fb_copyarea  = lcd_copyarea,
//    .fb_imageblit = lcd_imageblit,
//    .fb_setcolreg = NULL,
//    .fb_blank = NULL
 };


 struct fb_fix_screeninfo lcd_fix __initdata = {

    .id          = "rtd2660",
    .type        = FB_TYPE_PACKED_PIXELS,
    .visual      = FB_VISUAL_TRUECOLOR,
    .accel       = FB_ACCEL_NONE,
    .line_length = 1024 * 4

 };


 struct fb_var_screeninfo lcd_var __initdata = {

    .xres        = WIDTH,
    .yres        = HEIGHT,
    .xres_virtual    = WIDTH,
    .yres_virtual    = HEIGHT,
    .width        = WIDTH,
    .height        = HEIGHT,

    .bits_per_pixel = 32,

    .transp    = {24, 8, 0},
    .red       = {16, 8, 0},
    .green     = {8, 8, 0},
    .blue      = {0, 8, 0},

    .activate  = FB_ACTIVATE_NOW,
    .vmode     = FB_VMODE_NONINTERLACED
 };



static struct fb_deferred_io lcd_defio = {

    .delay = HZ/20,

    .deferred_io = rtd2660_update
 };



 static void rtd2660_touch(struct fb_info *info, int x, int y, int w, int h){


    struct fb_deferred_io *fbdefio = info->fbdefio;

    schedule_delayed_work(&info->deferred_work, fbdefio->delay);
 }



 static void rtd2660_update(struct fb_info *p, struct list_head *pagelist) {


    unsigned int i, j;


    for(j = 0; j < 2; ++j){

	for(i = 0; i < 614400; ++i)
	    iowrite32(*(pv + i), (pv_dma + i));
    }


    iowrite32(0xa5, pfull);
 }


 ssize_t lcd_write(struct fb_info *p, const char __user *pbuf, size_t count, loff_t *ppos){


    int ret;

    ret = fb_sys_write(p, pbuf, count, ppos);

    rtd2660_touch(p, 0, 0, p->var.xres, p->var.yres);

    return ret;
 }


/*
 static void lcd_copyarea(struct fb_info *p, const struct fb_copyarea *area)
 {

    sys_copyarea(p, area);

    rtd2660_touch(p, area->dx, area->dy, area->width, area->height);

 }


 static void lcd_fillrect(struct fb_info *p, const struct fb_fillrect *rect)
 {

    sys_fillrect(p, rect);

    rtd2660_touch(p, rect->dx, rect->dy, rect->width, rect->height);

 }


static void lcd_imageblit(struct fb_info *p, const struct fb_image *image)
{

    sys_imageblit(p, image);

    rtd2660_touch(p, image->dx, image->dy, image->width, image->height);

}

*/


 static int __init fb_probe(struct platform_device *pdevice) {


    int ret = 0;


    item = kzalloc(sizeof(struct rtd2660), GFP_KERNEL);

    if (!item) {

        printk(KERN_ALERT "Cannot allocate memory for item.\n");
        ret = -ENOMEM;
        goto out;
    }

    item->dev = &pdevice->dev;
    dev_set_drvdata(&pdevice->dev, item);


    pinfo = framebuffer_alloc(sizeof(struct rtd2660), &pdevice->dev);

    if (!pinfo) {

        printk(KERN_ALERT "Cannot allocate memory for framebuffer_info.\n");
        ret = -ENOMEM;
        goto item_out;
    }

    item->info = pinfo;

    pinfo->par = item;
    pinfo->dev = &pdevice->dev;
    pinfo->flags = FBINFO_FLAG_DEFAULT;
    pinfo->fbops = &lcd_ops;
    pinfo->fix = lcd_fix;
    pinfo->var = lcd_var;
    pinfo->fix.smem_len = FB_SIZE;


    pv = (unsigned int*)vmalloc(FB_SIZE);

    if(!pv){

       printk(KERN_ALERT "Cannot allocate memory for pv.\n");
       ret = -ENOMEM;
       goto info_out;
    }

    pinfo->fix.smem_start = (unsigned int)(pv);
    pinfo->screen_base = (char __iomem *)item->info->fix.smem_start;
    item->videomem = pv;

    memset((void*)pinfo->fix.smem_start, 0, FB_SIZE);

/*
    for(i = 0; i < PAGE_COUNT; i++) {

	item->pages[i].mem = (void*)(pinfo->fix.smem_start + PAGE_SIZE * i);
	item->pages[i].len = PAGE_SIZE;
	item->pages[i].update = 1;
    }
*/

    pinfo->fbdefio = &lcd_defio;
    fb_deferred_io_init(pinfo);

    ret = register_framebuffer(pinfo);

    if(ret < 0){

       printk(KERN_ALERT "Cannot register_framebuffer.\n");
       goto pv_out;
    }



    pv_dma = (unsigned int*)kmalloc(FB_SIZE, GFP_KERNEL);

    if(!pv_dma){

       printk(KERN_ALERT "Cannot allocate memory for pv_dma.\n");
       ret = -ENOMEM;
       goto info_out;
    }

    memset(pv_dma, 0x00, FB_SIZE);

//soc.

    pfull = (unsigned int*)ioremap(BA_PERIPH + ((LW_FPGA_SLAVES + 0x00) & MASK), 4);

    pstart = (unsigned int*)ioremap(BA_PERIPH + ((LW_FPGA_SLAVES + 0x10) & MASK), 4);

    phys_addr = virt_to_phys(pv_dma);

    iowrite32(phys_addr, pstart);



    return ret;

    info_out: framebuffer_release(pinfo);

    item_out: kfree(item);

    pv_out: vfree(pv);

    out: return ret;
 }




 static int fb_remove(struct platform_device *device) {


    vfree(pv);
    kfree(pv_dma);

    framebuffer_release(pinfo);
    unregister_framebuffer(pinfo);

    kfree(item);

   printk("device remove.\n");

   return 0;
 }



/******************* structs ***********************/


 static struct platform_device *pdevice;

 static struct platform_driver fb_driver = {

    .probe = fb_probe,
    .remove = fb_remove,
    .driver = {.name = "rtd2660"}
 };



 static int __init fb_init(void) {



    pdevice = platform_device_alloc("rtd2660", 0);


    if(pdevice) {


       if(platform_device_add(pdevice)) {

          printk("init: cannot add device.\n");
          return -1;
       }
       else printk("init: add device.\n");


    }
    else{

          printk("init: cannot allocate device.\n");
          return -1;
    }



    if(platform_driver_register(&fb_driver)){

       printk("init: cannot register driver.\n");
       return -1;
    }
    else {
           printk("init: register driver.\n");
           return 0;
    }

 }



 static void fb_exit(void) {


    platform_driver_unregister(&fb_driver);

    platform_device_unregister(pdevice);

    printk("exit.\n");
 }


 module_init(fb_init);
 module_exit(fb_exit);

 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("fpga dev");
