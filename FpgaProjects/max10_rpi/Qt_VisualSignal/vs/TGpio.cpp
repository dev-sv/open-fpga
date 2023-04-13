

#include"TGpio.h"



TGpio::TGpio() : bit(0), n(0)
 {


    const QString rd =    "gpio23",
                  soc =   "gpio25",
                  ready = "gpio24";


    const QString dbus[dbw] = { "gpio21", "gpio20", "gpio16", "gpio12",
                                "gpio7",  "gpio8",  "gpio11", "gpio5",
                                "gpio6",  "gpio13", "gpio19", "gpio26"
                              };


    for(int i = 0; i < 1024; ++i)
        data[i] = 0;


 try
 {


/* data bus. */

// export.
    open_gpio(dbus, fd, dbw, "export", O_WRONLY);

    export_gpio(dbus, fd, dbw);

// direction.
    open_gpio(dbus, fd, dbw, "/direction", O_WRONLY);

    direction_gpio("in", fd, dbw);

// value.
    open_gpio(dbus, fd, dbw, "/value", O_RDONLY | O_NONBLOCK);



/* signal RD gpio23. */

    open_gpio(&rd, &fd_rd, 1, "export", O_WRONLY);

    export_gpio(&rd, &fd_rd, 1);

    open_gpio(&rd, &fd_rd, 1, "/direction", O_WRONLY);

    direction_gpio("out", &fd_rd, 1);

    open_gpio(&rd, &fd_rd, 1, "/value", O_WRONLY);



/* signal READY. gpio24 */

    open_gpio(&ready, &fd_ready, 1, "export", O_WRONLY);

    export_gpio(&ready, &fd_ready, 1);

    open_gpio(&ready, &fd_ready, 1, "/direction", O_WRONLY);

    direction_gpio("in", &fd_ready, 1);

    open_gpio(&ready, &fd_ready, 1, "/value", O_RDONLY);



/* signal SOC (start of converting). gpio25 */

    open_gpio(&soc, &fd_soc, 1, "export", O_WRONLY);

    export_gpio(&soc, &fd_soc, 1);

    open_gpio(&soc, &fd_soc, 1, "/direction", O_WRONLY);

    direction_gpio("out", &fd_soc, 1);

    open_gpio(&soc, &fd_soc, 1, "/value", O_WRONLY);

 }

 catch(QString e)
 {

    printf("%s\n", e.toLocal8Bit().data());

    _exit(1);
 }


// start of converting ADC.

    if(write(fd_soc, "1", 1) <= 0){

       printf("\n error set soc to ""1"": %s\n", strerror(errno));
       _exit(1);
    }

    start();
 }



 TGpio::~TGpio()
 {

    close(fd_rd);
    close(fd_soc);
    close(fd_ready);

    for(int i = 0; i < dbw; ++i)
        close(fd[i]);
 }




void TGpio::run()
{


 while(1){


// data ready.

    lseek(fd_ready, 0, SEEK_SET);

    if(read(fd_ready, &ready_sig, 1) <= 0){

       printf("\n error ready: %s\n", strerror(errno));
       _exit(1);
    }


// get data of FPGA.

    if(ready_sig == 0x31){


       if(write(fd_rd, "1", 1) <= 0){

          printf("\n error set rd to ""1"": %s\n", strerror(errno));
          _exit(1);
       }


       lseek(fd[0], 0, SEEK_SET);
       read(fd[0], &bit, 1);
       data[n] = (bit & 0x1) ? data[n] | (1 << 0) : data[n] & (~(1 << 0));

       lseek(fd[1], 0, SEEK_SET);
       read(fd[1], &bit, 1);
       data[n] = (bit & 0x1) ? data[n] | (1 << 1) : data[n] & (~(1 << 1));

       lseek(fd[2], 0, SEEK_SET);
       read(fd[2], &bit, 1);
       data[n] = (bit & 0x1) ? data[n] | (1 << 2) : data[n] & (~(1 << 2));

       lseek(fd[3], 0, SEEK_SET);
       read(fd[3], &bit, 1);
       data[n] = (bit & 0x1) ? data[n] | (1 << 3) : data[n] & (~(1 << 3));

       lseek(fd[4], 0, SEEK_SET);
       read(fd[4], &bit, 1);
       data[n] = (bit & 0x1) ? data[n] | (1 << 4) : data[n] & (~(1 << 4));

       lseek(fd[5], 0, SEEK_SET);
       read(fd[5], &bit, 1);
       data[n] = (bit & 0x1) ? data[n] | (1 << 5) : data[n] & (~(1 << 5));

       lseek(fd[6], 0, SEEK_SET);
       read(fd[6], &bit, 1);
       data[n] = (bit & 0x1) ? data[n] | (1 << 6) : data[n] & (~(1 << 6));

       lseek(fd[7], 0, SEEK_SET);
       read(fd[7], &bit, 1);
       data[n] = (bit & 0x1) ? data[n] | (1 << 7) : data[n] & (~(1 << 7));

       lseek(fd[8], 0, SEEK_SET);
       read(fd[8], &bit, 1);
       data[n] = (bit & 0x1) ? data[n] | (1 << 8) : data[n] & (~(1 << 8));

       lseek(fd[9], 0, SEEK_SET);
       read(fd[9], &bit, 1);
       data[n] = (bit & 0x1) ? data[n] | (1 << 9) : data[n] & (~(1 << 9));

       lseek(fd[10], 0, SEEK_SET);
       read(fd[10], &bit, 1);
       data[n] = (bit & 0x1) ? data[n] | (1 << 10) : data[n] & (~(1 << 10));

       lseek(fd[11], 0, SEEK_SET);
       read(fd[11], &bit, 1);
       data[n] = (bit & 0x1) ? data[n] | (1 << 11) : data[n] & (~(1 << 11));


       if(write(fd_rd, "0", 1) <= 0){

          printf("\n error set rd to ""0"": %s\n", strerror(errno));
          _exit(1);
       }


       if(n == 1023)
          n = 0;

       else ++n;
    }
 }

}



 void TGpio::open_gpio(const QString *ps, int *pfd, unsigned n, const QString& s, int flags)
 {


    QString path;


    for(unsigned i = 0; i < n; ++i){

        path = "/sys/class/gpio/";

        if(s != "export")
           path = path.append(ps[i]);

        path = path.append(s);

        pfd[i] = open(path.toLocal8Bit().data(), flags);


        if(pfd[i] == -1)

           throw("error open: " + path);
    }
 }



 void TGpio::export_gpio(const QString *ps, int *pfd, unsigned n)
 {

    for(unsigned i = 0; i < n; ++i){

        if(write(pfd[i], ps[i].section("gpio", 1, 2).toLocal8Bit().data(), ps[i].section("gpio", 1, 2).toLocal8Bit().length()) <= 0)

           throw("error export: " + ps[i]);
    }
 }



 void TGpio::direction_gpio(const QString& dir, int *pfd, unsigned n)
 {

    for(unsigned i = 0; i < n; ++i){

        if( (write(pfd[i], dir.toLocal8Bit().data(), dir.toLocal8Bit().length())) <= 0)

           throw("error direction: " + dir.toLocal8Bit());
    }
 }
