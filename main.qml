import QtQuick 2.15
import QtQuick.Window 2.15
import "./View"
import "./JsLibrary/libraryImg.js" as Img
import "./JsLibrary/colorbutton.js" as Color
//Cac thu muc
//Component : Cac muc gop dùng chun
//Img : Anh
//jsLibrary thư viện ảnh , color, source
//Language library
// Source thay đổi source trang 2
//View Cac muc hien ở QML
// 2 page screen1 và screen2

/*
----CAC MUC HOAN THANH:
+ Build thành công
+ Load nhac tu file, folder
+ Doi souce
+ Chạy nhac va cac chuc nang : play,pause,next,prievious , mix, loop
+ chuyen screen bằng loader
+ Thông tin tabbar bằng visiable
+ Lay đươc MediaData
+ Giao tiep nhiều vs C++
+ Sort danh sách theo kí tự a- > z
+ Chọn được danh sách bài hát yêu thích
+ Các hiệu ứng Animation dưới CML
+ Chuyển Đổi Ngôn Ngữ


----CAC MUC CHUA HOAN THANH:
+ Chua gộp được album,singer từ Mediametadata
+ Chưa làm đúng theo MVC
+ Sort bài hat theo mục ABCD...
+ Chua lay dược Img của các bài hát
+ Group lai cac muc cua danh sách nhạc
+ Có thể có bug , do thời gian hoàn thành có hạn em sẽ update version 0.1 vào ngày sau
*/
Window {
    id:root
    width: 900
    height: 700
    visible: true
    title: qsTr("MUSIC APP")
    property bool isVisibleFile: false
    property bool isVisibleLang: false
    property bool isVisibleAbout: false
    property bool islook;
    //imgBackground
    Image {
        fillMode: Image.TileVertically
        verticalAlignment: Image.AlignTop
        source:  Img.imgbackground
        MouseArea{
            anchors.fill: parent
            onClicked: {
                isVisibleFile = false
                isVisibleLang = false
                isVisibleAbout = false
            }
        }
    }
    //Title bar
    TitleBar{
        id: idtitle
        anchors{
            left: parent.left
            right: parent.right
        }
        z: 200
        loadersource: loader
        namechange:  loader.item.namechang
        sourcechange: loader.item.sourcechang
        onClickhome: {if(loader.source == "qrc:/Screen2.qml")loader.source = "qrc:/Screen1.qml"}
        onClicklibrary: {if(loader.source == "qrc:/Screen1.qml")loader.source = "qrc:/Screen2.qml"}

    }
    //Loader Screen
    Loader{
        id:loader
        anchors.fill: parent
        source: "qrc:/Screen1.qml"
    }
}
