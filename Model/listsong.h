#ifndef LISTSONG_H
#define LISTSONG_H

#include <QObject>
#include <QAbstractListModel>
#include <QDir>
#include <QUrl>
#include <QMediaPlayer>
#include <QMediaMetaData>
struct ListSongItem
{
    ListSongItem() :name(), filePath(),isFavorite(0){}
    ListSongItem(const QString &p_Name, const QString &p_FilePath,  bool p_isFavorite)
        :name(p_Name),filePath(p_FilePath), isFavorite(p_isFavorite)
    {
    }
    bool setName(const QString &p_Name){
        if(name == p_Name){
            return false;
        }
        name = p_Name;
        return true;
    }
    bool setFilePath(const QString &p_FilePath){
        if(filePath == p_FilePath){
            return false;
        }
        filePath = p_FilePath;
        return true;
    }
    bool setisFavorite(const bool &p_isFovorite){
        if(isFavorite == p_isFovorite){
            return false;
        }
        isFavorite = p_isFovorite;
        return true;
    }
    //kiem tra de ko chon folder trùng đương dẫn
    bool operator==(const QString fpath){
        return (filePath==fpath);
    }
    //sort
    bool operator>(const ListSongItem &item){

        return QString::compare(name, item.name) > 0;
    }
    bool operator<(const ListSongItem &item){
        return QString::compare(name, item.name) < 0;
    }
    QString name;
    QString filePath;
    bool isFavorite;


};
class Listsong : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(int currenIndex READ getcurrenIndex WRITE setcurrenIndex NOTIFY currenIndexChanged)
    Q_PROPERTY(bool songMix READ getsongMix WRITE setsongMix NOTIFY songMixChanged)
    Q_PROPERTY(QStringList loveSong READ getloveSong WRITE setloveSong NOTIFY loveSongChanged)
public:
    explicit Listsong(QObject *parent = nullptr);

    enum ListSongRole{
        NameRole = Qt::UserRole+1,
        FilePathRole,IsFavorite
    };
    //QString
    // QAbstractItemModel interface
    int rowCount(const QModelIndex &parent) const override;
    QVariant data(const QModelIndex &index , int role) const override;
    bool setData(const QModelIndex &index , const QVariant &value , int role = Qt::EditRole) override;

    void insertSong(const QList<ListSongItem> &data,bool value);
    void clear();
    void clearlovesong();

    //index
    int getcurrenIndex() const;

    //Giao tiep vs QML
    void setcurrenIndex(const int  newcurrenIdex);
    Q_INVOKABLE void onsetsongMix();
    Q_INVOKABLE void setFavorite(int currenIndexlove);
    Q_INVOKABLE void playlovesong(int p_indexLove);
    Q_INVOKABLE void sortsong(bool value);

    bool getsongMix() const;
    void setsongMix(bool newSongMix);
    void upDateOne(int currenIndex, ListSongItem item);
    const QStringList &getloveSong() const;
    void setloveSong(const QStringList &newLoveSong);

protected:
    QHash<int, QByteArray> roleNames() const override ;
signals:
    void songSelected(int p_Index , const ListSongItem &p_Item);
    void currenIndexChanged(bool value);
    void sourceChangle(QString path, bool isOke);
    void songMixChanged();

    void loveSongChanged();

    void LoveChanged();

public slots:
    void onendofSong();
    void onCurrenIndexChanged();
private:
    int m_currenIndex = -1;
    QList<ListSongItem> m_Data;
    QHash<int , QByteArray> m_roleNames;
    bool m_songMix = false;
    QStringList m_loveSong;
};

#endif // LISTSONG_H
