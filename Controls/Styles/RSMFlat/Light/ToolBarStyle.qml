import QtQuick 2.2

import "../../../../Core/Meta"
import "../../../../Core/Meta/Type.js" as Meta
import "../../../../Resources/Colors"
import "../../../../Core/ColorHelpers.js" as ColorHelpers
import "../../Flat/Light" as FlatLigt

FlatLigt.ToolBarStyle {
    id: toolBarStyle

    colorBackground     : RSM_Colors.background
    colorButtonsControl : RSM_Colors.black_pressed20
    colorTabItems       : RSM_Colors.transparent
}
