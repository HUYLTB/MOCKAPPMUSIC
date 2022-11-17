import QtQuick 2.15

Row{
    spacing: 10
    Rectangle{
        id:rectopenFolder
        width: 50
        height: 50
        radius: 25
        clip: true
        color:mousefolder.hovered? "goldenrod":"transparent"
        Image {
            id: imgopenFolder
            source:"qrc:/img/findfolder.png"
        }
        HoverHandler {
            id: mousefolder
            acceptedDevices: PointerDevice.Mouse
            cursorShape: Qt.OpenHandCursor
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                console.log("Da chon Folder")
                dirdialog.openfile(1)
            }
        }
    }
    Rectangle{
        id:rectopenFile
        width: 50
        height: 50
        radius: 25
        clip: true
        color:mousefile.hovered? "goldenrod":"transparent"
        Image {
            id: imgopenFile
            source:"qrc:/img/findfile.png"
        }
        HoverHandler {
            id: mousefile
            acceptedDevices: PointerDevice.Mouse
            cursorShape: Qt.OpenHandCursor
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                console.log("Da chon File")
                dirdialog.openfile(0)
            }
        }
    }
}
