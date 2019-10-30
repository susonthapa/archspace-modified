import QtQuick 2.13
import QtGraphicalEffects 1.13
Rectangle {
    id: root
    width: 1920
    height: 1080
    color: "black"
    property int stage

    property bool alternate: true

    onStageChanged: {
        if (stage == 1) {
            introAnimation.running = true
        }
    }

TextMetrics {
            id: units
            text: "M"
            property int gridUnit: boundingRect.height
            property int largeSpacing: units.gridUnit
            property int smallSpacing: Math.max(2, gridUnit/4)
        }

    Image {
        id: mainRect
        width: 1920
        height: 1080
        opacity: 0.75
        
        source: "/home/suson/.wallpaper"

        FastBlur {
            source: parent
            anchors.fill: parent
            radius: 2
        }

    }

    Image {
        id: topRect
        anchors.horizontalCenter: root.horizontalCenter
        y: root.height
        source: "images/rectangle.png"
        Image {
            id: archLogo
            source: "images/kde.png"
            anchors.centerIn: parent
        }

        Text {

        id: preLoadingText
        height: 30
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50
        text: "Arch Linux"
        color: "#ffffff"
        font.family: "OpenSans Light"
        font.weight: Font.ExtraLight
        font.pointSize: 20
        opacity: 0
        textFormat: Text.StyledText
    }
    }

    
    
    OpacityAnimator {
        id: distroTextAnimator
        target: preLoadingText
        from: 0
        to: 1
        duration: 500
        easing.type: Easing.InOutQuad
        onFinished: {
            plasmaTextAnimator.start()
        }
    }

    OpacityAnimator {
        id: plasmaTextAnimator
        target: plasmaTextRow
        from: 0
        to: 1
        duration: 500
        easing.type: Easing.InOutQuad
    }

    Row {
        id: plasmaTextRow
        opacity: 0
            spacing: units.smallSpacing*2
            anchors {
                bottom: parent.bottom
                right: parent.right
                margins: units.gridUnit
            }
            Text {
                color: "#eff0f1"
                anchors.verticalCenter: parent.verticalCenter
                text: "Plasma made by KDE"
            }
            Image {
                source: "images/kde.svgz"
                sourceSize.height: units.gridUnit * 2
                sourceSize.width: units.gridUnit * 2
            }
        }

    PropertyAnimation {
        running: true
                property: "y"
                target: topRect
                to: root.height / 3
                duration: 1000
                easing.type: Easing.InOutBack
                easing.overshoot: 1.0
                onFinished: {
                    logoAnimation.start()
                    distroTextAnimator.start()
                }
            }

            PropertyAnimation {
                id: logoAnimation
                property: "opacity"
                target: archLogo
                to: 0
                duration: 1500
                easing.type: Easing.InCubic
                onFinished: {
                    logoAnimation.to = alternate ? 1 : 0
                    logoAnimation.from = alternate ? 0: 1
                    alternate = !alternate
                    logoAnimation.start()
                }
            }


}
