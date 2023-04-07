/**
******************************************************************************
* @file             BaseSelectorButtonStyle.qml
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

import "../../../Resources/Colors"
import "../../../Core/ColorHelpers.js" as ColorHelpers
import "../../Private"
import "../../../Core"

Style {
    id: selectorbuttonStyle

    property var colorOffDefault    : Qt.tint(StyleConfigurator.theme.backgroundAccent1Collor,
                                              StyleConfigurator.theme.lighter20Collor)
    property var colorOnDefault     : StyleConfigurator.theme.buttonAccentCollor
    property var colorDefault       : MaterialColors.grey400
    property var colorBG            : StyleConfigurator.theme.lighter50Collor
    property var colorActiveFocus   : StyleConfigurator.theme.darker20Collor
    property var colorDisabled      : StyleConfigurator.theme.lighter50Collor

    property var       color__      : control.checked ?
                                          colorOn__ : colorOff__

    property var       colorOff__   : undefined === control.colorOff ?
                                          colorOffDefault : control.colorOff

    property var       colorOn__    : undefined === control.colorOn ?
                                          colorOnDefault : control.colorOn


    property var       colorBG__    : Qt.tint(color__, colorBG)

    property var       colorActiveFocus__   : Qt.tint(selectorbuttonStyle.color__,
                                                      colorActiveFocus)

    property Component panel: Item {

        id: panelID

        width                   : control.width
        height                  : control.height

        Rectangle {
            id : bg

            anchors.centerIn    : parent

            width               : panelID.width
            height              : panelID.height

            radius              : height/2
            color               : !selectorbuttonStyle.control.checked ?
                                      ( StyleConfigurator.theme.transparent ) :
                                      ( selectorbuttonStyle.colorBG__ )


            Rectangle {

                id: handleLoader

                anchors.centerIn       : parent

                width                  : bg.height*0.5
                height                 : bg.height*0.5

                radius                 : width/2

                color                  : selectorbuttonStyle.control.activeFocus ?
                                             colorActiveFocus__ :
                                             selectorbuttonStyle.color__

            }

            Rectangle {

                id:fg

                width       : bg.width
                height      : bg.height
                radius      : bg.radius

                anchors.centerIn: parent

                color       : selectorbuttonStyle.control.enabled ?
                                  StyleConfigurator.theme.transparent  : colorDisabled
            }
        }
    }
}
