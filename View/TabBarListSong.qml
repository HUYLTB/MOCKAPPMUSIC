import QtQuick 2.15
import "../JsLibrary/QSourceTab.js" as Tabar
import "../JsLibrary/colorbutton.js" as Color
import "../Component"
import QtMultimedia
Item {

    Rectangle{
        id:idrectsong
        signal tabSelected(int index)
        width: itemdata.width-50
        height: itemdata.height
        color: Color.colorbackground
        onTabSelected: (index)=>{
                           loadertab.source=Tabar.tab[index].src
                       }
        Row{
            Rectangle{
                id:idretsong3
                width: itemdata.width/9
                height:idrectsong.height-100
                color: Color.colorbackground
                Column{
                    Repeater{
                        model:Tabar.tab
                        delegate: Rectangle{
                            width:idretsong3.width
                            height: idretsong3.height/5
                            border.width: 2
                            radius: 10
                            border.color:  mousetabar.hovered? Color.mousehover : Color.colortext
                            color:focus? Color.mousehover : Color.colorbackground
                            clip:true
                            Text{
                                anchors.centerIn: parent
                                text: Tabar.tab[index].name
                                color: "white"
                                font{
                                    bold:true
                                }
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    idrectsong.tabSelected(index)
                                    parent.focus=!parent.focus
                                }
                            }
                            QHoverHandler{
                                id:mousetabar
                            }
                        }
                    }
                }
            }
            Rectangle {
                id:recttabsource
                width: idrectsong.width-idretsong3.width
                height:idretsong3.height
                color: Color.colorbackground
                border.color: Color.colortext
                border.width: 1
                radius: 5
                Loader{
                    id:loadertab
                    source: Tabar.tab[0].src
                }
            }
        }
    }
}
