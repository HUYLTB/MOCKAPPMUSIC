#include "listsong.h"

Listsong::Listsong(QObject *parent)
    : QAbstractListModel(parent)
{
    m_roleNames[NameRole] = "SongName";
    m_roleNames[FilePathRole] = "SongLocation";
    m_roleNames[IsFavorite] = "IsFavorite";
    connect(this,&Listsong::currenIndexChanged,
            this,&Listsong::onCurrenIndexChanged);
}


QHash<int, QByteArray> Listsong::roleNames() const
{
    qDebug()<<__FUNCTION__;
    return m_roleNames;
}

void Listsong::onendofSong()
{
    qDebug()<<__FUNCTION__<<m_songMix;
    if(m_currenIndex < m_Data.count() -1 ){
        if (m_songMix) setcurrenIndex(rand() % m_Data.count());
        else setcurrenIndex(m_currenIndex+1);}
    else{
        qDebug()<<"Hat bai cuoi";
    }
}

void Listsong::onCurrenIndexChanged()
{
    //    if(value){
    if(m_currenIndex==-1){
        emit sourceChangle("",true);
    }
    else{
        emit sourceChangle(m_Data.at(m_currenIndex).filePath,true);
    }
    //}
    //    else {
    //        if(m_currenIndex==-1){
    //            emit sourceChangle("",true);
    //        }
    //        else{
    //            emit sourceChangle(m_loveSong[m_currenIndex],true);
    //        }
    //    }

}

int Listsong::rowCount(const QModelIndex &parent = QModelIndex()) const
{
    qDebug()<<__FUNCTION__;
    if(parent.isValid())
    {
        return 0;
    }
    return m_Data.count();
}

QVariant Listsong::data(const QModelIndex &index, int role) const
{
    qDebug()<<__FUNCTION__;
    if(!index.isValid()){
        return QVariant();
    }
    const ListSongItem &item = m_Data[index.row()];
    switch (role) {
    case NameRole:
        return item.name;
    case FilePathRole:
        return item.filePath;
    case IsFavorite:
        return item.isFavorite;
    default:
        return QVariant();
    }
}

bool Listsong::setData(const QModelIndex &index, const QVariant &value, int role)
{
    qDebug()<<__FUNCTION__;
    if(!index.isValid()){
        return false;
    }
    ListSongItem &item = m_Data[index.row()];
    switch (role) {
    case NameRole:
        return item.setName(value.toString());
    case FilePathRole:
        return item.setFilePath(value.toString());
    case IsFavorite:
        return item.setisFavorite(value.toBool());
    default:
        return false;
    }
}

void Listsong::insertSong(const QList<ListSongItem> &data,bool value)
{
    qDebug() << __FUNCTION__;
    if(value){
        qDebug()<<"Xoa folder cu";
        clear();
        //Xoa danh sach yeu thich cu cua folder cu
        clearlovesong();
        setcurrenIndex(-1);
    }
    for(ListSongItem temp : data){
        auto itr=std::find(m_Data.begin(),m_Data.end(),temp.filePath);//tim kiem duong dan de no ko cho path vào
        if(itr ==m_Data.end()){
            beginInsertRows(QModelIndex(), rowCount(), rowCount()+ data.length()-1);
            m_Data +=data;
            endInsertRows();
        }
    }
}

void Listsong::clear()
{
    qDebug()<<__FUNCTION__;
    qDebug()<<"Da xoa folder";
    beginRemoveRows(QModelIndex(), 0, rowCount());
    m_Data.clear();
    endRemoveRows();
    emit layoutChanged();
}

void Listsong::clearlovesong()
{
    qDebug()<<__FUNCTION__;
    m_loveSong.clear();
    emit loveSongChanged();
    emit layoutChanged();
}

int Listsong::getcurrenIndex() const
{
    return m_currenIndex;
}

void Listsong::setcurrenIndex(const int newcurrenIdex)
{
    //    if(value){
    if(m_currenIndex != newcurrenIdex && newcurrenIdex < m_Data.count()){
        m_currenIndex = newcurrenIdex;
        emit currenIndexChanged(1);
    }
    //}
    //    else{
    //        if(m_currenIndex != newcurrenIdex && newcurrenIdex < m_loveSong.length()){
    //            m_currenIndex = newcurrenIdex;
    //            emit currenIndexChanged(0);

    //        }
    //    }
}

void Listsong::onsetsongMix()
{
    qDebug()<<"Da Chuyen bài lon xon";
    setsongMix(!m_songMix);
    onendofSong();
}

void Listsong::setFavorite(int p_Index)
{
    m_Data[p_Index].isFavorite = !m_Data[p_Index].isFavorite;

    const auto itr = std::find(m_loveSong.begin(), m_loveSong.end(),m_Data.at(p_Index).filePath);//cai nay quan trọng
    if (itr != m_loveSong.end()){
        qDebug()<<__FUNCTION__<<"Da xoabaihat";
        m_loveSong.removeOne(*itr);//xoa bai hat yeu thich
        qDebug() << m_loveSong.length();
    }
    else{
        m_loveSong+=m_Data[p_Index].filePath;//them bai hat yeu thich
        qDebug()<<__FUNCTION__<<"Da yeu thich bai hat";
    }
    upDateOne(p_Index, m_Data[p_Index]);
    emit loveSongChanged();
    emit layoutChanged();
}

void Listsong::playlovesong(int p_indexLove)
{
    //play bai hat songlove
    setcurrenIndex(-1);
    emit sourceChangle(m_loveSong[p_indexLove],true);

}

void Listsong::sortsong(bool value)
{
    if (value)
    {
        std::sort(m_Data.begin(), m_Data.end(), [](ListSongItem a, ListSongItem b) ->bool{return a > b;});
    }
    else
    {
       std::sort(m_Data.begin(), m_Data.end(), [](ListSongItem a, ListSongItem b) ->bool{return a < b;});
    }
    emit layoutChanged();
}



bool Listsong::getsongMix() const
{
    return m_songMix;
}

void Listsong::setsongMix(bool newSongMix)
{
    if (m_songMix == newSongMix)
        return;
    m_songMix = newSongMix;
    emit songMixChanged();
}


void Listsong::upDateOne(int currenIndex, ListSongItem item)
{
    qDebug() << __FUNCTION__;
    //doi mau tai vi tri Index
    m_Data[currenIndex] = item;
    emit dataChanged(index(currenIndex), index(currenIndex));
}

const QStringList &Listsong::getloveSong() const
{
    return m_loveSong;
}

void Listsong::setloveSong(const QStringList &newLoveSong)
{
    qDebug()<<"Set lai yeu thich";
    if (m_loveSong == newLoveSong)
        return;
    m_loveSong = newLoveSong;
    emit loveSongChanged();
}


