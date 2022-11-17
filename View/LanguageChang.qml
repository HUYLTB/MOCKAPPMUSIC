import QtQuick 2.15

Row {
    spacing: 20
    Rectangle{
        id:idvn
        width: 50
        height: 50
        radius: 25
        color: mouseidvn.hovered?"goldenrod" : "transparent"
        Image {
            id: idvd
            source: "qrc:/img/icons8-vietnam-48.png"
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                Trans.setlauguage("language_vi.qm")
            }
        }
        HoverHandler {
            id: mouseidvn
            acceptedDevices: PointerDevice.Mouse
            cursorShape: Qt.OpenHandCursor
        }
    }
    Rectangle{
        id:idenglish
        width: 50
        height: 50
        radius: 25
        color: mouseiden.hovered?"goldenrod" : "transparent"
        Image {
            id: iden
            source: "qrc:/img/icons8-great-britain-48.png"
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                Trans.setlauguage("language_en.qm")}
        }
        HoverHandler {
            id: mouseiden
            acceptedDevices: PointerDevice.Mouse
            cursorShape: Qt.OpenHandCursor
        }
    }
}
