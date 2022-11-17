import QtQuick 2.15
import "../JsLibrary/colorbutton.js" as Color
import "../JsLibrary/libraryImg.js" as Img
import "../Component"
Rectangle{
    property int currenIndex;
    property bool sortchanged: false
    id:idrectsong
    width: root.width/2.5
    height: root.height/2.5
    border.color: Color.colortext
    color: Color.colorhover
    radius: 10
    Column{
        spacing:20
        Row{
            Rectangle{
                id:rectnamesong
                width: idrectsong.width*2/4
                height: 20
                color:Color.colorbackground
                clip:true
                Text {
                    anchors.centerIn: parent
                    text: qsTr("<i>SONG NAMES</i>")
                    font{
                        bold: true
                        pixelSize: 15
                    }
                    color:idmousename.hovered? Color.mousehover: Color.colortext
                    QHoverHandler{
                        id:idmousename
                    }
                }
            }
            // Music love
            Rectangle{
                id:idmyfavorite
                width: idrectsong.width*1.5/4
                height: 20
                color:Color.colorbackground
                clip:true
                Text {
                    anchors.centerIn: parent
                    text: qsTr("<i>FAVORITE</i>")
                    font{
                        bold: true
                        pixelSize: 15
                    }
                    color:idmouselove.hovered? Color.mousehover: Color.colortext
                    QHoverHandler{
                        id:idmouselove
                    }
                }
            }
            //Săp xep
            Rectangle{
                width: idrectsong.width-idmyfavorite.width-rectnamesong.width-2
                height: 20
                color:Color.colorbackground
                Image {
                    id: imgsort
                    anchors.centerIn: parent
                    scale: mousesort.hovered? 0.8: 0.4
                    source: Img.imgsort
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        Model.sortsong(sortchanged)
                        sortchanged=!sortchanged
                    }
                }
                QHoverHandler{
                    id:mousesort
                }
            }
        }
        Rectangle{
            id:rectinsong
            width: idrectsong.width
            height: idrectsong.height-rectnamesong.height-20
            color:Color.colorbackground
            clip:true
            ListView{
                id:idplaylist
                model: Model
                anchors{
                    left: parent.left
                    leftMargin: 10
                    right: parent.right
                    rightMargin: 10
                }
                height: parent.height
                currentIndex: currenIndex
                spacing: 10
                delegate:
                    Row {
                    Rectangle{
                        id:rectsongname
                        height: idtxtsongname.implicitHeight * idtxtsongname.scale
                        width: rectinsong.width*2/3
                        color: Color.mousehover
                        border.color: mousestextsongname.hovered?Color.colorborder:Color.colortext
                        scale: mousestextsongname.hovered? 1.1 : 1
                        radius: height/2
                        clip:true
                        Text {
                            id: idtxtsongname
                            text:SongName
                            anchors.left: parent.left
                            anchors.leftMargin: 5
                            font{
                                italic: true
                                pixelSize: 15
                            }
                            color:  index==idplaylist.currentIndex?Color.colorborder : Color.colortext
                            elide: Text.ElideRight
                            verticalAlignment: Text.AlignVCenter
                        }

                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                Model.currenIndex = index;
                            }
                        }
                        HoverHandler {
                            id: mousestextsongname
                            acceptedDevices: PointerDevice.Mouse
                            cursorShape: Qt.OpenHandCursor
                        }
                    }
                    Rectangle{
                        id:rectloveall
                        width: idmyfavorite.width-40//idrectsong.width*1/3-40
                        height:  rectsongname.height
                        radius: width/2
                        color: IsFavorite ?  Color.mousehover : Color.colortext
                        border.width: 1
                        Image {
                            id: idImgFavorite
                            anchors{
                                centerIn: parent
                            }
                            source:IsFavorite ? Img.imgheart: Img.imgheart2
                            scale: 0.2
                        }
                        MouseArea {
                            anchors.fill: rectloveall
                            onClicked: {
                                Model.setFavorite(index)
                            }
                        }
                    }
                }
            }
        }
    }
}
