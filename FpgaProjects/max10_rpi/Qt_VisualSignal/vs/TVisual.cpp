

#include "TVisual.h"


TVisual::TVisual() : font("Helvetica", 64, QFont::Bold), Umax(0), U(0), vpd(3.3/4095), y(150)
{

    resize(1024, 600);

    setWindowFlags(Qt::FramelessWindowHint);

    for(unsigned i = 0; i < 1024; ++i)
        vdata[i] = 0;


    lb_U.setParent(this);
    lb_U.setFont(font);
    lb_U.resize(120, 25);
    lb_U.move(15, 12);
    pl_U.setColor(QPalette::WindowText, QColor(0, 240, 255));
    lb_U.setPalette(pl_U);

    connect(&tm_U, SIGNAL(timeout()), this, SLOT(U_slot()));

    tm_U.start(100);
}



void TVisual::paintEvent(QPaintEvent *event)
{

    QPainter paint(this);
    paint.setRenderHint(QPainter::Antialiasing, true);

    paint.fillRect(0, 0, 1024, 600, Qt::black);

    paint.setPen(QPen(Qt::yellow, 0, Qt::SolidLine));


    for(int j = 0; j < 1023; ++j){


        QLine Line(j, (y + 100) - (gpio.data[j] * y/4095), j + 1, (y + 100) - (gpio.data[j + 1] * y/4095));

        paint.drawLine(Line);
    }

     update();
}



void TVisual::U_slot()
{

    if(U != Umax)
       Umax = U;

    U = 0;

    for(int j = 0; j < 1023; ++j){

        if(gpio.data[j] > U)
           U = gpio.data[j];
    }

    lb_U.setText("U = " + lb_str.setNum(((double)Umax * vpd), 'g', 2) + " v");
}

