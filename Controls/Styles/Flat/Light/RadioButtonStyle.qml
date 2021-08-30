/**
******************************************************************************
* @file             RadioButtonStyle.qml
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
    id: radiobuttonStyle

    property var colorOffDefault           : MaterialColors.transparent
    property var colorOnDefault            : MaterialColors.pink700
    property var colorChekedBorder         : MaterialColors.grey300
    property var colorActiveFocusBorder    : Qt.tint( radiobuttonStyle.colorOn__,ColorHelpers.addAlpha( 0.2,MaterialColors.grey900 ))
    property var colorActiveFocusHandle    : Qt.tint( radiobuttonStyle.colorOn__,ColorHelpers.addAlpha( 0.2,MaterialColors.grey900 ))
    property var colorActiveFocusBG        : Qt.tint( radiobuttonStyle.colorOff__,ColorHelpers.addAlpha( 0.2,MaterialColors.grey900 ))
    property var colorDisabled             : ColorHelpers.addAlpha( 0.5,MaterialColors.grey50  )

    readonly
    property RadioButton    control      : __control

    property var       colorOff__   : undefined === control.colorOff ?
                                          colorOffDefault : control.colorOff

    property var       colorOn__    : undefined === control.colorOn ?
                                          colorOnDefault : control.colorOn

    property Component panel: Item {

        id: panelID

        width                   : control.width
        height                  : control.height

        Rectangle {
            id : bg

            anchors.centerIn    : parent

            width               : panelID.width
            height              : panelID.height

            border.color        : !control.checked ?
                                      ( colorChekedBorder ) :
                                      (radiobuttonStyle.control.activeFocus ?
                                           colorActiveFocusBorder :
                                           radiobuttonStyle.colorOn__)

            border.width        : 4
            radius              : height/2
            color               : !radiobuttonStyle.control.checked ?
                                      ( radiobuttonStyle.control.activeFocus ?
                                           colorActiveFocusBG :
                                           radiobuttonStyle.colorOff__ ) :
                                      ( radiobuttonStyle.colorOff__ )


            Rectangle {

                id: handleLoader

                anchors.centerIn       : parent

                width                  : bg.height*0.5
                height                 : bg.height*0.5

                radius                 : width/2

                color                  : radiobuttonStyle.control.activeFocus ?
                                             (radiobuttonStyle.control.checked ?
                                                  colorActiveFocusHandle :
                                                  MaterialColors.transparent) :
                                             (radiobuttonStyle.control.checked ?
                                                  radiobuttonStyle.colorOn__ :
                                                  radiobuttonStyle.colorOff__)

            }

            Rectangle {

                id:fg

                width       : bg.width
                height      : bg.height
                radius      : bg.radius

                anchors.centerIn: parent

                color       : radiobuttonStyle.control.enabled ?
                                  MaterialColors.transparent  :
                                  colorDisabled
            }
        }
    }
}
