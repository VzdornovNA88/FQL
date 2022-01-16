import QtQuick 2.5

import QtQuick.Controls 1.4
import QtQuick.Controls.Private 1.0

QtObject {
    id: object
    objectName: "HandleLevel"
    property real value: 0
    property string sourceImg: ""
    property string transform: "" ///< Поле трансформации (Rotation, Scale, Translate) для созданной картинки img
    property Image  img: null

    signal valChanged(real val)

    onValueChanged: valChanged(value)
}


