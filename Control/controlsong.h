#ifndef CONTROLSONG_H
#define CONTROLSONG_H

#include <QObject>
#include <QMediaPlayer>
#include <QAudioOutput>
#include <QTime>
#include <QString>
#include <QMediaMetaData>
#include <QStringList>
#include <QImage>
#include<QRandomGenerator>
class Controlsong : public QObject
{
    Q_OBJECT
    Q_PROPERTY(qint64 position READ getposition WRITE setposition NOTIFY positionChanged)
    Q_PROPERTY(qint64 duration READ getduration NOTIFY durationChanged)

    Q_PROPERTY(QString positiontext READ getpositiontext NOTIFY positionChanged)
    Q_PROPERTY(QString durationtext READ getdurationtext NOTIFY durationChanged)

    Q_PROPERTY(qreal volume READ getvolume WRITE setvolume NOTIFY volumeChanged)

    Q_PROPERTY(QStringList dataSong READ getdataSong NOTIFY dataSongChanged)

    Q_PROPERTY(QMediaPlayer::PlaybackState  state READ getState  WRITE setState NOTIFY stateChanged)
    Q_PROPERTY(bool imgplaying READ getimgplaying NOTIFY stateChanged)

    Q_PROPERTY(QImage Img READ getImg WRITE setImg NOTIFY ImgChanged)
    Q_PROPERTY(bool singagain READ getsingagain WRITE setsingagain NOTIFY singagainChanged)
public:
    explicit Controlsong(QObject *parent = nullptr);

    QMediaPlayer::PlaybackState getState();
    void setState(const QMediaPlayer::PlaybackState);

    qint64 getposition() const;
    void setposition(const qint64 newposition);

    QString getpositiontext();
    QString getdurationtext();

    qint64 getduration() const;

    qreal getvolume() const;
    void setvolume(const qreal newvolume);

    bool getimgplaying() const;

    bool getsingagain() const;
    void setsingagain(const bool singagainnew);

    Q_INVOKABLE void play();
    Q_INVOKABLE void pause();
    Q_INVOKABLE void stop();
    Q_INVOKABLE bool onplaying();
    Q_INVOKABLE bool onpauseing();
    Q_INVOKABLE void changsingagain();
    Q_INVOKABLE void dragVolume(qreal pos);
    Q_INVOKABLE void dragPosition(qint64 pos1);
    const QStringList &getdataSong() const;



    const QImage &getImg() const;
    void setImg(const QImage &newImg);

signals:
    void stateChanged();
    void endOfSong();
    void volumeChanged();
    void positionChanged(qint64);
    void durationChanged(qint64);
    void singagainChanged();
    void dataSongChanged();

    void songMixChanged();

    void ImgChanged();

public slots:
    void onplaystatusChanged();
    void onSouceChanged(QString,bool);
private:
    QMediaPlayer m_player;
    QAudioOutput *m_audiooutput;
    QStringList m_dataSong;
    bool m_imgplaying;
    QImage m_Img;
};

#endif // CONTROLSONG_H
