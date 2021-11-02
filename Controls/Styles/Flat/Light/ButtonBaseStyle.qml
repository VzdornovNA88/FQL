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
import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0

import "../../../../Resources/Colors"
import "../../../../Core/ColorHelpers.js" as ColorHelpers

Style {
    id: buttonstyle

    property var colorActiveFocus        : MaterialColors.pink300
    property var colorDisabled           : ColorHelpers.addAlpha( 0.5,MaterialColors.grey50  )
    property var colorBorderActiveFocus  : MaterialColors.grey900
    property var colorPressed            : ColorHelpers.addAlpha( 0.2,MaterialColors.grey900 )
    property var colorEnabled            : MaterialColors.pink700
    property var colorCheked             : colorPressed

    property var widthOfBorder                : 1

    property Component content                : null
    property QtObject  contentItem__          : null

    signal contentLoaded__(QtObject item_)


    readonly
    property Control   control                : __control

    readonly
    property bool      down                   : control.pressed

    readonly
    property bool      checked__              : (control.checkable && control.checked)
    readonly
    property var       color__                : undefined === control.color ?
                                                    buttonstyle.colorEnabled : control.color

    readonly
    property var colorForeground__            : buttonstyle.control.enabled     ?
                                                 ( buttonstyle.down             ?
                                                    buttonstyle.colorPressed    :
                                                 ( buttonstyle.checked__        ?
                                                    buttonstyle.colorCheked     :
                                                 MaterialColors.transparent ) ) :
                                                buttonstyle.colorDisabled

    property Component panel: Rectangle {
        id : focusable

        width               : control.width
        height              : control.height
        border.width        : widthOfBorder
        border.pixelAligned : true
        border.color        : control.borderFocus ?
                                  ( control.activeFocus ?
                                       buttonstyle.colorBorderActiveFocus :
                                       MaterialColors.transparent ) :
                                  MaterialColors.transparent

        color               : MaterialColors.transparent

        Rectangle {

            id:bg

            width           : focusable.width- 6
            height          : focusable.height - 6

            anchors.centerIn: parent

            color           : control.borderFocus ?
                                  ( buttonstyle.checked__        ?
                                     MaterialColors.transparent     :
                                  buttonstyle.color__ )   :
                                  buttonstyle.down ?
                                      buttonstyle.color__ :
                                      ( control.activeFocus ?
                                           buttonstyle.colorActiveFocus :
                                           ( buttonstyle.checked__        ?
                                              MaterialColors.transparent     :
                                           buttonstyle.color__ ))

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
            }
        }
    }
}
