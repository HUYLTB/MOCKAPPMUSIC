import QtQuick 2.15
import "../JsLibrary/colorbutton.js" as Color
import "../Component"
Rectangle{
    id:rectsongdata
    property variant mList:
        [
        qsTr("TITLE")+"\n"+controlsong.dataSong[0],
        qsTr("SINGER")+"\n"+controlsong.dataSong[1],
        qsTr("COPYRIGHT")+"\n"+controlsong.dataSong[2]
    ]
    width: root.width/2.5
    height: root.height/7-20
    border.color: Color.colortext
    color: Color.colorbackground
    border.width: 1
    radius: 10
    clip:true
    ListView {
        id: listtable
        anchors.fill: parent
        anchors{
        left:parent.left
        leftMargin: 10
        }
        snapMode: ListView.SnapOneItem
        orientation: ListView.Horizontal
        model: mList
        spacing: parent.width
        delegate:
            Text {
            text: mList[index]
            color: Color.colortext
            font.pixelSize: 15
            font.italic: true
            font.bold: true
        }
        highlightRangeMode: ListView.StrictlyEnforceRange
        Row {
            anchors{
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: 5
            }
            spacing: 20
            Repeater {
                id: rect3
                model: mList
                delegate: Rectangle {
                    width: 30
                    height: 20
                    radius: 10
                    scale: mouserectlistdata.hovered? 1.2 : 1
                    color: focus || listtable.currentIndex == index ? Color.mousehover : Color.colortext
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            listtable.highlightMoveDuration = 500
                            listtable.currentIndex = index
                            parent.focus = true
                        }
                    }
                   QHoverHandler{
                   id:mouserectlistdata
                   }
                }
            }
        }
    }

}



