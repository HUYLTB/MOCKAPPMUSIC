import QtQuick 2.15
import QtQuick.Window 2.15
import "./View"
import "./JsLibrary/colorbutton.js" as Color
import "./Component"
Item {
    id:itemdata
    property string namechang: "<= "
    property string sourcechang: "qrc:/Screen1.qml"
    Column{
        id:column1
        anchors{
            top:parent.top
            topMargin: 50
        }
        spacing:100
        Rectangle{
            id:rectinf
            width: itemdata.width
            height: 50
            color:Color.colorbackground
            Text {
                id: idtxtif
                text: qsTr("<i>INFORMATION LISTSONG</i>")
                anchors.centerIn: parent
                color:mouseinf.hovered? Color.mousehover: Color.colortext
                scale: mouseinf.hovered?1.2:1
                font{
                    pixelSize: 20
                    bold: true
                }
               QHoverHandler{
               id:mouseinf
               }
            }
        }
        TabBarListSong{
            id:idtabbar
            anchors{
                top: rectinf.bottom
            }
        }
    }
}
