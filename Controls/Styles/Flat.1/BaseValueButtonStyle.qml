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

import FQL.Compat.Effects.ColorOverlay 1.0
import FQL.Resources.Colors 1.0
import FQL.Core.Meta 1.0
import FQL.Core.Base 1.0
import FQL.Controls.Private 1.0

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

    content : Row {
        id: row

        width                  : control.width
        height                 : control.height

        property var pointSize__   : undefined === control.textKoeffPointSize ?
                                       Math.min(row.width,row.height*2.0)*0.2 :
                                         Math.min(row.width,row.height*2.0)*0.2*control.textKoeffPointSize

        spacing                    : 2

        Item {
            id : itemImg
            width                  : Math.round(control.iconSource !== undefined &&
                                     control.iconSource !== null &&
                                     control.iconSource !== "" ?
                                         (control.iconWidth ? control.iconWidth : row.width*0.45) :
                                         row.width*0.1)
            height                 : Math.round(control.iconSource !== undefined &&
                                     control.iconSource !== null &&
                                     control.iconSource !== "" ?
                                         (control.iconHeight ? control.iconHeight : row.height*0.45) :
                                         row.height*0.1)
            anchors.verticalCenter : parent.verticalCenter
        Image {
            id: img
            width                  : Math.round(control.iconSource !== undefined &&
                                     control.iconSource !== null &&
                                     control.iconSource !== "" ?
                                         (control.iconWidth ? control.iconWidth : row.width*0.45) :
                                         row.width*0.1)
            height                 : Math.round(control.iconSource !== undefined &&
                                     control.iconSource !== null &&
                                     control.iconSource !== "" ?
                                         (control.iconHeight ? control.iconHeight : row.height*0.45) :
                                         row.height*0.1)
            sourceSize.width       : width
            sourceSize.height      : height

            visible                : control.iconSource && control.iconSource !== "" && width > 0 && height > 0 && img.sourceSize.width > 0 &&
                                     img.sourceSize.height > 0

            source                 : control.iconSource ? control.iconSource : ""

            anchors.verticalCenter : itemImg.verticalCenter

            onSourceSizeChanged: {
                if( sourceSize.width > 0 && sourceSize.height > 0 ) {
                    colorOverLay.source = img;
                }
            }

            ColorOverlay {
                id : colorOverLay
                anchors.fill: img
                source: img
                visible: img.visible
                color: control.iconColor ? control.iconColor : StyleConfigurator.theme.iconGeneralCollor
            }
        }
        }
        Text {
            id: text

            anchors.verticalCenter : itemImg.verticalCenter

            font.pixelSize         : row.pointSize__
            text                   : control.text
            color                  : undefined === control.color_text ?
                                     buttonstyle.colorDefaultText : control.color_text

            font.italic            : true
        }
        Text {
            id: textMeasuringUnit

            anchors.verticalCenter : itemImg.verticalCenter

            font.pixelSize         : row.pointSize__*0.7
            text                   : qsTr(control.unit ? control.unit.name : "")
            color                  : undefined === control.colorTextUnitOfMeasurement ?
                                         text.color : control.colorTextUnitOfMeasurement

            font.italic            : true
        }
    }
}
