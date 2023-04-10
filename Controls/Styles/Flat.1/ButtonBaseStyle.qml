/**
******************************************************************************
* @file             ButtonBaseStyle.qml
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
    id: buttonstyle

    property bool invertPressedColor     : false
    property var colorActiveFocus        : StyleConfigurator.theme.buttonActivatedCollor
    property var colorDisabled           : StyleConfigurator.theme.buttonDisabledCollor
    property var colorBorderActiveFocus  : StyleConfigurator.theme.borderAccentCollor
    property var colorPressed            : suitableColorPressed
    property var colorEnabled            : StyleConfigurator.theme.buttonAccentCollor
    property var colorCheked             : colorPressed
    property var contentBorderColor      : StyleConfigurator.theme.transparent

    property var widthOfBorder                : 2

    property Component content                : null
    property QtObject  contentItem__          : null

    property var widthAvailable  : control.width - 6
    property var heightAvailable : control.height - 6


    signal contentLoaded__(QtObject item_)

    readonly
    property bool      down                   : control.pressed

    readonly
    property var suitableColorPressed         : !invertPressedColor ?
                                                        StyleConfigurator.theme.buttonPressedCollor :
                                                        StyleConfigurator.theme.buttonPressedInvertCollor

    readonly
    property bool      checked__              : (control.checkable && control.checked)
    readonly
    property var       color__                : undefined === control.color ?
                                                    buttonstyle.colorEnabled : control.color

    readonly
    property var colorForeground__            : buttonstyle.control.enabled     ?
                                                 ( buttonstyle.down             ?
                                                    (buttonstyle.control.showPressedState ?
                                                         buttonstyle.colorPressed :
                                                         StyleConfigurator.theme.transparent) :
                                                 ( buttonstyle.checked__        ?
                                                    buttonstyle.colorCheked     :
                                                 StyleConfigurator.theme.transparent ) ) :
                                                buttonstyle.colorDisabled

    readonly
    property var colorBackground__            : control.borderFocus ?
                                                    ( buttonstyle.checked__        ?
                                                       StyleConfigurator.theme.transparent     :
                                                    buttonstyle.color__ )   :
                                                    buttonstyle.down ?
                                                        buttonstyle.color__ :
                                                        ( control.activeFocus ?
                                                             buttonstyle.colorActiveFocus :
                                                             ( buttonstyle.checked__        ?
                                                                buttonstyle.colorActiveFocus     :
                                                             buttonstyle.color__ ))

    property Component panel: Rectangle {
        id : focusable

        width               : control.width
        height              : control.height
        border.width        : widthOfBorder
        border.pixelAligned : true
        border.color        : control.borderFocus ?
                                  ( control.activeFocus ?
                                       buttonstyle.colorBorderActiveFocus :
                                       StyleConfigurator.theme.transparent ) :
                                  StyleConfigurator.theme.transparent

        color               : StyleConfigurator.theme.transparent

        Rectangle {

            id:bg

            width           : widthAvailable
            height          : heightAvailable

            anchors.centerIn: parent

            color           : colorBackground__

            FocusScope {
                id: contentID

                clip        : true
                anchors.fill: parent

                Loader {
                    id: backgroundLoader

                    anchors.centerIn : parent
                    sourceComponent  : content

                    onLoaded: {

                        contentItem__ = item
                        contentLoaded__( contentItem__ );
                    }
                }
            }

            Rectangle {

                id:fg

                width       : bg.width
                height      : bg.height
                color       : buttonstyle.colorForeground__

                border.width: 2
                border.color: control.contentBorderColor ? control.contentBorderColor : buttonstyle.contentBorderColor
            }
        }
    }
}
