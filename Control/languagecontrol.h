#ifndef LANGUAGECONTROL_H
#define LANGUAGECONTROL_H
#include <QTranslator>
#include <QCoreApplication>
#include <QObject>
#include <QQmlApplicationEngine>
class LanguageControl : public QObject
{
    Q_OBJECT
public:
    explicit LanguageControl(QQmlApplicationEngine *engine,QObject *parent = nullptr);
    Q_INVOKABLE void setlauguage(QString langsrc);
private:
    QQmlApplicationEngine &m_Engine;
};

#endif // LANGUAGECONTROL_H
