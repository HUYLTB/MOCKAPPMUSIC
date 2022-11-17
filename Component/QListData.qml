import QtQuick 2.15
import QtMultimedia
import "../JsLibrary/colorbutton.js" as Color
import "../JsLibrary/QSourceTab.js" as Tabar
ListView{
    property int m_width;
    property int m_heigh;
    property variant textdata

    id:idplaylistsinger
    model: Model
    height: m_heigh//parent.height
    width: m_width;//parent.width-20
    //anchors.centerIn: parent.horizontalCenter
    currentIndex: Model.currenIndex
    spacing: 10
    delegate:
        Rectangle{
        height: idtxtsinger.implicitHeight * idtxtsinger.scale
        width: idrectsong.width-20
        color: Color.mousehover
        border.color: mousestextsongname.hovered?Color.colorborder:Color.colortext
        radius: height/2
        Text {
            id: idtxtsinger
            text:m_playerdata.metaData.stringValue(textdata)
            anchors.left: parent.left
            anchors.leftMargin: 5
            focus: index == idplaylistsinger.currentIndex? true : false
            font.pixelSize: 15
            font.italic: true     
            color: focus? Color.colorborders : Color.colortext
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
        }
        MouseArea{
            id:moselistclick
            anchors.fill: parent
            onClicked: {
                Model.currenIndex = index;
            }
        }
        MediaPlayer{
            id:m_playerdata
            source: SongLocation
        }
        HoverHandler {
            id: mousestextsongname
            acceptedDevices: PointerDevice.Mouse
            cursorShape: Qt.OpenHandCursor
        }
    }
}
