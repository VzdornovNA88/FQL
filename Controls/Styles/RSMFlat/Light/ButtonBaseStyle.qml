import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0

import "../../../../Resources/Colors"
import "../../../../Core/ColorHelpers.js" as ColorHelpers
import "../../Flat/Light" as FlatLigt


FlatLigt.ButtonBaseStyle {
    colorActiveFocus        : RSM_Colors.red_activated
    colorDisabled           : RSM_Colors.white50
    colorBorderActiveFocus  : RSM_Colors.black_tertiary
    colorPressed            : RSM_Colors.black_pressed20
    colorEnabled            : RSM_Colors.red_brand
}
