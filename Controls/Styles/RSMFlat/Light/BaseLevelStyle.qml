import QtQuick 2.2

import "../../../../Core/Meta"
import "../../../../Core/Meta/Type.js" as Meta
import "../../../../Resources/Colors"
import "../../../../Core/ColorHelpers.js" as ColorHelpers
import "../../Flat/Light" as FlatLigt

FlatLigt.BaseLevelStyle {
    id: baseLevelStyle

    colorLevel                   : RSM_Colors.green
    colorDisplay                 : RSM_Colors.gray_light
    colorText                    : RSM_Colors.text_black
    colorDisabled                : RSM_Colors.white50
    borderColor                  : RSM_Colors.gray_dark
}
