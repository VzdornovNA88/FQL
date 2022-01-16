import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0
import QtQuick.Window 2.2
import QtQuick.Layouts 1.2

import "../../../../Resources/Colors"
import "../../../../Core/ColorHelpers.js" as ColorHelpers
import "../../Flat/Light" as FlatLigt


FlatLigt.ButtonStyle {

    colorActiveFocus        : RSM_Colors.red_activated
    colorDisabled           : RSM_Colors.white50
    colorBorderActiveFocus  : RSM_Colors.black_tertiary
    colorPressed            : RSM_Colors.black_pressed20
    colorEnabled            : RSM_Colors.red_brand

    colorDefaultText : ( ColorHelpers
                        .suitableFor(color__)
                        .in([ RSM_Colors.text_black,
                             RSM_Colors.text_white,
                             RSM_Colors.text_secondary,
                             RSM_Colors.text_secondary_dark ])[0].itemColor.color )
}
