import QtQuick 2.15
import "../Component"
import "../JsLibrary/colorbutton.js" as Color
Row{
    property variant m_mute
    property variant m_volume
    property bool onMute: true;
    spacing: 20
    Image {
        id: imgvolumemute
        source:controlsong.volume? m_volume : m_mute
        anchors.verticalCenter: parent.verticalCenter
        scale: mousemute.hovered? 1.2 : 1
        MouseArea{
            anchors.fill: parent
            onClicked: {
               controlsong.volume= onMute? 0: 0.2;
                onMute=!onMute
            }
        }
        QHoverHandler{
        id:mousemute
        }
    }
    Text {
        id: textvolume
        text: (idsliderVolume.m_valuechange*100).toFixed(1) + "%"
        color: Color.colortext
        anchors.verticalCenter: parent.verticalCenter
    }
    QSlider{
        id:idsliderVolume
        maxwidth: root.width/9
        maxheight: 10
        m_valuechange: controlsong.volume
        m_valuesave: 1
        onM_onvaluechang:(value) =>
                         {
                             controlsong.dragVolume(value)
                         }
    }
}
