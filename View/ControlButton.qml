import QtQuick 2.15
import "../Component"
import "../JsLibrary/colorbutton.js" as Color
import "../JsLibrary/libraryImg.js" as Img
Rectangle
{
    id:rectcontrol
    width: root.width*2/3
    height: parent.height/7//100
    radius:parent.height/35 //20
    border.width: 1
    border.color: Color.colortext
    color: Color.colorbackground//"transparent"
    Row{
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: parent.height/4//25
        spacing: parent.height-40//60
        QButton{
            id:rectxaotron
            m_boolborder: Model.songMix
            m_hoverhander: mousexao
            QImg{
                id: imgxaobai
                m_source: Img.imgmix
            }
            QHoverHandler{
                id:mousexao
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    console.log(Model.songMix);
                    Model.onsetsongMix()
                    controlsong.play();
                }
            }
        }
        QButton{
            id:rectprevious
            m_boolborder: false
            m_hoverhander: mouseprevious
            QImg{
                id: imgprevious
                m_source: Img.imgprevious
            }
            QHoverHandler{
                id: mouseprevious
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if(Model.currenIndex-1 < 0 ){

                        console.log("Khong the Lui")
                    }
                    else{
                        Model.currenIndex -=1
                        console.log("Hat bai truoc do")
                        controlsong.play();
                    }
                }
            }
        }
        QButton{
            id:rectplay
            m_boolborder: false
            m_hoverhander: mouseplay
            QImg{
                id: imgplay
                m_source: controlsong.imgplaying? Img.imgpause : Img.imgplay
            }
            QHoverHandler{
                id: mouseplay
            }
            MouseArea{
                anchors.fill: parent
                onClicked:
                {
                    if(controlsong.onplaying()){
                        controlsong.pause()
                    }
                    else{
                        controlsong.play()
                    }
                }
            }
        }
        QButton{
            id:rectnext
            m_boolborder: false
            m_hoverhander: mousenext
            QImg{
                id: imgnext
                m_source: Img.imgnext
            }
            QHoverHandler{
                id: mousenext
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {

                    Model.currenIndex +=1
                    console.log("Hat bai tiep theo")
                    controlsong.play();
                }
            }
        }
        QButton{
            id:rectreplay
            m_boolborder: controlsong.singagain
            m_hoverhander:mousereplay
            QImg{
                id: imgreplay
                m_source: Img.imgreplay
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    controlsong.changsingagain()
                }
            }
            QHoverHandler{
                id: mousereplay
            }
        }
    }
}
