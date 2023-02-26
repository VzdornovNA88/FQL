import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0
import "../../Flat/Light" as FlatLigt

import "../../../../Resources/Colors"
import "../../../../Core/ColorHelpers.js" as ColorHelpers


FlatLigt.SliderStyle {
    backgroundColor     : RSM_Colors.background
    fillColor           : RSM_Colors.red_brand
    borderHandleColor   : RSM_Colors.black_tertiary
    tickmarksColor      : RSM_Colors.black_primary
    colorDisabled       : RSM_Colors.white50

    valueLevelPatternFillColor: [control.color ? control.color : fillColor,RSM_Colors.orange,RSM_Colors.red_error]
}
