pragma Singleton

import QtQuick 2.0

QtObject {
    id: colors

    function ref(){ return colors; }

    // common
    readonly property var black_primary:        "#202020"
    readonly property var black_secondary:      "#333333"
    readonly property var black_tertiary:       "#999999"

    readonly property var gray:                 "#767676"
    readonly property var gray_dark:            "#646464"
    readonly property var background:           "#f2f2f2"
    readonly property var gray_light:           "#e1dfdd"
    readonly property var white_primary:        "#ffffff"

    readonly property var red_brand:            "#d10b41"
    readonly property var red_error:            "#f60606"
    readonly property var orange:               "#f8b000"
    readonly property var yellow_bar:           "#fff4ce"

    readonly property var green:                "#2FAB24"
    readonly property var blue:                 "#075AAA"

    readonly property var transparent:          "#00000000"

    // text
    readonly property var text_black:           "#202020"
    readonly property var text_white:           "#ffffff"
    readonly property var text_secondary:       "#999999"
    readonly property var text_secondary_dark:  "#747474"

    // additional
    readonly property var black:                "#000000"
    readonly property var black_pressed60:      "#99000000"
    readonly property var black_pressed20:      "#33000000"
    readonly property var rest:                 "#bfbfbf"
    readonly property var white20:              "#33ffffff"
    readonly property var white50:              "#80ffffff"
    readonly property var white80:              "#ccffffff"

    readonly property var green_light:          "#6bc265"
    readonly property var green_bright:         "#daff72"
    readonly property var green_pale:           "#dee5ca"
    readonly property var green_pale_second:    "#e5e2ca"
    readonly property var green_pearl:          "#e5ddca"

    readonly property var blue_pale:            "#7ca6ce"
    readonly property var blue_light:           "#dfeaed"
    readonly property var red_activated:        "#40ea0e0e"
}
