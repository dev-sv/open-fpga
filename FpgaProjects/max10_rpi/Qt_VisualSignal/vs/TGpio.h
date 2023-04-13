
#ifndef TGPIO_H
#define TGPIO_H


#include<QTimer>
#include<QFont>
#include<QThread>

#include<stdio.h>
#include<fcntl.h>
#include<unistd.h>
#include<errno.h>



 class TGpio : QThread
 {

    Q_OBJECT


    static const int dbw = 12;  // data bus width.


    int    fd[dbw],
           fd_rd,
           fd_ready,
           fd_soc;

    char   bit,
           ready_sig;

    QTimer tm;
    QFont  font;


    void open_gpio(const QString *ps, int *pfd, unsigned n, const QString& s, int flags);
    void export_gpio(const QString *ps, int *pfd, unsigned n);
    void direction_gpio(const QString& dir, int *pfd, unsigned n);

    virtual void run();


 public:

    unsigned n;
    short    data[1024];


    TGpio();
    ~TGpio();

 };


#endif // TGPIO_H
