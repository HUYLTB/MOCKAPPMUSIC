import QtQuick 2.15

Rectangle{
    property variant imgrotation;
    id: idrectrotation
    width: parent.height/3.5//200
    height: parent.height/3.5
    radius: height/2
    border.width: 1
    gradient: Gradient {
        GradientStop { position: 0.3; color: "#e1eec3" }
        GradientStop { position: 0.6; color: "#f05053" }
        GradientStop { position: 1.; color: "#000000" }
    }
    Image {
        id: imgrect
        anchors.fill: parent
        source: controlsong.imgplaying?imgrotation:""
        RotationAnimation on rotation {
            id:rotationimg
            running: controlsong.imgplaying? true : false
            loops: Animation.Infinite
            from: 0
            duration: 20000
            to: 360
        }
        OpacityAnimator {
            target: imgrect
            from: 0;
            to: 1;
            duration: 50000
            running: controlsong.imgplaying? true : false
        }
    }
}
