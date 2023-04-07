/**
******************************************************************************
* @file             ButtonStyle.qml
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

import FQL.Compat.Effects.ColorOverlay 1.0

import "../../../Resources/Colors"
import "../../../Core/ColorHelpers.js" as ColorHelpers
import "../../../Core"

ButtonBaseStyle {
    id: buttonstyle

    property var colorDefaultText : ( ColorHelpers
                                     .suitableFor(color__)
                                     .in([ MaterialColors.blue50,
                                          MaterialColors.blueGrey50,
                                          MaterialColors.amber50,
                                          MaterialColors.blue900,
                                          MaterialColors.blueGrey900,
                                          MaterialColors.amber900,
                                          StyleConfigurator.theme.textAccentCollor,
                                          StyleConfigurator.theme.textGeneralCollor,
                                          StyleConfigurator.theme.textGeneral2Collor,
                                          StyleConfigurator.theme.textInvertCollor])[0].itemColor.color )

    property var iconColor : StyleConfigurator.theme.iconGeneralCollor

    content : Row  {
        id: row

        spacing                    : 5

        Image {
            id: img

            width                  : img.sourceSize.width > 0 ? Math.min(control.width,control.height)*0.5 : 0
            height                 : img.sourceSize.height > 0 ? width :0
            source                 : control.iconSource
            anchors.verticalCenter : parent.verticalCenter

            ColorOverlay {
                anchors.fill: img
                source: img
                color: control.iconColor ? control.iconColor : buttonstyle.iconColor
            }
        }
        Text {
            id: text

            anchors.verticalCenter : parent.verticalCenter

            wrapMode : Text.WrapAtWordBoundaryOrAnywhere
            minimumPixelSize: 1
            font.bold: true
            font.pixelSize: Math.min(control.width*0.5,control.height*2.0)*0.2*control.textKoeffPointSize

            text                   : control.text
            color                  : undefined === control.color_text ?
                                     colorDefaultText : control.color_text
        }
    }
}
