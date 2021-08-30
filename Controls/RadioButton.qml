import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0

import "../Core"

RadioButton {
    id: radioButton

    style: StyleConfigurator.getStyleCurrent( radioButton )

    property var  colorOn
    property var  colorOff

    height: width
}
