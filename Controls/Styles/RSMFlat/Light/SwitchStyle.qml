import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0
import "../../../../Resources/Colors"
import "../../Flat/Light" as FlatLigt


FlatLigt.SwitchStyle {

    colorOffDefault             : RSM_Colors.white_primary
    colorOnDefault              : RSM_Colors.red_brand
    colorChekedBorder           : Qt.tint(RSM_Colors.black_primary,RSM_Colors.white20)
    colorActiveFocusBorder      : Qt.tint(colorOn__,RSM_Colors.black_pressed20)
    colorActiveFocusCheked      : Qt.tint(colorOn__,RSM_Colors.black_pressed20)
    colorActiveFocusUnCheked    : Qt.tint(colorOff__,RSM_Colors.black_pressed20)
    colorActiveFocusChekedBG    : Qt.tint(colorOn__,RSM_Colors.black_pressed20)
    colorActiveFocusUnChekedBG  : Qt.tint(colorOff__,RSM_Colors.black_pressed20)
    colorChekedHandle           : RSM_Colors.white_primary
    colorUnChekedHandle         : Qt.tint(RSM_Colors.black_primary,RSM_Colors.white20)
    colorDisabled               : RSM_Colors.white50
}
