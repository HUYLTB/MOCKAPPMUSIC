import QtQuick 2.15
import "./View"
import "./JsLibrary/libraryImg.js" as Img
import "./JsLibrary/colorbutton.js" as Color
import "./Component"
Item {
    property string namechang: " =>"
    property string sourcechang: "qrc:/Screen2.qml"
    //xoay hình
    RotationImg{
        id:rectimg
        anchors.left: parent.left
        anchors.leftMargin: parent.height/10//70
        anchors.top: parent.top
        anchors.topMargin: parent.height/7//100
        imgrotation: Img.imgrouting
    }
    ControlButton{
        id:imgbutton
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height/14//50
    }
    //Sliersong
    SliderSong{
        id:idslidersong
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: imgbutton.top
        anchors.bottomMargin: parent.width/45//20
    }
    //ListSong
    ListSongView{
        id:rectlistsong
        anchors.right: parent.right
        anchors.rightMargin: parent.height/10//70
        anchors.top: parent.top
        anchors.topMargin: parent.width/7.5//120
        currenIndex: Model.currenIndex
        z:10
    }
    //ListData
    ListData{
        id:rectlistsongdata
        visible: controlsong.imgplaying? true: false
        anchors{
            right: parent.right
            rightMargin: parent.height/10
        }
        NumberAnimation  {
            target: rectlistsongdata
            property: "y"
            from: rectlistsong.anchors.topMargin
            to: rectlistsong.anchors.topMargin-(root.height/7-20)
            duration: 15000;
            running: controlsong.imgplaying? true: false
        }

    }
    //SliderVolume
    SliedVolume{
        id:idSlidervolume
        anchors.right: parent.right
        anchors.rightMargin:parent.height/7//100
        anchors.top: rectlistsong.bottom
        anchors.bottom: idslidersong.top
        m_mute: Img.imgmute
        m_volume: Img.imgvolume
    }
    //Animation Text play
    Rectangle {
        id: rectsongplay
        border.width: 2
        width: parent.height/3.5//200
        height: parent.height/28//25
        color: Color.mousehover
        visible: controlsong.imgplaying? true: false
        anchors{
            top:parent.top
            topMargin:parent.height/28//25
        }
        radius: width/20//10
        clip: true
        Row{
            NumberAnimation on x {
                id:animation1
                from: rectsongplay.width;
                to: -text1.width;
                duration: 10000;
                loops: Animation.Infinite
                running: controlsong.imgplaying?true:false
            }
            Text { id: text1;
                text: qsTr("Playing:")+" "+controlsong.dataSong[0]
                color:controlsong.imgplaying?Color.colorborder : Color.colortext
                font{
                    bold: true
                    family: "Ink Free"
                    pixelSize: rectsongplay.height-10//15
                }
            }
        }
    }
    //about App
    Rectangle{
        id:idrectabout
        width: parent.width/3//300
        height: parent.height/7//100
        anchors{
            centerIn: parent
        }
        radius: height/10
        z:20
        visible: isVisibleAbout
        Column{
            width: parent.width
            height: parent.height
            anchors{
                top: parent.top
            }
            Image {
                id: imgcopyrihgt
                anchors{
                    left: parent.left
                    leftMargin: parent.width/2.5
                }
                source: Img.imgcopyright
            }
            Text {
                id: idtext
                anchors{
                    left: parent.left
                    leftMargin: parent.width/2.5
                }
                text: qsTr("Version 0")
            }
            Text {
                anchors{
                    left: parent.left
                    leftMargin: parent.width/6
                }
                text: "https://www.facebook.com/baohuyitachi"
                scale: mousecopy.hovered? 1.2 : 1
                color: "green"
                QHoverHandler{
                    id:mousecopy
                }
            }
        }
    }
}
