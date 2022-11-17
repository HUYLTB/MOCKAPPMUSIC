#include "dirdialog.h"
#include <QUrl>
Dirdialog::Dirdialog(Listsong *model,QWidget *p_Widget,QObject *parent)
    : QObject{parent}, m_Model(*model), m_FileDialog(p_Widget)
{
    m_FileDialog.setDirectoryUrl(QUrl("C:\\Users\\Admin"));
    m_FileDialog.setNameFilter("*.mp3 *.mp4 *.wav *.aif *.mid");
    m_FileDialog.setViewMode(QFileDialog::Detail);

    connect(&m_FileDialog , &QFileDialog::urlSelected,this , &Dirdialog::onDirectUrl);
    connect(&m_FileDialog , &QFileDialog::accepted, this,&Dirdialog::onOpen);
}

void Dirdialog::openfile(bool flag)
{
    qDebug() << __FUNCTION__ ;
    m_FileDialog.setFileMode(flag? QFileDialog::Directory : QFileDialog::ExistingFiles );
    m_FileDialog.open();
}

void Dirdialog::clear()
{
}

void Dirdialog::onOpen()
{
    qDebug() << __FUNCTION__ << m_DirUrl.toString();
    QDir directory(m_DirUrl.toLocalFile());
    QList<ListSongItem> data;
    if(m_FileDialog.fileMode() == QFileDialog::Directory){
        QStringList audioList = directory.entryList(QStringList()<<"*.mp3" << "*.mp4" << "*.wav" <<"*.aif" << "*.mid",QDir::Files);
        qDebug() << audioList;
        for(const QString& fileName : audioList){
            data.append(ListSongItem(fileName,m_DirUrl.toString()+ "/"+ fileName,false));
        }
         m_Model.insertSong(data,1);
    }
    else{
        QStringList audioList = m_FileDialog.selectedFiles();
        for(const QString& fileName : audioList){
            data.append(ListSongItem(QUrl(fileName).fileName(),fileName,false));
        }
        m_Model.insertSong(data,0);
    }


    m_FileDialog.close();
}

void Dirdialog::onDirectUrl(const QUrl &p_Url)
{
    qDebug()<<__FUNCTION__;
    m_DirUrl = p_Url;
}
