import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0

import "../../../../Resources/Colors"
import "../../Flat/Light" as FlatLigt


FlatLigt.RadioButtonStyle {

    colorOffDefault           : RSM_Colors.transparent
    colorOnDefault            : RSM_Colors.red_brand
    colorChekedBorder         : Qt.tint(RSM_Colors.black_primary,RSM_Colors.white20)
    colorActiveFocusBorder    : Qt.tint(colorOn__,RSM_Colors.black_pressed20)
    colorActiveFocusHandle    : Qt.tint(colorOn__,RSM_Colors.black_pressed20)
    colorActiveFocusBG        : Qt.tint(colorOff__,RSM_Colors.black_pressed20)
    colorDisabled             : RSM_Colors.white50
}
