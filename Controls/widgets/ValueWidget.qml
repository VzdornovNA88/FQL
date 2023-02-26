/**
******************************************************************************
* @file             ValueWidget.qml
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

import QtQuick 2.0

import "../../Resources/Colors"
import "../" as FQL
import "../widgets"
import "../../Core"
import "../../Core/ColorHelpers.js" as ColorHelpers

ContentItem {
    id: valueWidget

    property int orientation : Qt.Vertical

    property double value
    property UnitMeasurement unit
    property var valueColor                : MaterialColors.grey900
    property var unitMessureColor          : MaterialColors.grey900

    property var iconSource
    property double koefFontValuePixelSize : 1
    property int fixedPrecision            : 0


    color                                  : MaterialColors.transparent
    clickable                              : false

    // TODO : replace content to style and CalueWidget should be Control
    property Component horizontalLayoutWithImage : Item {
        id: itemHorizontalLayoutWithImage

        width                  : valueWidget.width*0.9
        height                 : valueWidget.height*0.8

        anchors.centerIn: parent

            Image {
                id: img1

                anchors.top: itemHorizontalLayoutWithImage.top
                anchors.topMargin: itemHorizontalLayoutWithImage.height*0.1
                anchors.right: itemHorizontalLayoutWithImage.horizontalCenter
                anchors.rightMargin: itemHorizontalLayoutWithImage.width*0.05

                width                  : itemHorizontalLayoutWithImage.width*0.35
                height                 : itemHorizontalLayoutWithImage.height*0.35
                source                 : valueWidget.iconSource ? valueWidget.iconSource : ""
            }
            Text {
                id: textValue2

                height                 : itemHorizontalLayoutWithImage.height*0.25

                anchors.verticalCenter: img1.verticalCenter
                anchors.left: itemHorizontalLayoutWithImage.horizontalCenter
                anchors.leftMargin: itemHorizontalLayoutWithImage.width*0.05

                wrapMode : Text.WrapAtWordBoundaryOrAnywhere
                minimumPixelSize: 1

                font.pixelSize: Math.min(itemHorizontalLayoutWithImage.width,itemHorizontalLayoutWithImage.height)*0.25*valueWidget.koefFontValuePixelSize
                text                   : (valueWidget.value && !isNaN(valueWidget.value)) ?
                                             valueWidget.value.toFixed(valueWidget.fixedPrecision).toString() : "---"
                color: valueWidget.valueColor ? valueWidget.valueColor : MaterialColors.grey900
            }
            Text {
                id: unitMesText2

                height                 : itemHorizontalLayoutWithImage.height*0.14

                anchors.verticalCenter: itemHorizontalLayoutWithImage.verticalCenter
                anchors.horizontalCenter: itemHorizontalLayoutWithImage.horizontalCenter

                text: qsTr(valueWidget.unit ? valueWidget.unit.name : "")

                wrapMode : Text.WrapAtWordBoundaryOrAnywhere
                minimumPixelSize: 1
                font.pixelSize: Math.min(itemHorizontalLayoutWithImage.width,itemHorizontalLayoutWithImage.height)*0.25*valueWidget.koefFontValuePixelSize

                color: valueWidget.unitMessureColor ? valueWidget.unitMessureColor : MaterialColors.grey900
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

                font.pixelSize: itemRowTexts1.fontPixSize
                text                   : (valueWidget.value && !isNaN(valueWidget.value)) ?
                                             valueWidget.value.toFixed(valueWidget.fixedPrecision).toString() : "---"
                color: valueWidget.valueColor ? valueWidget.valueColor : MaterialColors.grey900
            }
            Text {
                id: unitMesText1

                text: qsTr(valueWidget.unit ? valueWidget.unit.name : "")

                wrapMode : Text.WrapAtWordBoundaryOrAnywhere
                minimumPixelSize: 1
                font.pixelSize: itemRowTexts1.fontPixSize

                color: valueWidget.unitMessureColor ? valueWidget.unitMessureColor : MaterialColors.grey900
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
                anchors.topMargin: itemVerticalLayout.height*0.1
                anchors.horizontalCenter: itemVerticalLayout.horizontalCenter

                width                  : itemVerticalLayout.width*0.35
                height                 : itemVerticalLayout.height*0.35
                source                 : valueWidget.iconSource ? valueWidget.iconSource : ""
            }
            Text {
                id: textValue3

                height                 : itemVerticalLayout.height*0.25

                anchors.verticalCenter: itemVerticalLayout.verticalCenter
                anchors.horizontalCenter: itemVerticalLayout.horizontalCenter

                wrapMode : Text.WrapAtWordBoundaryOrAnywhere
                minimumPixelSize: 1

                font.pixelSize: Math.min(itemVerticalLayout.width,itemVerticalLayout.height)*0.25*valueWidget.koefFontValuePixelSize
                text                   : (valueWidget.value && !isNaN(valueWidget.value)) ?
                                             valueWidget.value.toFixed(valueWidget.fixedPrecision).toString() : "---"
                color: valueWidget.valueColor ? valueWidget.valueColor : MaterialColors.grey900
            }
            Text {
                id: unitMesText3

                height                 : itemVerticalLayout.height*0.14

                anchors.top: textValue3.bottom

                anchors.horizontalCenter: itemVerticalLayout.horizontalCenter

                text: qsTr(valueWidget.unit ? valueWidget.unit.name : "")

                wrapMode : Text.WrapAtWordBoundaryOrAnywhere
                minimumPixelSize: 1
                font.pixelSize: Math.min(itemVerticalLayout.width,itemVerticalLayout.height)*0.25*valueWidget.koefFontValuePixelSize

                color: valueWidget.unitMessureColor ? valueWidget.unitMessureColor : MaterialColors.grey900
            }
    }

    Loader {
        id : loaderLayout
        sourceComponent: orientation == Qt.Vertical ? verticalLayout : (valueWidget.iconSource ? horizontalLayoutWithImage : horizontalLayout)
    }
}
