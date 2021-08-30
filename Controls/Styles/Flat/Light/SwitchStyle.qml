/**
******************************************************************************
* @file             SwitchStyle.qml
* @brief
* @authors          Nik A. Vzdornov
* @date             10.09.19
* @copyright
*
* Copyright (c) 2019 VzdornovNA88
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
******************************************************************************
*/

import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0

import "../../../../Resources/Colors"
import "../../../../Core/ColorHelpers.js" as ColorHelpers

Style {
    id: switchstyle

    property var colorOffDefault             : MaterialColors.transparent
    property var colorOnDefault              : MaterialColors.pink700
    property var colorChekedBorder           : MaterialColors.grey300
    property var colorActiveFocusBorder      : Qt.tint( colorOn__,ColorHelpers.addAlpha( 0.2,MaterialColors.grey900 ))
    property var colorActiveFocusCheked      : Qt.tint( colorOn__,ColorHelpers.addAlpha( 0.2,MaterialColors.grey900 ))
    property var colorActiveFocusUnCheked    : Qt.tint( colorOff__,ColorHelpers.addAlpha( 0.2,MaterialColors.grey900 ))
    property var colorActiveFocusChekedBG    : Qt.tint( colorOn__,ColorHelpers.addAlpha( 0.2,MaterialColors.grey900 ))
    property var colorActiveFocusUnChekedBG  : Qt.tint( colorOff__,ColorHelpers.addAlpha( 0.2,MaterialColors.grey900 ))
    property var colorChekedHandle           : MaterialColors.grey50
    property var colorUnChekedHandle         : Qt.tint(MaterialColors.grey900,ColorHelpers.addAlpha( 0.2,MaterialColors.grey50 ))
    property var colorDisabled               : ColorHelpers.addAlpha( 0.5,MaterialColors.grey50  )

    readonly
    property Switch    control      : __control

    property var       colorOff__   : undefined === control.colorOff ?
                                          colorOffDefault : control.colorOff

    property var       colorOn__    : undefined === control.colorOn ?
                                          colorOnDefault : control.colorOn

    property int paddingHandle__    : 8
    property int offset__           : 4

    property Component panel: Item {

        id: panelID

        width                   : control.width
        height                  : control.height

        property var __handle   : handleLoader
        property int min        : bg.x + paddingHandle__- offset__
        property int max        : bg.width - handleLoader.width - paddingHandle__ + offset__

        //Биндинг на свойство handleLoader.x не работает , приходится только так это свойство обнавлять
        onMaxChanged: {

            if( control.checked )
                handleLoader.x = max
            else
                handleLoader.x = min
        }

        Rectangle {
            id : focusable

            anchors.centerIn    : parent

            width               : panelID.width
            height              : panelID.height

            border.color        : !control.checked ?
                                      ( colorChekedBorder ) :
                                      (switchstyle.control.activeFocus ?
                                           colorActiveFocusBorder :
                                           switchstyle.colorOn__)

            border.width        : offset__
            radius              : height/2
            color               : switchstyle.control.activeFocus ?
                                      (switchstyle.control.checked ?
                                           colorActiveFocusCheked :
                                           colorActiveFocusUnCheked) :
                                      (switchstyle.control.checked ?
                                           switchstyle.colorOn__ :
                                           switchstyle.colorOff__)

            Rectangle {

                id:bg

                width           : focusable.width - paddingHandle__
                height          : focusable.height - paddingHandle__

                anchors.centerIn: parent

                color           : switchstyle.control.activeFocus ?
                                      (switchstyle.control.checked ?
                                           colorActiveFocusChekedBG :
                                           colorActiveFocusUnChekedBG) :
                                      (switchstyle.control.checked ?
                                           switchstyle.colorOn__ :
                                           switchstyle.colorOff__)


                radius: height/2

                Rectangle {

                    id: handleLoader

// не сработает , после чекеда свойство x обнавляется не корректно
//                    x: control.checked ? max : min

                    anchors.verticalCenter : bg.verticalCenter

                    width                  : control.checked ? bg.height*0.85 : bg.height*0.4
                    height                 : control.checked ? bg.height*0.85 : bg.height*0.4

                    radius                 : width/2

                    color                  : control.checked ?
                                                 switchstyle.colorChekedHandle :
                                                 switchstyle.colorUnChekedHandle


                    Behavior on x {
                        id: behavior
                        enabled : handleLoader.visible
                        NumberAnimation {
                            duration: 150
                            easing.type: Easing.OutCubic
                        }
                    }
                }

                Rectangle {

                    id:fg

                    width       : focusable.width
                    height      : focusable.height
                    radius      : focusable.radius

                    anchors.centerIn: parent

                    color       : switchstyle.control.enabled ?
                                      MaterialColors.transparent  :
                                      switchstyle.colorDisabled
                }
            }
        }
    }
}
