import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Private 1.0

Item {
    id: root

    property alias rectCanvasSolid: rectCanvasSolid
    property alias rectFilledCanvas: rectFilledCanvas
    property alias rectEmptyCanvas: rectEmptyCanvas
    property alias handle:imgHandle
    property alias mouseArea: mouseArea
    property alias value: txtValue
    property alias txtMinValue: txtMinValue
    property alias txtMaxValue: txtMaxValue


    Component.onCompleted: {
        rectFilledCanvas.width = imgHandle.x + imgHandle.width/2 - rectCanvasSolid.x
        rectEmptyCanvas.width = rectCanvasSolid.x + rectCanvasSolid.width - imgHandle.x
    }

    Rectangle {
        id: rectCanvasSolid
        height: root.height
        width: root.width

        Text {
            id: txtMin
            text: qsTr("мин")
            font.pixelSize: 28
            anchors.left: parent.left
            anchors.bottom: parent.top
            anchors.bottomMargin: 5
        }
        Text {
            id: txtMinValue
            text: "0"
            font.pixelSize: 28
            anchors.left: txtMin.left
            anchors.bottom: txtMin.top
        }
        Text {
            id: txtMax
            text: qsTr("макс")
            font.pixelSize: 28
            anchors.right: parent.right
            anchors.bottom: parent.top
            anchors.bottomMargin: 5
        }
        Text {
            id: txtMaxValue
            text: "100"
            font.pixelSize: 28
            anchors.right: txtMax.right
            anchors.bottom: txtMax.top
            anchors.bottomMargin: 5
        }
        Rectangle {
            id: rectFilledCanvas
            color: "green"
            height: parent.height
            x: parent.x
            y: parent.y
        }
        Rectangle {
            id: rectEmptyCanvas
            color: "lightgray"
            height: parent.height
            x: imgHandle.x + imgHandle.width/2
            y: imgHandle.y
        }
        Image {
            id: imgHandle
            source: "qrc:/Vector.svg"
            sourceSize.height: 34
            sourceSize.width: 30
        }
        Text {
            id: txtValue
            anchors.horizontalCenter: rectCanvasSolid.horizontalCenter
            font.pixelSize: 36
            font.bold: true
            y: -3.5 * root.height/2
            Component.onCompleted: text = "0"
        }

        MouseArea {
            id: mouseArea
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            height: parent.height
            width:  parent.width + 2*imgHandle.width
        }
    }
}
