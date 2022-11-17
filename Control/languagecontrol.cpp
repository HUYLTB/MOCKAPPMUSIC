#include "languagecontrol.h"

LanguageControl::LanguageControl(QQmlApplicationEngine *engine,QObject *parent)
    : QObject{parent},m_Engine(*engine)
{

}

void LanguageControl::setlauguage(QString langsrc)
{
    QTranslator translator;
    if(translator.load(langsrc,":/")){
        QCoreApplication::installTranslator(&translator);

    }
    m_Engine.retranslate();
}
