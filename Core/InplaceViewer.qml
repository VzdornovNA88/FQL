import QtQuick 2.5
import QtQuick.Controls 1.4

Item {
    id: root
    objectName: "InplaceViewer"

    property alias loader: loaderId
    property alias presenter: loaderId.sourceComponent

    Loader {
        id: loaderId
        anchors.fill: parent
    }
}
