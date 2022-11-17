import QtQuick 2.15
import "../JsLibrary/colorbutton.js" as Color
import "../JsLibrary/QSourceTab.js" as Tabar
import "../View"
import "../Component"
Rectangle{
    width: recttabsource.width
    height:recttabsource.height
    color: Color.colorbackground
    clip:true
    ListView{
        id:idplaylistlove
        model: Model.loveSong
        anchors{
            left: parent.left
            right: parent.right
        }
        height: parent.height
        spacing: 10
        delegate:
            Rectangle{
            height: idtxtsongname.implicitHeight * idtxtsongname.scale
            width: idrectsong.width-20
            color:  Color.mousehover
            border.color: mousestextsongname.hovered? Color.colorborder : Color.colortext
            radius: height/2
            clip:true
            Text {
                id: idtxtsongname
                text:modelData
                anchors.left: parent.left
                anchors.leftMargin: 5
                font.pixelSize: 15
                font.italic: true
                color: Color.colortext
                elide: Text.ElideRight
                verticalAlignment: Text.AlignVCenter
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    Model.playlovesong(index);
                    controlsong.play();

                }
            }
            QHoverHandler
            {
                id: mousestextsongname
            }
        }
    }
}
