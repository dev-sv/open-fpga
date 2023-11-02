


#include <math.h>
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <errno.h>


int main(int argc, char **argv){


 char  *pname = "sin.txt";
 int    fd;
 char   pch[8];
 double i = 0.0, 
        Fs = 1000000.0,		// sampling freq 1 MHz.
        Fin = 2 * M_PI * 50.0;	// input freq 50 Hz.



 fd = open(pname, O_CREAT | O_RDWR | O_TRUNC, 0666);


 if(fd == -1){

    printf("Error open file: %s\n", strerror(errno));
    return -1;
 }
 else printf("open file: %s.\n", pname);


// for(i = 0.0; i < 200.0; i += Fin/Fs){
 for(i = 0.0; i < 20.0; i += Fin/Fs){

     sprintf(pch, "%f", ((sin(i) + 1.0)/2.0) * 3.2);

     pch[7] = '\n';

     write(fd, pch, 8);
 }

 close(fd);

 return 0;
}