

#include <QApplication>
#include "TVisual.h"

int main(int argc, char *argv[])
{

    QApplication a(argc, argv);

    TVisual vs;

    vs.show();

    return a.exec();
}
