#include "controlsong.h"

Controlsong::Controlsong(QObject *parent)
    : QObject{parent}
{
    //  khi thay doi state
    connect(&(this->m_player), SIGNAL(mediaStatusChanged(QMediaPlayer::MediaStatus)),
            this, SLOT(onplaystatusChanged()));
    //
    connect(&(this->m_player), SIGNAL(playbackStateChanged(QMediaPlayer::PlaybackState)),
            this, SIGNAL(stateChanged()));
    //Slider
    connect(&(this->m_player), SIGNAL(positionChanged(qint64)),
            this, SIGNAL(positionChanged(qint64)));

    connect(&(this->m_player), SIGNAL(durationChanged(qint64)),
            this, SIGNAL(durationChanged(qint64)));

    //AudioOutput
    m_audiooutput = new QAudioOutput;
    m_audiooutput->setVolume(0.2);
    m_player.setAudioOutput(m_audiooutput);
}

QMediaPlayer::PlaybackState Controlsong::getState()
{
    return m_player.playbackState();
}

void Controlsong::setState(const QMediaPlayer::PlaybackState state)
{
    if(state != m_player.playbackState()){
        switch (state) {
        case 0 : m_player.stop();
            break;
        case 1 : m_player.play();
            break;
        case 2 : m_player.pause();
            break;
        default:
            break;
        }
        qDebug()<<__FUNCTION__;
    }
}

qint64 Controlsong::getposition() const
{
    return m_player.position();
}

void Controlsong::setposition(const qint64 newposition)
{
    if(newposition != m_player.position()){
        if(newposition > m_player.duration()){
            m_player.setPosition(m_player.duration());
            emit positionChanged(newposition);
        }
        else{
            if(newposition <0) m_player.setPosition(0);
            else {m_player.setPosition(newposition);}
            emit positionChanged(newposition);
        }
    }
}

QString Controlsong::getpositiontext()
{
    int pos1 = getposition();
    int second = (pos1/1000) %60;
    int minutes = (pos1/60000) %60;
    int hour = (pos1/3600000) % 24;
    // qDebug()<<__FUNCTION__<<minutes<<":"<<second;
    return QTime( hour, minutes, second).toString("hh:mm:ss");
}

QString Controlsong::getdurationtext()
{
    int dur1 = getduration();
    int second = (dur1/1000) %60;
    int minutes = (dur1/60000) %60;
    int hour = (dur1/3600000) % 24;
    //qDebug()<<__FUNCTION__<<minutes<<":"<<second;
    return QTime( hour, minutes, second).toString("hh:mm:ss");
}

qint64 Controlsong::getduration() const
{
    return m_player.duration();
}

qreal Controlsong::getvolume() const
{
    return m_audiooutput->volume();
}

void Controlsong::setvolume(const qreal newvolume)
{
    if(newvolume != m_audiooutput->volume()){
        if(newvolume > 1) m_audiooutput->setVolume(1);
        else{
            if(newvolume<0) m_audiooutput->setVolume(0);
            else m_audiooutput->setVolume(newvolume);
        }
    }
    emit volumeChanged();
}

bool Controlsong::getimgplaying() const
{
    return (m_player.playbackState()== QMediaPlayer::PlayingState);
}

bool Controlsong::getsingagain() const
{
    return (m_player.loops() <0);
}

void Controlsong::setsingagain(const bool singagainnew)
{
    if(singagainnew){
        m_player.setLoops(QMediaPlayer::Infinite);
    }
    else{
        m_player.setLoops(QMediaPlayer::Once);
    }
    emit singagainChanged();
    qDebug()<<"Co dang lap:"<<m_player.loops();
}


void Controlsong::play()
{
    qDebug()<<"Dang phat";
    if( !m_player.source().isEmpty()){
        m_player.play();
        qDebug()<<"PLAYING"<<m_player.source();
    }
}

void Controlsong::pause()
{
    if(m_player.playbackState() == QMediaPlayer::PlayingState){
        m_player.pause();
        //emit stateChanged();
        qDebug()<<__FUNCTION__<<m_player.source();
    }
}

void Controlsong::stop()
{
    m_player.stop();
    //emit stateChanged();
    qDebug()<<__FUNCTION__<<m_player.source();
}

bool Controlsong::onplaying()
{
    if(m_player.playbackState() == QMediaPlayer::PlayingState){
        return true;
    }
    return false;
}

bool Controlsong::onpauseing()
{
    if(m_player.playbackState() == QMediaPlayer::PausedState){
        return true;
    }
    return false;
}

void Controlsong::changsingagain()
{
    qDebug()<<__FUNCTION__;
    if(getsingagain()) setsingagain(false);
    else setsingagain(true);
}

void Controlsong::dragVolume(qreal pos)
{
    m_audiooutput->setVolume(pos);
    setvolume(pos);
}

void Controlsong::dragPosition(qint64 pos1)
{
    qDebug()<<__FUNCTION__<<"Cap nhat Position: "<<pos1*getduration();
    m_player.setPosition(pos1*getduration());
    setposition(pos1);
}


void Controlsong::onplaystatusChanged()
{
    qDebug()<<__FUNCTION__;
    if(m_player.mediaStatus() == QMediaPlayer::EndOfMedia){
        emit endOfSong();
    }
    if(m_player.mediaStatus() == QMediaPlayer::LoadedMedia){
        QMediaMetaData songcontent = m_player.metaData();

        m_dataSong = {songcontent.stringValue(QMediaMetaData::Title)
                      , songcontent.stringValue(QMediaMetaData::ContributingArtist)
                      , songcontent.stringValue(QMediaMetaData::Copyright)};
        emit dataSongChanged();
    }
}

void Controlsong::onSouceChanged(QString songpath, bool isOke)
{
    if(isOke ==true )
    {
        m_player.setSource(songpath);
        play();

    }
    else{
        qDebug()<<"Dung ne mii";
        stop();
    }
    qDebug()<<__FUNCTION__<<songpath;
}
const QStringList &Controlsong::getdataSong() const
{
    return m_dataSong;
}



const QImage &Controlsong::getImg() const
{
    return m_Img;
}

void Controlsong::setImg(const QImage &newImg)
{
    if (m_Img == newImg)
        return;
    m_Img = newImg;
    emit ImgChanged();
}
