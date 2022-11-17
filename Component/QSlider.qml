import QtQuick 2.15
import "../JsLibrary/colorbutton.js" as Color
Rectangle{
    property real maxwidth
    property real maxheight
    property real m_valuechange
    property real m_valuesave
    signal m_onvaluechang(real value)
    id:rectsliderpos
    width: maxwidth
    anchors.verticalCenter: parent.verticalCenter
    height: maxheight
    radius: maxheight/2
    color: Color.colortext
    Rectangle {
        id: idProgressRange
        width: rectcontrolpos.x - x + rectcontrolpos.width *(2/3)
        height: parent.height
        radius: maxheight/2
        color: Color.mousehover
    }
    MouseArea{
        id:mose1click
        anchors.fill: parent
        onClicked: {
            var x = mouseX
            if(x > mose1.drag.maximumX ){
                x = mose1.drag.maximumX
            }
            m_onvaluechang(x/mose1.drag.maximumX * m_valuesave)
        }
    }
    Rectangle{
        id:rectcontrolpos
        width: maxheight
        height: maxheight
        radius: maxheight/2
        scale: mouseslidersong.hovered? 1.5: 1
        anchors.verticalCenter: parent.verticalCenter
        color: "#403B4A"
        x: (m_valuechange * mose1.drag.maximumX) / m_valuesave
        onXChanged:  {
            if(mose1.drag.active){
                m_onvaluechang(x*m_valuesave/mose1.drag.maximumX)
            }
        }
        states:[
            State {
                when: mose1.drag.active
                PropertyChanges {
                    target: rectcontrolpos
                    x: mose1.x
                }
            },
            State {
                when: mose1click.released
                PropertyChanges {
                    target: rectcontrolpos
                    x: mose1click.x
                }
            }
        ]
        MouseArea{
            id: mose1
            anchors.fill: parent
            drag.target: rectcontrolpos
            drag.axis: Drag.XAxis
            drag.minimumX: 0
            drag.maximumX: rectsliderpos.width - rectcontrolpos.width
        }
        HoverHandler {
            id: mouseslidersong
            acceptedDevices: PointerDevice.Mouse
            cursorShape: Qt.OpenHandCursor
        }
    }

}
