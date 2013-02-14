#include <QtGui/QApplication>
#include <QIcon>
#include <QDeclarativeContext>
#include "qmlapplicationviewer.h"
#include "encalc.h"
#include "calculator.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));
    QScopedPointer<QmlApplicationViewer> viewer(QmlApplicationViewer::create());

    QApplication::setApplicationName("Encalc");
    QApplication::setApplicationVersion("beta 0.1");
    QApplication::setOrganizationName("it-s & dridk");


    Encalc * myApp = new Encalc;
    Calculator * calculator = new Calculator;


    viewer->rootContext()->setContextProperty("myApp",myApp);
    viewer->rootContext()->setContextProperty("calculator",calculator);
    viewer->rootContext()->setContextProperty("historyModel",calculator->model());


    viewer->setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer->setMainQmlFile(QLatin1String("qml/Encalc/main.qml"));
    viewer->setMinimumSize(640,400);
    viewer->setBaseSize(640,400);
    viewer->setMaximumSize(640,400);
    viewer->showExpanded();
    viewer->setWindowIcon(QIcon(":encalc.png"));


    return app->exec();
}
