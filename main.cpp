#include <QApplication>
#include <QQmlApplicationEngine>
#include <QIcon>
#include <QQmlContext>
#include "./Model/listsong.h"
#include "./Control/controlsong.h"
#include "./Model/dirdialog.h"
#include "./Control/languagecontrol.h""
#include <QDebug>
int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QApplication app(argc, argv);
    Listsong listsong;
    Dirdialog dirdialog(&listsong);
    Controlsong controlsong;

    QObject::connect(&listsong,&Listsong::sourceChangle,
                     &controlsong,&Controlsong::onSouceChanged);
    QObject::connect(&controlsong,&Controlsong::endOfSong,
                     &listsong,&Listsong::onendofSong);


    QQmlApplicationEngine engine;
    LanguageControl language(&engine);
    QQmlContext *appContextRoot = engine.rootContext();
    appContextRoot->setContextProperty("dirdialog",&dirdialog);
    appContextRoot->setContextProperty("Model",&listsong);
    appContextRoot->setContextProperty("controlsong",&controlsong);
    appContextRoot->setContextProperty("Trans",&language);
    app.setWindowIcon(QIcon(":/img/iconapp.png"));

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);
    return app.exec();
}
