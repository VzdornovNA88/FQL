/**
******************************************************************************
* @file             ValueWidgetStyle.qml
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

WidgetButtonStyle {
    id: valueWidgetStyle

    property var valueColor : ColorHelpers
    .suitableFor(valueWidget.color)
    .in([ StyleConfigurator.theme.textGeneralCollor,
    StyleConfigurator.theme.textInvertCollor])[0].itemColor.color
    property var iconColor : ColorHelpers
    .suitableFor(valueWidget.color)
    .in([ StyleConfigurator.theme.iconGeneralCollor,
    StyleConfigurator.theme.iconInvertCollor])[0].itemColor.color
    property var unitMessureColor : ColorHelpers
    .suitableFor(valueWidget.color)
    .in([ StyleConfigurator.theme.textGeneralCollor,
    StyleConfigurator.theme.textInvertCollor])[0].itemColor.color

    property alias valueWidget: valueWidgetStyle.control

    property Component horizontalLayoutWithImage : Item {
        id: itemHorizontalLayoutWithImage

        width                  : valueWidget.width*0.9
        height                 : valueWidget.height*0.8

        anchors.centerIn: parent

        Image {
            id: img1

            anchors.bottom: itemHorizontalLayoutWithImage.verticalCenter
            anchors.right: itemHorizontalLayoutWithImage.horizontalCenter
            anchors.rightMargin: Math.round(itemHorizontalLayoutWithImage.width*0.05)

            width                  : Math.round(control.iconWidthK ? itemHorizontalLayoutWithImage.width*0.4*control.iconWidthK :
                                                                     itemHorizontalLayoutWithImage.width*0.4)
            height                 : Math.round(control.iconWidthK ? itemHorizontalLayoutWithImage.height*0.5*control.iconHeightK :
                                                                     itemHorizontalLayoutWithImage.height*0.5)

            sourceSize.width       : width
            sourceSize.height      : height

            visible                : valueWidget.iconSource && valueWidget.iconSource !== "" && width > 0 && height > 0 && img1.sourceSize.width > 0 &&
                                     img1.sourceSize.height > 0

            source                 : valueWidget.iconSource ? valueWidget.iconSource : ""

            onSourceSizeChanged: {
                if( sourceSize.width > 0 && sourceSize.height > 0 ) {
                    colorOverLay.source = img1;
                }
            }

            ColorOverlay {
                id: colorOverLay
                anchors.fill: img1
                visible: img1.visible
                color: valueWidget.iconColor ? valueWidget.iconColor : valueWidgetStyle.iconColor
            }
        }
        Text {
            id: textValue2

            height                 : itemHorizontalLayoutWithImage.height*0.25

            anchors.verticalCenter: img1.verticalCenter
            anchors.left: itemHorizontalLayoutWithImage.horizontalCenter
            anchors.leftMargin: itemHorizontalLayoutWithImage.width*0.01

            wrapMode : Text.WrapAtWordBoundaryOrAnywhere
            minimumPixelSize: 1

            font.italic: true
            property double value_ : !isNaN(valueWidget.value) ? valueWidget.value : NaN
            font.pixelSize: Math.min(itemHorizontalLayoutWithImage.width,itemHorizontalLayoutWithImage.height)*0.25*valueWidget.koefFontValuePixelSize
            text                   : !isNaN(value_) ? value_.toFixed(valueWidget.fixedPrecision).toString() :
                                                      control.textModeValue ? valueWidget.value : "---"
            color: valueWidget.valueColor ? valueWidget.valueColor : valueWidgetStyle.valueColor
        }
        Text {
            id: unitMesText2

            height                 : itemHorizontalLayoutWithImage.height*0.14

            anchors.top: itemHorizontalLayoutWithImage.verticalCenter
            //                anchors.bottom: itemHorizontalLayoutWithImage.bottom
            //                anchors.bottomMargin: itemHorizontalLayoutWithImage.height*0.1
            anchors.horizontalCenter: itemHorizontalLayoutWithImage.horizontalCenter

            text: qsTr(valueWidget.unit ? valueWidget.unit.name : "")

            font.italic: true
            wrapMode : Text.WrapAtWordBoundaryOrAnywhere
            minimumPixelSize: 1
            font.pixelSize: Math.min(itemHorizontalLayoutWithImage.width,itemHorizontalLayoutWithImage.height)*0.25*valueWidget.koefFontValuePixelSize

            color: valueWidget.unitMessureColor ? valueWidget.unitMessureColor : valueWidgetStyle.unitMessureColor
        }
    }

    property Component horizontalLayout : Item {
        id: itemRowTexts1

        width: valueWidget.width
        height: valueWidget.height

        property double fontPixSize : Math.min(valueWidget.width,valueWidget.height) *
                                      0.25*valueWidget.koefFontValuePixelSize

        Row {
            anchors.verticalCenter: itemRowTexts1.verticalCenter
            anchors.horizontalCenter: itemRowTexts1.horizontalCenter
            Text {
                id: textValue1



                wrapMode : Text.WrapAtWordBoundaryOrAnywhere
                minimumPixelSize: 1

                font.italic: true
                font.pixelSize: itemRowTexts1.fontPixSize
                text                   : (valueWidget.value && !isNaN(valueWidget.value)) ?
                                             valueWidget.value.toFixed(valueWidget.fixedPrecision).toString() : "---"
                color: valueWidget.valueColor ? valueWidget.valueColor : valueWidgetStyle.valueColor
            }
            Text {
                id: unitMesText1

                text: qsTr(valueWidget.unit ? valueWidget.unit.name : "")

                wrapMode : Text.WrapAtWordBoundaryOrAnywhere
                minimumPixelSize: 1
                font.pixelSize: itemRowTexts1.fontPixSize
                font.italic: true

                color: valueWidget.unitMessureColor ? valueWidget.unitMessureColor : valueWidgetStyle.unitMessureColor
            }
        }
    }

    property Component verticalLayout : Item {
        id: itemVerticalLayout

        width                  : valueWidget.width*0.9
        height                 : valueWidget.height*0.8

        anchors.centerIn: parent

        Image {
            id: img2

            anchors.top: itemVerticalLayout.top
            anchors.horizontalCenter: itemVerticalLayout.horizontalCenter

            width                  : control.iconWidthK ? itemVerticalLayout.width*0.45*control.iconWidthK :
                                                          itemVerticalLayout.width*0.45
            height                 : control.iconWidthK ? itemVerticalLayout.height*0.45*control.iconHeightK :
                                                          itemVerticalLayout.height*0.45
            sourceSize.width       : width
            sourceSize.height      : height

            visible                : valueWidget.iconSource && valueWidget.iconSource !== "" && width > 0 && height > 0 && img2.sourceSize.width > 0 &&
                                     img2.sourceSize.height > 0

            source                 : valueWidget.iconSource ? valueWidget.iconSource : ""

            onSourceSizeChanged: {
                if( sourceSize.width > 0 && sourceSize.height > 0 ) {
                    colorOverLay2.source = img2;
                }
            }

            ColorOverlay {
                id : colorOverLay2
                anchors.fill: img2
                visible: img2.visible
                color: valueWidget.iconColor ? valueWidget.iconColor : valueWidgetStyle.iconColor
            }
        }
        Text {
            id: textValue3

            height                 : itemVerticalLayout.height*0.25

            anchors.verticalCenter: valueWidget.iconSource !== "" ?
                                        itemVerticalLayout.verticalCenter :
                                        undefined
            anchors.bottom: valueWidget.iconSource == "" ?
                                itemVerticalLayout.verticalCenter :
                                undefined
            anchors.verticalCenterOffset: valueWidget.iconSource !== "" ? height*0.5 : 0
            anchors.horizontalCenter: itemVerticalLayout.horizontalCenter

            wrapMode : Text.WrapAtWordBoundaryOrAnywhere
            minimumPixelSize: 1

            font.italic: true
            font.pixelSize: Math.min(itemVerticalLayout.width,itemVerticalLayout.height) *
                            (valueWidget.iconSource ? 0.3 : 0.35) *
                            valueWidget.koefFontValuePixelSize
            text                   : (valueWidget.value && !isNaN(valueWidget.value)) ?
                                         valueWidget.value.toFixed(valueWidget.fixedPrecision).toString() : "---"
            color: valueWidget.valueColor ? valueWidget.valueColor : valueWidgetStyle.valueColor
        }
        Text {
            id: unitMesText3

            height                 : itemVerticalLayout.height*0.14

            anchors.top: textValue3.bottom
            anchors.topMargin: textValue3.font.pixelSize/4

            anchors.horizontalCenter: itemVerticalLayout.horizontalCenter

            text: qsTr(valueWidget.unit ? valueWidget.unit.name : "")

            wrapMode : Text.WrapAtWordBoundaryOrAnywhere
            minimumPixelSize: 1
            font.italic: true
            font.pixelSize: Math.min(itemVerticalLayout.width*0.7,itemVerticalLayout.height*0.7) *
                            (valueWidget.iconSource ? 0.3 : 0.35) *
                            valueWidget.koefFontValuePixelSize

            color: valueWidget.unitMessureColor ? valueWidget.unitMessureColor : valueWidgetStyle.unitMessureColor
        }
    }

    content : valueWidget.orientation === Qt.Vertical ?
                  verticalLayout :
                  (valueWidget.iconSource && valueWidget.iconSource !== "" ?
                       horizontalLayoutWithImage :
                       horizontalLayout)
}
