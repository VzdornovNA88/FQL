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

import FQL.Resources.Colors 1.0
import FQL.Core.Meta 1.0
import FQL.Core.Base 1.0
import FQL.Controls.Private 1.0

Style {
    id: radiobuttonStyle

    property var colorOffDefault           : StyleConfigurator.theme.transparent
    property var colorOnDefault            : StyleConfigurator.theme.buttonAccentCollor
    property var colorChekedBorder         : StyleConfigurator.theme.borderGeneralCollor
    property var colorActiveFocusBorder    : Qt.tint( radiobuttonStyle.colorOn__,StyleConfigurator.theme.darker20Collor)
    property var colorActiveFocusHandle    : Qt.tint( radiobuttonStyle.colorOn__,StyleConfigurator.theme.darker20Collor)
    property var colorActiveFocusBG        : Qt.tint( radiobuttonStyle.colorOff__,StyleConfigurator.theme.darker20Collor)
    property var colorDisabled             : StyleConfigurator.theme.lighter50Collor

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
                                                  StyleConfigurator.theme.transparent) :
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
                                  StyleConfigurator.theme.transparent  :
                                  colorDisabled
            }
        }
    }
}
