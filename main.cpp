#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"
//#include <android/window.h>
//#include <android/native_activity.h>


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QtQuick2ApplicationViewer viewer;
    viewer.setMainQmlFile(QStringLiteral("qml/tutifruti/main.qml"));
    viewer.showExpanded();


//    ANativeActivity *activity;
//    ANativeActivity_setWindowFlags(activity, AWINDOW_FLAG_KEEP_SCREEN_ON,0);

    return app.exec();
}
