#ifndef DIRDIALOG_H
#define DIRDIALOG_H

#include <QObject>
#include <QFileDialog>
#include <QStandardPaths>
#include "listsong.h"
class Dirdialog : public QObject
{
    Q_OBJECT
public:

    explicit Dirdialog(Listsong *listsong, QWidget *p_Widget = nullptr,QObject *parent = nullptr);

    Q_INVOKABLE void openfile(bool);
    void clear();
signals:
    void listmodelDataChanged(QList<ListSongItem> p_List);

public slots:
    void onOpen();
    void onDirectUrl(const QUrl &p_Url);

private:
    Listsong &m_Model;
    QFileDialog m_FileDialog;
    QUrl m_DirUrl;

};

#endif // DIRDIALOG_H
