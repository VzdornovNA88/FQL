/**
******************************************************************************
* @file             BaseValueButtonStyle.qml
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
import QtQuick.Window 2.2

import "../../../../Resources/Colors"
import "../../../../Core/ColorHelpers.js" as ColorHelpers

ButtonBaseStyle {
    id: buttonstyle

    property var colorDefaultText : ( ColorHelpers
                                     .suitableFor(color__)
                                     .in([ MaterialColors.grey50,
                                          MaterialColors.blue50,
                                          MaterialColors.blueGrey50,
                                          MaterialColors.amber50,
                                          MaterialColors.grey900,
                                          MaterialColors.blue900,
                                          MaterialColors.blueGrey900,
                                          MaterialColors.amber900 ])[0].itemColor.color )

    content : Row {
        id: row

        property var pointSize__   : undefined === control.textPointSize ?
                                       (control.width*110/Screen.width) : control.textPointSize

        spacing                    : 5

        Image {
            id: img
            width                  : img.sourceSize.width > 0 ? control.width*0.15 : 0
            height                 : img.sourceSize.height > 0 ? control.height*0.45 :0
            source                 : control.iconSource
            anchors.verticalCenter : parent.verticalCenter
        }
        Text {
            id: text

            anchors.bottom : parent.bottom

            font.pointSize         : row.pointSize__
            text                   : control.text
            color                  : undefined === control.color_text ?
                                     buttonstyle.colorDefaultText : control.color_text
        }
        Text {
            id: textMeasuringUnit

            anchors.bottom : parent.bottom
            anchors.bottomMargin: 5

            font.pointSize         : row.pointSize__/2
            text                   : qsTr(control.unit ? control.unit.name : "")
            color                  : undefined === control.colorTextUnitOfMeasurement ?
                                         text.color : control.colorTextUnitOfMeasurement
        }
    }
}
