import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0
import "../../Flat/Light" as FlatLigt

import "../../../../Resources/Colors"
import "../../../../Core/ColorHelpers.js" as ColorHelpers


FlatLigt.SliderStyle {
    property var backgroundColor     : RSM_Colors.background
    property var fillColor           : RSM_Colors.red_brand
    property var borderHandleColor   : RSM_Colors.black_tertiary
    property var tickmarksColor      : RSM_Colors.black
}
