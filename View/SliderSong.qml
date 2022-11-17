import QtQuick 2.15
import "../Component"
import "../JsLibrary/colorbutton.js" as Color
Row{
    spacing: 20
    Text {
        id: txtposition
        text: controlsong.positiontext
        color: Color.colortext
    }
    QSlider{
        maxwidth: root.width*2/3
        maxheight: 20
        m_valuechange: controlsong.position
        m_valuesave: controlsong.duration

        onM_onvaluechang:(value) =>
                       {
                           controlsong.dragPosition(value)
                       }
    }
    Text {
        id: txtduration
        text: controlsong.durationtext
        color: Color.colortext
    }
}
