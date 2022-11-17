import QtQuick 2.15
import "../JsLibrary/libraryImg.js" as Img
import "../JsLibrary/colorbutton.js" as Color
import "./"
Rectangle{
    id:rectabbar
    property variant loadersource
    property string namechange
    property variant sourcechange
    signal clickhome()
    signal clicklibrary()
    height: parent.height/28//25
    gradient: Gradient {
        GradientStop { position: 0.7; color: "#999999" }
        GradientStop { position: 1.; color: Color.colorbackground }
    }
    //File
    Rectangle{
        id: filemenu
        width: 100
        height: parent.height
        anchors.left: parent.left
        color: mouseMenuBar.containsMouse ? Color.mousehover :  Color.colorbackground
        Text {
            id: fileMenuTxt
            anchors.centerIn: parent
            text: qsTr("<u>File</u>")
            font.pixelSize: 14
            color:Color.colortext
        }
        MouseArea{
            id: mouseMenuBar
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
                isVisibleFile ^=0x01
                isVisibleLang = false

            }
        }
    }//file
    Column{
        id: columnFile
        visible: isVisibleFile
        anchors{
            top: filemenu.bottom
        }
        Rectangle{
            id: rechome
            width: 100
            height: 25
            color:mousehome.containsMouse ? Color.mousehover : "#cccccc"
            Text {
                id: openhome
                anchors{
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: 5
                }
                text: qsTr("Home")
                font.pixelSize: 14
            }
            MouseArea{
                id: mousehome
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    rectabbar.clickhome()
                    islook? Trans.setlauguage(":/Language/language_en.qm") : Trans.setlauguage(":/Language/language_vi.qm")
                    console.log(islook)

                }
            }
        }
        Rectangle{
            id: recopenfile
            width: 100
            height: 25
            color:mouseopenfile.containsMouse ? Color.mousehover : "#cccccc"
            Text {
                id: openfile
                anchors{
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: 5
                }
                text: qsTr("Open File")
                font.pixelSize: 14
            }
            MouseArea{
                id: mouseopenfile
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    isVisibleFile = false
                    console.log("Da chon File")
                    isVisibleAbout= false
                    dirdialog.openfile(0)
                }
            }
        }
        Rectangle{
            id: recopenfolder
            width: 100
            height: 25
            color: mouseonpenfolder.containsMouse ? Color.mousehover : "#cccccc"
            Text {
                id: openfolder
                anchors{
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: 5
                }
                text: qsTr("Open Folder")
                font.pixelSize: 14
            }
            MouseArea{
                id: mouseonpenfolder
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    isVisibleFile = false
                    isVisibleAbout= false
                    console.log("Da chon Folder")
                    dirdialog.openfile(1)
                }
            }
        }
        Rectangle{
            id: reclibrary
            width: 100
            height: 25
            color:  mouselibrary.containsMouse ? Color.mousehover : "#cccccc"
            Text {
                id: idtextlibrary
                anchors{
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: 5
                }
                text: qsTr("Library")
                font.pixelSize: 14
            }
            MouseArea{
                id: mouselibrary
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    isVisibleFile = false
                    isVisibleAbout= false
                    console.log("library")
                    rectabbar.clicklibrary()
                    islook? Trans.setlauguage(":/Language/language_en.qm") : Trans.setlauguage(":/Language/language_vi.qm")
                    console.log(islook)
                }
            }
        }
        Rectangle{
            id: rectabout
            width: 100
            height: 25
            color: mouseaboout.containsMouse ? Color.mousehover : "#cccccc"
            Text {
                id: textabout
                anchors{
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: 5
                }
                text: qsTr("About")
                font.pixelSize: 14
            }
            MouseArea{
                id: mouseaboout
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    isVisibleAbout= true
                    console.log("About")
                }
            }
        }
        Rectangle{
            id: recexit
            width: 100
            height: 25
            color: mouseexit.containsMouse ? Color.mousehover : "#cccccc"
            Text {
                id: exitTxt
                anchors{
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: 5
                }
                text: qsTr("Exit")
                font.pixelSize: 14
            }
            MouseArea{
                id: mouseexit
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {root.close()}
            }
        }
    }
    //Setting
    Rectangle{
        id: settingmenu
        width: 100
        height: parent.height
        anchors.left: filemenu.right
        color:mousesetting.containsMouse ? Color.mousehover :  Color.colorbackground
        Text {
            id: setitngtxt
            anchors.centerIn: parent
            text: qsTr("<u>Setting</u>")
            font.pixelSize: 14
             color:Color.colortext
        }
        MouseArea{
            id: mousesetting
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
                isVisibleFile = false
                isVisibleLang ^= 0x01
                isVisibleAbout= false
            }
        }
    }//file
    Column{
        id: columnsetitng
        visible: isVisibleLang
        anchors{
            top: settingmenu.bottom
            left: parent.left
            leftMargin: columnFile.width
        }
        Rectangle{
            id: recsetvn
            width: 100
            height: 25
            color:mousesetvn.containsMouse ? Color.mousehover : "#cccccc"
            Row{
                anchors{
                    verticalCenter: parent.verticalCenter
                    left:parent.left
                    leftMargin: 5
                }
                spacing:5

                Text {
                    id: setvntxt
                    anchors{
                        verticalCenter: parent.verticalCenter
                    }
                    text: qsTr("VN")
                    font.pixelSize: 14
                }
                Image {
                    id: idimgvn
                    source: Img.imgvn
                    scale: 0.5
                }
            }
            MouseArea{
                id: mousesetvn
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    isVisibleLang = false
                    Trans.setlauguage(":/Language/language_vi.qm")
                    islook=false
                }
            }

        }
        Rectangle{
            id: recseten
            width: 100
            height: 25
            color: mouseseten.containsMouse ? Color.mousehover : "#cccccc"
            Row{
                anchors{
                    verticalCenter: parent.verticalCenter
                    left:parent.left
                    leftMargin: 5
                }
                spacing:5

                Text {
                    id: setentxt
                    anchors{
                        verticalCenter: parent.verticalCenter
                    }
                    text: qsTr("EN")
                    font.pixelSize: 14
                }
                Image {
                    id: idimgen
                    source: Img.imgen
                    scale: 0.5
                }
            }
            MouseArea{
                id: mouseseten
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    isVisibleLang = false
                    Trans.setlauguage(":/Language/language_en.qm")
                    islook=true
                }
            }
        }
    }
    Rectangle{
        id: screennext
        width: 100
        height: parent.height
        anchors.right: parent.right
        color:mousenextscreen.containsMouse ? Color.mousehover :  Color.colorbackground
        Text {
            id: screenexttext
            anchors.centerIn: parent
            text: namechange
            font.pixelSize: 14
             color:Color.colortext
        }
        MouseArea{
            id: mousenextscreen
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
                loadersource.source=sourcechange
                console.log("da kich next")
                islook? Trans.setlauguage(":/Language/language_en.qm") : Trans.setlauguage(":/Language/language_vi.qm")
                console.log(islook)
            }
        }
    }

}

