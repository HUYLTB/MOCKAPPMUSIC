import QtQuick 2.15
import "../JsLibrary/colorbutton.js" as Color
import "../JsLibrary/QSourceTab.js" as Tabar
import "../View"
import "../Component"
import QtMultimedia
Rectangle{
    width: recttabsource.width
    height:recttabsource.height
    color: Color.colorbackground
    clip:true
    QListData{
        m_width: parent.width-20
        m_heigh: parent.height
        textdata: MediaMetaData.ContributingArtist
    }
}
