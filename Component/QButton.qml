import QtQuick 2.15
import "../JsLibrary/colorbutton.js" as Color
Rectangle{
    property bool m_boolborder
    property variant m_hoverhander
    width: rectcontrol.height/2//50
    height: rectcontrol.height/2//50
    radius: height/2//25
    clip: true
    border.width: m_boolborder? 2 : 0
    border.color: Color.colortext
    color:m_hoverhander.hovered? Color.colorhover :  Color.colorbackground
}
