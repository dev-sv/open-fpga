

#ifndef TVISUAL_H
#define TVISUAL_H


#include<QWidget>
#include<QFont>
#include<QLabel>
#include<QTimer>
#include<QString>
#include<QPaintEvent>
#include<QPainter>
#include<QPalette>


#include "TGpio.h"


class TVisual : public QWidget
{

    Q_OBJECT

    TGpio gpio;

    QFont       font;
    QLabel      lb_U;
    QTimer      tm_U;
    QString     lb_str;
    QPalette    pl_U;

    short Umax, U;

    double  vpd;          // volt per digit.

    unsigned y;

    short vdata[1024];

    void paintEvent(QPaintEvent *event);


public:

    TVisual();
    virtual ~TVisual(){}


public slots:

    void U_slot();


};

#endif // TVISUAL_H
