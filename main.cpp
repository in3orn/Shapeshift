#include <QApplication>
#include <VPApplication>

#include <QQmlApplicationEngine>


int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    VPApplication vplay;

    QQmlApplicationEngine engine;
    vplay.initialize(&engine);

//    vplay.setMainQmlFileName(QStringLiteral("qml/Main.qml"));
    vplay.setMainQmlFileName(QStringLiteral("qrc:/qml/Main.qml"));

    engine.load(QUrl(vplay.mainQmlFileName()));

    return app.exec();
}

