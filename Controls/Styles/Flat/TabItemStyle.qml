/**
******************************************************************************
* @file             TabItemStyle.qml
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

import "../../../Core"
import "../../../Core/Meta"
import "../../../Core/Meta/Type.js" as Meta
import "../../../Resources/Colors"
import "../../../Core/ColorHelpers.js" as ColorHelpers

WidgetButtonStyle {
    id: tabItemStyle

    property var colorHandle : StyleConfigurator.theme.buttonAccentCollor

    colorActiveFocus: tabItemStyle.color__

    panel: Rectangle {
        id : focusable

        width               : control.width
        height              : control.height
        border.width        : widthOfBorder
        border.pixelAligned : true
        border.color        : control.borderFocus ?
                                  ( control.activeFocus ?
                                       tabItemStyle.colorBorderActiveFocus :
                                       StyleConfigurator.theme.transparent ) :
                                  StyleConfigurator.theme.transparent

        color               : StyleConfigurator.theme.transparent

        Rectangle {

            id:bg

            width           : widthAvailable
            height          : heightAvailable

            anchors.centerIn: parent

            color           : control.borderFocus ?
                                  ( tabItemStyle.checked__        ?
                                     StyleConfigurator.theme.transparent     :
                                  tabItemStyle.color__ )   :
                                  tabItemStyle.down ?
                                      tabItemStyle.color__ :
                                      ( control.activeFocus ?
                                           tabItemStyle.colorActiveFocus :
                                           ( tabItemStyle.checked__        ?
                                              tabItemStyle.colorActiveFocus     :
                                           tabItemStyle.color__ ))

            Rectangle {
                    id : activatableLeft

                    width               : 3
                    height              : bg.height
                    color               : control.activatable && control.activated ? tabItemStyle.colorHandle :
                                                                                     control.checkable && control.checked ? tabItemStyle.colorHandle :
                                                                                                                              bg.color
                    visible : control.vertical
                    anchors.left: bg.left
            }

            Rectangle {
                    id : activatableTop

                    width               : bg.width
                    height              : 3
                    color               : control.activatable && control.activated ? tabItemStyle.colorHandle :
                                                                                     control.checkable && control.checked ? tabItemStyle.colorHandle :
                                                                                                                              bg.color
                    visible : !control.vertical
                    anchors.top: bg.top
            }

            Rectangle {

                id:fg

                width       : bg.width
                height      : bg.height
                color       : tabItemStyle.colorForeground__
            }
        }
    }
}
