/**
******************************************************************************
* @file             Dashboard.qml
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

import "../../Core"
import "../../Controls" as FQL
import "../../Controls/widgets" as WidgetsFQL
import "../../Controls/Styles"
import "../../Resources/Colors"

Item {
    id: dashboard

    property alias rightDial : dialRight
    property alias leftDial : dialleft

    property alias lowerLeftSlider : lowerLeftSliderId
    property alias upperLeftSlider : upperLeftSliderId

    property alias lowerRightSlider : lowerRightSliderId
    property alias upperRightSlider : upperRightSliderId

    property alias leftTopMinorDial : leftTopDial
    property alias rightTopMinorDial : rightTopDial

    property alias leftBottomMinorDial : leftBottomDial
    property alias rightBottomMinorDial : rightBottomDial


    property alias centralValueWidget : valW1

    property alias gearField : indicatorsField


    property alias iconLowerLeftSlider : lowerLeftSliderImage.source
    property alias iconUpperLeftSlider : upperLeftSliderImage.source

    property var   unitMessurementOfLowerLeftSlider : UnitsMeasurement.percent
    property var   unitMessurementOfUpperLeftSlider : UnitsMeasurement.percent
    property var   unitMessurementOfLeftDial        : UnitsMeasurement.rpm
    property string textOfFactorValueLeftDial       : "x100"


    property alias iconLowerRightSlider : lowerRightSliderImage.source
    property alias iconUpperRightSlider : upperRightSliderImage.source

    property var   unitMessurementOfLowerRightSlider : UnitsMeasurement.percent
    property var   unitMessurementOfUpperRightSlider : UnitsMeasurement.bar
    property var   unitMessurementOfRightDial        : UnitsMeasurement.km_per_h
    property string textOfFactorValueRightDial       : ""




    property alias iconLeftTopMinorDial : imageOfLeftTopMinorDial.source
    property var   unitMessurementOfLeftTopMinorDial
    property string textOfFactorValueLeftTopMinorDial      : ""

    property alias iconRightTopMinorDial : imageOfRightTopMinorDial.source
    property var   unitMessurementOfRightTopMinorDial
    property string textOfFactorValueRightTopMinorDial     : ""


    property alias iconLeftBottomMinorDial : imageOfLeftBottomMinorDial.source
    property var   unitMessurementOfLeftBottomMinorDial        : UnitsMeasurement.celsius
    property string textOfFactorValueLeftBottomMinorDial     : ""

    property alias iconRightBottomMinorDial : imageOfRightBottomMinorDial.source
    property var   unitMessurementOfRightBottomMinorDial        : UnitsMeasurement.celsius
    property string textOfFactorValueRightBottomMinorDial     : ""



    property var colorText : MaterialColors.grey700
    property var colorTextValues : MaterialColors.grey700
    property var colorCommonCentralValueWidget : MaterialColors.blue600
    property var colorOnCentralValueWidget : MaterialColors.green600
    property var colorOffCentralValueWidget : MaterialColors.grey500
    property var colorTextCentralValueWidget : MaterialColors.grey50

    property double pointFontKoef : 1.0

    anchors.horizontalCenter: parent.horizontalCenter



    Item {
        id: lowerLeftSliderItem
        width: dialleft.quadrant1.width
        height: width

        anchors.centerIn: dialleft

        rotation: -65

        FQL.CircularSlider {
            id                   : lowerLeftSliderId

            anchors.right         : lowerLeftSliderItem.horizontalCenter
            anchors.bottom: lowerLeftSliderItem.verticalCenter

            activeQuadrant       : 1
            diameter             : (dialleft.quadrant2.diameter*1.3)
            koeff: 0.55
            scaleWidth : 0
            fillerWidth: dialleft.quadrant2.diameter*0.09

            colorPattern: [MaterialColors.yellow400]
            valuePattern: [minValue,maxValue]

            value: 25
        }
    }
    Item {
        id: upperLeftSliderItem
        width: dialleft.quadrant1.width
        height: width

        anchors.centerIn: dialleft

        rotation: 15

        FQL.CircularSlider {
            id                   : upperLeftSliderId

            anchors.right         : upperLeftSliderItem.horizontalCenter
            anchors.bottom: upperLeftSliderItem.verticalCenter

            activeQuadrant       : 1
            diameter             : (dialleft.quadrant2.diameter*1.3)
            koeff: 0.6
            scaleWidth : 0
            fillerWidth: dialleft.quadrant2.diameter*0.09

            colorPattern: [MaterialColors.green400]
            valuePattern: [minValue,maxValue]

            value: 57
        }
    }

    Image {
        id: lowerLeftSliderImage
        source: "qrc:/FQL/Resources/Icons/ISO7000/129.svg"

        width                  : dashboard.width*0.05
        height                 : dashboard.height*0.055

        anchors.centerIn: dialleft
        anchors.verticalCenterOffset: dialleft.quadrant2.diameter/2 + height/2

        visible: lowerLeftSliderId.visible

        Text {
            id: textLowerLeftSliderImage

            height                 : lowerLeftSliderImage.height*0.5

            anchors.left: lowerLeftSliderImage.right
            anchors.verticalCenter: lowerLeftSliderImage.verticalCenter

            wrapMode : Text.WrapAtWordBoundaryOrAnywhere
            minimumPixelSize: 1

            font.italic: true
            font.bold: true
            font.pixelSize: Math.min(lowerLeftSliderImage.width,height)*1.3*dashboard.pointFontKoef
            text                   : "/" + qsTr(dashboard.unitMessurementOfLowerLeftSlider ?
                                                  dashboard.unitMessurementOfLowerLeftSlider.name : "")

            color: dashboard.colorTextValues
        }
    }
    Image {
        id: upperLeftSliderImage
        source: "qrc:/FQL/Resources/Icons/ISO7000/240.svg"

        width                  : dashboard.width*0.05
        height                 : dashboard.height*0.055

        anchors.centerIn: dialleft
        anchors.verticalCenterOffset: -dialleft.quadrant2.diameter/2 - height

        visible: upperLeftSliderId.visible

        Text {
            id: textUpperLeftSliderImage

            height                 : upperLeftSliderImage.height*0.5

            anchors.left: upperLeftSliderImage.right
            anchors.verticalCenter: upperLeftSliderImage.verticalCenter

            wrapMode : Text.WrapAtWordBoundaryOrAnywhere
            minimumPixelSize: 1

            font.italic: true
            font.bold: true
            font.pixelSize: Math.min(upperLeftSliderImage.width,height)*1.3*dashboard.pointFontKoef
            text                   : "/" + qsTr(dashboard.unitMessurementOfUpperLeftSlider ?
                                                  dashboard.unitMessurementOfUpperLeftSlider.name : "")
            color: dashboard.colorTextValues
        }
    }

    WidgetsFQL.Dial {
        id: dialleft

        width: Math.min(dashboard.width,dashboard.height)*0.8*0.5
        height:  width

        anchors.left: dashboard.left
        anchors.verticalCenter: dashboard.verticalCenter

        minValue : 0
        maxValue : 300
        value    : 270

        quadrant3.colorPattern: [MaterialColors.blue100]
        quadrant3.valuePatternBorder: [quadrant3.minValue,quadrant3.maxValue]
        quadrant3.colorPatternBorder: [MaterialColors.grey400]
        quadrant3.colorPatternFillerBorder: [MaterialColors.blue600]

        quadrant2.colorPattern: [MaterialColors.blue100]
        quadrant2.valuePatternBorder: [quadrant2.minValue,quadrant2.maxValue]
        quadrant2.colorPatternBorder: [MaterialColors.grey400]
        quadrant2.colorPatternFillerBorder: [MaterialColors.blue600]

        quadrant1.colorPattern: [MaterialColors.blue100,MaterialColors.red100]
        quadrant1.valuePattern: [quadrant1.minValue,(quadrant1.maxValue-quadrant1.minValue)*0.66 + quadrant1.minValue,quadrant1.maxValue]
        quadrant1.colorPatternBorder: [MaterialColors.grey400,MaterialColors.red600]
        quadrant1.colorPatternFillerBorder: [MaterialColors.blue600,MaterialColors.red600]

        quadrant4.colorPattern: [MaterialColors.red100]
        quadrant4.colorPatternBorder: [MaterialColors.red600]
        quadrant4.valuePattern: [quadrant4.minValue,quadrant4.maxValue]


        quadrant3.tickmarkEnabled: true
        quadrant3.tickmarkPattern: [0.0]
        quadrant3.tickmarkLabelPattern: [0.0.toString()]
        quadrant3.koefFontPixelSizeTickmark: 2.0
        quadrant3.scaleWidth: quadrant3.diameter*0.12
        quadrant3.fillerWidth: quadrant3.diameter*0.18

        quadrant2.tickmarkEnabled: true
        quadrant2.tickmarkPattern: [100.0]
        quadrant2.tickmarkLabelPattern: [10.0.toString()]
        quadrant2.koefFontPixelSizeTickmark: 2.0
        quadrant2.scaleWidth: quadrant2.diameter*0.12
        quadrant2.fillerWidth: quadrant2.diameter*0.18

        quadrant1.tickmarkEnabled: true
        quadrant1.tickmarkPattern: [200.0]
        quadrant1.tickmarkLabelPattern: [20.0.toString()]
        quadrant1.koefFontPixelSizeTickmark: 2.0
        quadrant1.scaleWidth: quadrant1.diameter*0.12
        quadrant1.fillerWidth: quadrant1.diameter*0.18

        quadrant4.tickmarkEnabled: true
        quadrant4.tickmarkPattern: [300.0]
        quadrant4.tickmarkLabelPattern: [30.0.toString()]
        quadrant4.koefFontPixelSizeTickmark: 2.0
        quadrant4.scaleWidth: quadrant4.diameter*0.12
        quadrant4.fillerWidth: quadrant4.diameter*0.18
    }

    Item {
        id: textUpperLeftSliderItem

        width                  : dashboard.width*0.03
        height                 : dashboard.height*0.05

        anchors.bottom: centrDial.top
        anchors.bottomMargin: height*0.15
        anchors.right: centrDial.left
        anchors.rightMargin: dialleft.quadrant2.diameter/2 + width*0.85

        visible: upperLeftSliderId.visible

        Text {
            id: textValueOfUpperLeftSlider

            height                 : textUpperLeftSliderItem.height*0.5

            anchors.verticalCenter: textUpperLeftSliderItem.verticalCenter

            wrapMode : Text.WrapAtWordBoundaryOrAnywhere
            minimumPixelSize: 1

            font.italic: true
            font.pixelSize: Math.min(textLowerLeftSliderItem.width,textLowerLeftSliderItem.height)*1.1*dashboard.pointFontKoef
            text                   : ((upperLeftSliderId.value && !isNaN(upperLeftSliderId.value)) ?
                                         upperLeftSliderId.value.toFixed(0).toString() : "---")
            color: dashboard.colorTextValues
        }
    }
    Item {
        id: centrDial
        width                  : 1
        height                 : 1

        anchors.centerIn: dialleft

        visible: dialleft.visible

        Text {
            id: textValueOfLeftDial

            height                 : dashboard.height*0.05

            anchors.bottom: centrDial.top
            anchors.bottomMargin: -height*0.4
            anchors.horizontalCenter: centrDial.horizontalCenter

            wrapMode : Text.WrapAtWordBoundaryOrAnywhere
            minimumPixelSize: 1

            font.bold: true
            font.italic: true
            font.pixelSize: Math.min(textLowerLeftSliderItem.width,textMesValueOfLeftDial.height*0.5)*2.2*dashboard.pointFontKoef
            text                   : ((dialleft.value && !isNaN(dialleft.value)) ?
                                         (dialleft.value*10).toFixed(0).toString() : "---")
            color: dashboard.colorTextValues
        }
        Text {
            id: textMesValueOfLeftDial2

            height                 : dashboard.height*0.05

            anchors.bottom: centrDial.top
            anchors.bottomMargin: -height*2
            anchors.horizontalCenter: centrDial.horizontalCenter

            wrapMode : Text.WrapAtWordBoundaryOrAnywhere
            minimumPixelSize: 1

            font.italic: true
            font.pixelSize: Math.min(textLowerLeftSliderItem.width,textMesValueOfLeftDial.height)*dashboard.pointFontKoef
            text                   : dashboard.textOfFactorValueLeftDial
            color: MaterialColors.grey500
        }
        Text {
            id: textMesValueOfLeftDial

            height                 : dashboard.height*0.05

            anchors.top: textMesValueOfLeftDial2.bottom
            anchors.horizontalCenter: textMesValueOfLeftDial2.horizontalCenter

            wrapMode : Text.WrapAtWordBoundaryOrAnywhere
            minimumPixelSize: 1

            font.italic: true
            font.pixelSize: Math.min(textLowerLeftSliderItem.width,textMesValueOfLeftDial.height)*1.2*dashboard.pointFontKoef
            text                   : qsTr(dashboard.unitMessurementOfLeftDial ?
                                              dashboard.unitMessurementOfLeftDial.name : "")
            color: dashboard.colorText
        }

    }
    Item {
        id: textLowerLeftSliderItem
        width                  : dashboard.width*0.03
        height                 : dashboard.height*0.05

        anchors.top: centrDial.bottom
        anchors.topMargin: -height*0.3
        anchors.right: centrDial.left
        anchors.rightMargin: dialleft.quadrant2.diameter/2 + width*0.85

        visible: lowerLeftSliderId.visible

        Text {
            id: textValueOfLowerLeftSlider

            height                 : textLowerLeftSliderItem.height*0.5

            anchors.verticalCenter: textLowerLeftSliderItem.verticalCenter

            wrapMode : Text.WrapAtWordBoundaryOrAnywhere
            minimumPixelSize: 1

            font.italic: true
            font.pixelSize: Math.min(textLowerLeftSliderItem.width,textLowerLeftSliderItem.height)*1.1*dashboard.pointFontKoef
            text                   : ((lowerLeftSliderId.value && !isNaN(lowerLeftSliderId.value)) ?
                                         lowerLeftSliderId.value.toFixed(0).toString() : "---")
            color: dashboard.colorTextValues
        }
    }




    Item {
        id: topLeftMinorDialItem

        width: dashboard.width*0.35
        height:  dashboard.height*0.25

        anchors.bottom: midleContentItem.top
        anchors.right: midleContentItem.horizontalCenter

        visible: leftTopDial.visible

        WidgetsFQL.Dial {
            id: leftTopDial


            width: Math.min(topLeftMinorDialItem.width,topLeftMinorDialItem.height)*0.95
            height: width


            anchors.top: topLeftMinorDialItem.top
            anchors.topMargin: height*0.15
            anchors.left: topRightMinorDialItem.visible ? topLeftMinorDialItem.horizontalCenter : topLeftMinorDialItem.right
            anchors.leftMargin: topRightMinorDialItem.visible ? -width*0.3 : -width*0.5

            minValue : 0
            maxValue : 100
            value    : 83

            quadrant3.colorPattern: [MaterialColors.green100]
            quadrant3.valuePatternBorder: [quadrant3.minValue,quadrant3.maxValue]
            quadrant3.colorPatternBorder: [MaterialColors.blue600]
            quadrant3.colorPatternFillerBorder: [MaterialColors.blue600]
            quadrant3.scaleWidth: quadrant3.diameter*0.1
            quadrant3.fillerWidth: quadrant3.diameter*0.15

            quadrant3.koeff: 0.6

            quadrant2.colorPattern: [MaterialColors.green100]
            quadrant2.valuePatternBorder: [quadrant2.minValue,quadrant2.maxValue]
            quadrant2.colorPatternBorder: [MaterialColors.grey400]
            quadrant2.colorPatternFillerBorder: [MaterialColors.green600]
            quadrant2.scaleWidth: quadrant3.diameter*0.1
            quadrant2.fillerWidth: quadrant3.diameter*0.15

            quadrant1.colorPattern: [MaterialColors.green100]
            quadrant1.valuePatternBorder: [quadrant1.minValue,quadrant1.maxValue]
            quadrant1.colorPatternBorder: [MaterialColors.grey400]
            quadrant1.colorPatternFillerBorder: [MaterialColors.green600]
            quadrant1.scaleWidth: quadrant3.diameter*0.1
            quadrant1.fillerWidth: quadrant3.diameter*0.15

            quadrant4.colorPattern: [MaterialColors.red100]
            quadrant4.valuePatternBorder: [quadrant4.minValue,quadrant4.maxValue]
            quadrant4.colorPatternBorder: [MaterialColors.red600]
            quadrant4.colorPatternFillerBorder: [MaterialColors.red600]
            quadrant4.scaleWidth: quadrant3.diameter*0.1
            quadrant4.fillerWidth: quadrant3.diameter*0.15

            quadrant4.koeff: 0.6

            quadrant2.tickmarkEnabled: true
            quadrant2.tickmarkPattern: [25.0]
            quadrant2.tickmarkLabelPattern: [25.0.toString()]
            quadrant2.koefFontPixelSizeTickmark: 2.5

            quadrant1.tickmarkEnabled: true
            quadrant1.tickmarkPattern: [75.0]
            quadrant1.tickmarkLabelPattern: [75.0.toString()]
            quadrant1.koefFontPixelSizeTickmark: 2.5
        }


        Text {
            id: textValueOfLeftTopMinorDial

            height                 : leftTopDial.height*0.4

            anchors.verticalCenter: leftTopDial.verticalCenter
            anchors.verticalCenterOffset: height*0.05
            anchors.horizontalCenter: leftTopDial.horizontalCenter

            wrapMode : Text.WrapAtWordBoundaryOrAnywhere
            minimumPixelSize: 1

            font.italic: true
            font.pixelSize: Math.min(leftTopDial.width,leftTopDial.height)*0.2*dashboard.pointFontKoef
            text                   : ((leftTopDial.value && !isNaN(leftTopDial.value)) ?
                                         leftTopDial.value.toFixed(0).toString() : "---")
            color: dashboard.colorTextValues
        }
        Text {
            id: textMesValueOfLeftTopMinorDial2

            height                 : leftTopDial.height*0.15

            anchors.top: textValueOfLeftTopMinorDial.bottom
            anchors.topMargin: -height
            anchors.horizontalCenter: leftTopDial.horizontalCenter

            wrapMode : Text.WrapAtWordBoundaryOrAnywhere
            minimumPixelSize: 1

            font.italic: true
            font.pixelSize: Math.min(leftTopDial.width,leftTopDial.height)*0.12*dashboard.pointFontKoef
            text                   : dashboard.textOfFactorValueLeftTopMinorDial
            color: dashboard.colorText
        }
        Text {
            id: textMesValueOfLeftTopMinorDial

            height                 : leftTopDial.height*0.15

            anchors.top: textMesValueOfLeftTopMinorDial2.bottom
            anchors.horizontalCenter: leftTopDial.horizontalCenter

            wrapMode : Text.WrapAtWordBoundaryOrAnywhere
            minimumPixelSize: 1

            font.italic: true
            font.pixelSize: Math.min(leftTopDial.width,leftTopDial.height)*0.15*dashboard.pointFontKoef
            text                   : qsTr(dashboard.unitMessurementOfLeftTopMinorDial ?
                                              dashboard.unitMessurementOfLeftTopMinorDial.name : "")
            color: dashboard.colorText
        }
        Image {
            id: imageOfLeftTopMinorDial

            width                  : leftTopDial.width*0.25
            height                 : leftTopDial.height*0.25

            anchors.top: textMesValueOfLeftTopMinorDial.bottom
            anchors.topMargin: height*0.2
            anchors.horizontalCenter: leftTopDial.horizontalCenter
        }
    }
    Item {
        id: topRightMinorDialItem

        width: dashboard.width*0.35
        height:  dashboard.height*0.25

        anchors.bottom: midleContentItem.top
        anchors.left: midleContentItem.horizontalCenter

        visible: rightTopDial.visible

        WidgetsFQL.Dial {
            id: rightTopDial


            width: Math.min(topRightMinorDialItem.width,topRightMinorDialItem.height)*0.95
            height: width


            anchors.top: topRightMinorDialItem.top
            anchors.topMargin: height*0.15
            anchors.right: topLeftMinorDialItem.visible ? topRightMinorDialItem.horizontalCenter : topRightMinorDialItem.left
            anchors.rightMargin: topLeftMinorDialItem.visible ? -width*0.3 : -width*0.5

            minValue : 0
            maxValue : 100
            value    : 37

            quadrant3.colorPattern: [MaterialColors.green100]
            quadrant3.valuePatternBorder: [quadrant3.minValue,quadrant3.maxValue]
            quadrant3.colorPatternBorder: [MaterialColors.blue600]
            quadrant3.colorPatternFillerBorder: [MaterialColors.blue600]
            quadrant3.scaleWidth: quadrant3.diameter*0.1
            quadrant3.fillerWidth: quadrant3.diameter*0.15

            quadrant3.koeff: 0.6

            quadrant2.colorPattern: [MaterialColors.green100]
            quadrant2.valuePatternBorder: [quadrant2.minValue,quadrant2.maxValue]
            quadrant2.colorPatternBorder: [MaterialColors.grey400]
            quadrant2.colorPatternFillerBorder: [MaterialColors.green600]
            quadrant2.scaleWidth: quadrant3.diameter*0.1
            quadrant2.fillerWidth: quadrant3.diameter*0.15

            quadrant1.colorPattern: [MaterialColors.green100]
            quadrant1.valuePatternBorder: [quadrant1.minValue,quadrant1.maxValue]
            quadrant1.colorPatternBorder: [MaterialColors.grey400]
            quadrant1.colorPatternFillerBorder: [MaterialColors.green600]
            quadrant1.scaleWidth: quadrant3.diameter*0.1
            quadrant1.fillerWidth: quadrant3.diameter*0.15

            quadrant4.colorPattern: [MaterialColors.red100]
            quadrant4.valuePatternBorder: [quadrant4.minValue,quadrant4.maxValue]
            quadrant4.colorPatternBorder: [MaterialColors.red600]
            quadrant4.colorPatternFillerBorder: [MaterialColors.red600]
            quadrant4.scaleWidth: quadrant3.diameter*0.1
            quadrant4.fillerWidth: quadrant3.diameter*0.15

            quadrant4.koeff: 0.6

            quadrant2.tickmarkEnabled: true
            quadrant2.tickmarkPattern: [25.0]
            quadrant2.tickmarkLabelPattern: [25.0.toString()]
            quadrant2.koefFontPixelSizeTickmark: 2.5

            quadrant1.tickmarkEnabled: true
            quadrant1.tickmarkPattern: [75.0]
            quadrant1.tickmarkLabelPattern: [75.0.toString()]
            quadrant1.koefFontPixelSizeTickmark: 2.5
        }


        Text {
            id: textValueOfRightTopMinorDial

            height                 : rightTopDial.height*0.4

            anchors.verticalCenter: rightTopDial.verticalCenter
            anchors.verticalCenterOffset: height*0.05
            anchors.horizontalCenter: rightTopDial.horizontalCenter

            wrapMode : Text.WrapAtWordBoundaryOrAnywhere
            minimumPixelSize: 1

            font.italic: true
            font.pixelSize: Math.min(rightTopDial.width,rightTopDial.height)*0.2*dashboard.pointFontKoef
            text                   : ((rightTopDial.value && !isNaN(rightTopDial.value)) ?
                                         rightTopDial.value.toFixed(0).toString() : "---")
            color: dashboard.colorTextValues
        }
        Text {
            id: textMesValueOfRightTopMinorDial2

            height                 : rightTopDial.height*0.15

            anchors.top: textValueOfRightTopMinorDial.bottom
            anchors.topMargin: -height
            anchors.horizontalCenter: rightTopDial.horizontalCenter

            wrapMode : Text.WrapAtWordBoundaryOrAnywhere
            minimumPixelSize: 1

            font.italic: true
            font.pixelSize: Math.min(rightTopDial.width,rightTopDial.height)*0.12*dashboard.pointFontKoef
            text                   : dashboard.textOfFactorValueRightTopMinorDial
            color: dashboard.colorText
        }
        Text {
            id: textMesValueOfRightTopMinorDial

            height                 : rightTopDial.height*0.15

            anchors.top: textMesValueOfRightTopMinorDial2.bottom
            anchors.horizontalCenter: rightTopDial.horizontalCenter

            wrapMode : Text.WrapAtWordBoundaryOrAnywhere
            minimumPixelSize: 1

            font.italic: true
            font.pixelSize: Math.min(rightTopDial.width,rightTopDial.height)*0.15*dashboard.pointFontKoef
            text                   : qsTr(dashboard.unitMessurementOfLeftTopMinorDial ?
                                              dashboard.unitMessurementOfLeftTopMinorDial.name : "")
            color: dashboard.colorText
        }
        Image {
            id: imageOfRightTopMinorDial

            width                  : rightTopDial.width*0.25
            height                 : rightTopDial.height*0.25

            anchors.top: textMesValueOfRightTopMinorDial.bottom
            anchors.horizontalCenter: rightTopDial.horizontalCenter
        }
    }


    Item {
        id: midleContentItem

        height                 : dashboard.height*0.8*0.5

        anchors.left: dialleft.right
        anchors.right: dialRight.left
        anchors.verticalCenter: centrDial.verticalCenter

        clip: true

        Item {
            id: indicatorsField

            z:1

            width: midleContentItem.width*0.5
            height:  midleContentItem.height*0.2

            anchors.top: midleContentItem.top
            anchors.horizontalCenter: midleContentItem.horizontalCenter

                property int direction: 0
                property int gear: 0

                Image {
                    id : r

                    anchors.left: indicatorsField.left
                        anchors.leftMargin: indicatorsField.direction === -1 ? -r.width*0.4 : 0
                    anchors.verticalCenter: indicatorsField.verticalCenter

                    source: indicatorsField.direction === -1 ? "qrc:/FQL/Resources/Icons/Ui/R_on.svg" :
                                                               "qrc:/FQL/Resources/Icons/Ui/R_off.svg"

                    width                  : (indicatorsField.direction === -1 ? 1.2 : 0.65) * Math.min(indicatorsField.width/3 ,indicatorsField.height)
                    height                 : width
                }
                Image {
                    id : n

                    anchors.horizontalCenter: indicatorsField.horizontalCenter
                    anchors.verticalCenter: indicatorsField.verticalCenter

                    source: indicatorsField.direction ===  0 ? "qrc:/FQL/Resources/Icons/Ui/N_on.svg" :
                                                               "qrc:/FQL/Resources/Icons/Ui/N_off.svg"

                    width                  : (indicatorsField.direction === 0 ? 1.2 : 0.65) * Math.min(indicatorsField.width/3,indicatorsField.height)
                    height                 : width
                }
                Image {
                    id : d

                    anchors.right: indicatorsField.right
                        anchors.rightMargin: indicatorsField.direction === +1 ? -d.width*0.4 : 0
                    anchors.verticalCenter: indicatorsField.verticalCenter

                    source: indicatorsField.direction === +1 ? "qrc:/FQL/Resources/Icons/Ui/D_on.svg" :
                                                               "qrc:/FQL/Resources/Icons/Ui/D_off.svg"

                    width                  : (indicatorsField.direction === +1 ? 1.2 : 0.65) * Math.min(indicatorsField.width/3,indicatorsField.height)
                    height                 : width
                }
        }


        Rectangle {
            id:topContentItem
            anchors.top: indicatorsField.bottom
            anchors.horizontalCenter: indicatorsField.horizontalCenter

            width: midleContentItem.width
            height:  midleContentItem.height*0.3

            color: dashboard.colorCommonCentralValueWidget
        }

        Rectangle {
            anchors.top: topContentItem.bottom
            anchors.horizontalCenter: indicatorsField.horizontalCenter

            width: midleContentItem.width
            height:  midleContentItem.height*0.3

            color: (dialRight.value > 0 && !isNaN(dialRight.value)) ? dashboard.colorOnCentralValueWidget : dashboard.colorOffCentralValueWidget
        }

        WidgetsFQL.ValueWidget {
            id: valW1

            anchors.top: topContentItem.top
            anchors.horizontalCenter: indicatorsField.horizontalCenter

            width: midleContentItem.width
            height:  midleContentItem.height*0.6

            value: dialRight.value
            unit: dashboard.unitMessurementOfRightDial
            clickable : true

            iconSource: "qrc:/FQL/Resources/Icons/ISO7000/cruise_white.svg"
            color: MaterialColors.transparent
            valueColor: dashboard.colorTextCentralValueWidget
            unitMessureColor: dashboard.colorTextCentralValueWidget
        }

            Rectangle {
                id: recLeft

                width: dialleft.width
                height: width

                radius: dialleft.quadrant1.diameter/2
                color: dialleft.quadrant1.backgroundColor

                anchors.verticalCenter: midleContentItem.verticalCenter
                anchors.horizontalCenter: midleContentItem.left
                anchors.horizontalCenterOffset: -width*0.4
            }

            Rectangle {
                id: recRight

                width: dialRight.width
                height: width

                radius: dialRight.quadrant1.diameter/2
                color: dialleft.quadrant1.backgroundColor

                anchors.verticalCenter: midleContentItem.verticalCenter
                anchors.horizontalCenter: midleContentItem.right
                anchors.horizontalCenterOffset: width*0.4
            }
    }


    Item {
        id: bottomLeftMinorDialItem

        width: dashboard.width*0.35
        height:  dashboard.height*0.25

        anchors.top: midleContentItem.bottom
        anchors.right: midleContentItem.horizontalCenter

        visible: leftBottomDial.visible

        WidgetsFQL.Dial {
            id: leftBottomDial


            width: Math.min(bottomLeftMinorDialItem.width,bottomLeftMinorDialItem.height)*0.95
            height: width


            anchors.top: bottomLeftMinorDialItem.top
            anchors.topMargin: -height*0.15
            anchors.left: bottomRightMinorDialItem.visible ? bottomLeftMinorDialItem.horizontalCenter : bottomLeftMinorDialItem.right
            anchors.leftMargin: bottomRightMinorDialItem.visible ? -width*0.3 : -width*0.5

            minValue : 0
            maxValue : 120
            value    : 115

            quadrant3.colorPattern: [MaterialColors.green100]
            quadrant3.valuePatternBorder: [quadrant3.minValue,quadrant3.maxValue]
            quadrant3.colorPatternBorder: [MaterialColors.blue600]
            quadrant3.colorPatternFillerBorder: [MaterialColors.blue600]
            quadrant3.scaleWidth: quadrant3.diameter*0.1
            quadrant3.fillerWidth: quadrant3.diameter*0.15

            quadrant3.koeff: 0.6

            quadrant2.colorPattern: [MaterialColors.green100]
            quadrant2.valuePatternBorder: [quadrant2.minValue,quadrant2.maxValue]
            quadrant2.colorPatternBorder: [MaterialColors.grey400]
            quadrant2.colorPatternFillerBorder: [MaterialColors.green600]
            quadrant2.scaleWidth: quadrant3.diameter*0.1
            quadrant2.fillerWidth: quadrant3.diameter*0.15

            quadrant1.colorPattern: [MaterialColors.green100]
            quadrant1.valuePatternBorder: [quadrant1.minValue,quadrant1.maxValue]
            quadrant1.colorPatternBorder: [MaterialColors.grey400]
            quadrant1.colorPatternFillerBorder: [MaterialColors.green600]
            quadrant1.scaleWidth: quadrant3.diameter*0.1
            quadrant1.fillerWidth: quadrant3.diameter*0.15

            quadrant4.colorPattern: [MaterialColors.red100]
            quadrant4.valuePatternBorder: [quadrant4.minValue,quadrant4.maxValue]
            quadrant4.colorPatternBorder: [MaterialColors.red600]
            quadrant4.colorPatternFillerBorder: [MaterialColors.red600]
            quadrant4.scaleWidth: quadrant3.diameter*0.1
            quadrant4.fillerWidth: quadrant3.diameter*0.15

            quadrant4.koeff: 0.6

            quadrant3.tickmarkEnabled: true
            quadrant3.tickmarkPattern: [0.0,30.0]
            quadrant3.tickmarkLabelPattern: [0.0.toString(),30.0.toString()]
            quadrant3.koefFontPixelSizeTickmark: 2.5

            quadrant4.tickmarkEnabled: true
            quadrant4.tickmarkPattern: [90.0,120.0]
            quadrant4.tickmarkLabelPattern: [90.0.toString(),120.0.toString()]
            quadrant4.koefFontPixelSizeTickmark: 2.5
        }


        Text {
            id: textValueOfLeftBottomMinorDial

            height                 : leftBottomDial.height*0.4

            anchors.verticalCenter: leftBottomDial.verticalCenter
            anchors.verticalCenterOffset: height*0.05
            anchors.horizontalCenter: leftBottomDial.horizontalCenter

            wrapMode : Text.WrapAtWordBoundaryOrAnywhere
            minimumPixelSize: 1

            font.italic: true
            font.pixelSize: Math.min(leftBottomDial.width,leftBottomDial.height)*0.2*dashboard.pointFontKoef
            text                   : ((leftBottomDial.value && !isNaN(leftBottomDial.value)) ?
                                         leftBottomDial.value.toFixed(0).toString() : "---")
            color: dashboard.colorTextValues
        }
        Text {
            id: textMesValueOfLeftBottomMinorDial2

            height                 : leftBottomDial.height*0.15

            anchors.top: textValueOfLeftBottomMinorDial.bottom
            anchors.topMargin: -height
            anchors.horizontalCenter: leftBottomDial.horizontalCenter

            wrapMode : Text.WrapAtWordBoundaryOrAnywhere
            minimumPixelSize: 1

            font.italic: true
            font.pixelSize: Math.min(leftBottomDial.width,leftBottomDial.height)*0.12*dashboard.pointFontKoef
            text                   : dashboard.textOfFactorValueLeftBottomMinorDial
            color: dashboard.colorText
        }
        Text {
            id: textMesValueOfLeftBotomMinorDial

            height                 : leftBottomDial.height*0.15

            anchors.top: textMesValueOfLeftBottomMinorDial2.bottom
            anchors.horizontalCenter: leftBottomDial.horizontalCenter

            wrapMode : Text.WrapAtWordBoundaryOrAnywhere
            minimumPixelSize: 1

            font.italic: true
            font.pixelSize: Math.min(leftBottomDial.width,leftBottomDial.height)*0.15*dashboard.pointFontKoef
            text                   : qsTr(dashboard.unitMessurementOfLeftBottomMinorDial ?
                                              dashboard.unitMessurementOfLeftBottomMinorDial.name : "")
            color: dashboard.colorText
        }
        Image {
            id: imageOfLeftBottomMinorDial

            source: "qrc:/FQL/Resources/Icons/ISO7000/148.svg"

            width                  : leftBottomDial.width*0.25
            height                 : leftBottomDial.height*0.25

            anchors.top: textMesValueOfLeftBotomMinorDial.bottom
            anchors.topMargin: height*0.2
            anchors.horizontalCenter: leftBottomDial.horizontalCenter
        }
    }
    Item {
        id: bottomRightMinorDialItem

        width: dashboard.width*0.35
        height:  dashboard.height*0.25

        anchors.top: midleContentItem.bottom
        anchors.left: midleContentItem.horizontalCenter

        visible: rightBottomDial.visible

        WidgetsFQL.Dial {
            id: rightBottomDial

            width: Math.min(bottomRightMinorDialItem.width,bottomRightMinorDialItem.height)*0.95
            height: width


            anchors.top: bottomRightMinorDialItem.top
            anchors.topMargin: -height*0.15
            anchors.right: bottomLeftMinorDialItem.visible ? bottomRightMinorDialItem.horizontalCenter : bottomRightMinorDialItem.left
            anchors.rightMargin: bottomLeftMinorDialItem.visible ? -width*0.3 : -width*0.5

            minValue : 0
            maxValue : 120
            value    : 25

            quadrant3.colorPattern: [MaterialColors.green100]
            quadrant3.valuePatternBorder: [quadrant3.minValue,quadrant3.maxValue]
            quadrant3.colorPatternBorder: [MaterialColors.grey400]
            quadrant3.colorPatternFillerBorder: [MaterialColors.green600]
            quadrant3.scaleWidth: quadrant3.diameter*0.1
            quadrant3.fillerWidth: quadrant3.diameter*0.15

            quadrant3.koeff: 0.6

            quadrant2.colorPattern: [MaterialColors.green100]
            quadrant2.valuePatternBorder: [quadrant2.minValue,quadrant2.maxValue]
            quadrant2.colorPatternBorder: [MaterialColors.grey400]
            quadrant2.colorPatternFillerBorder: [MaterialColors.green600]
            quadrant2.scaleWidth: quadrant3.diameter*0.1
            quadrant2.fillerWidth: quadrant3.diameter*0.15

            quadrant1.colorPattern: [MaterialColors.green100]
            quadrant1.valuePatternBorder: [quadrant1.minValue,quadrant1.maxValue]
            quadrant1.colorPatternBorder: [MaterialColors.grey400]
            quadrant1.colorPatternFillerBorder: [MaterialColors.green600]
            quadrant1.scaleWidth: quadrant3.diameter*0.1
            quadrant1.fillerWidth: quadrant3.diameter*0.15

            quadrant4.colorPattern: [MaterialColors.red100]
            quadrant4.valuePatternBorder: [quadrant4.minValue,quadrant4.maxValue]
            quadrant4.colorPatternBorder: [MaterialColors.red600]
            quadrant4.colorPatternFillerBorder: [MaterialColors.red600]
            quadrant4.scaleWidth: quadrant3.diameter*0.1
            quadrant4.fillerWidth: quadrant3.diameter*0.15

            quadrant4.koeff: 0.6

            quadrant2.tickmarkEnabled: true
            quadrant2.tickmarkPattern: [0.0]
            quadrant2.tickmarkLabelPattern: [0.0.toString()]
            quadrant2.koefFontPixelSizeTickmark: 2.5

            quadrant4.tickmarkEnabled: true
            quadrant4.tickmarkPattern: [90.0,120.0]
            quadrant4.tickmarkLabelPattern: [90.0.toString(),120.0.toString()]
            quadrant4.koefFontPixelSizeTickmark: 2.5
        }


        Text {
            id: textValueOfRightBottomMinorDial

            height                 : rightBottomDial.height*0.4

            anchors.verticalCenter: rightBottomDial.verticalCenter
            anchors.verticalCenterOffset: height*0.05
            anchors.horizontalCenter: rightBottomDial.horizontalCenter

            wrapMode : Text.WrapAtWordBoundaryOrAnywhere
            minimumPixelSize: 1

            font.italic: true
            font.pixelSize: Math.min(rightBottomDial.width,rightBottomDial.height)*0.2*dashboard.pointFontKoef
            text                   : ((rightBottomDial.value && !isNaN(rightBottomDial.value)) ?
                                         rightBottomDial.value.toFixed(0).toString() : "---")
            color: dashboard.colorTextValues
        }
        Text {
            id: textMesValueOfRightBottomMinorDial2

            height                 : rightBottomDial.height*0.15

            anchors.top: textValueOfRightBottomMinorDial.bottom
            anchors.topMargin: -height
            anchors.horizontalCenter: rightBottomDial.horizontalCenter

            wrapMode : Text.WrapAtWordBoundaryOrAnywhere
            minimumPixelSize: 1

            font.italic: true
            font.pixelSize: Math.min(rightBottomDial.width,rightBottomDial.height)*0.12*dashboard.pointFontKoef
            text                   : dashboard.textOfFactorValueRightBottomMinorDial
            color: dashboard.colorText
        }
        Text {
            id: textMesValueOfRightBottomMinorDial

            height                 : rightBottomDial.height*0.15

            anchors.top: textMesValueOfRightBottomMinorDial2.bottom
            anchors.horizontalCenter: rightBottomDial.horizontalCenter

            wrapMode : Text.WrapAtWordBoundaryOrAnywhere
            minimumPixelSize: 1

            font.italic: true
            font.pixelSize: Math.min(rightBottomDial.width,rightBottomDial.height)*0.15*dashboard.pointFontKoef
            text                   : qsTr(dashboard.unitMessurementOfRightBottomMinorDial ?
                                              dashboard.unitMessurementOfRightBottomMinorDial.name : "")
            color: dashboard.colorText
        }
        Image {
            id: imageOfRightBottomMinorDial

            source: "qrc:/FQL/Resources/Icons/ISO7000/287.svg"

            width                  : rightBottomDial.width*0.25
            height                 : rightBottomDial.height*0.25

            anchors.top: textMesValueOfRightBottomMinorDial.bottom
            anchors.topMargin: height*0.2
            anchors.horizontalCenter: rightBottomDial.horizontalCenter
        }
    }




    Item {
        id: lowerRightSliderItem
        width: dialRight.quadrant1.width
        height: width

        anchors.centerIn: dialRight

        rotation: 155

        FQL.CircularSlider {
            id                   : lowerRightSliderId

            anchors.right         : lowerRightSliderItem.horizontalCenter
            anchors.bottom: lowerRightSliderItem.verticalCenter

            activeQuadrant       : 1
            diameter             : (dialRight.quadrant2.diameter*1.3)
            koeff: 0.55
            scaleWidth : 0
            fillerWidth: dialRight.quadrant2.diameter*0.09
            invert: true
            usualDrirectionFill: false

            colorPattern: [MaterialColors.green400]
            valuePattern: [minValue,maxValue]

            value: 90
        }
    }
    Item {
        id: upperRightSliderItem
        width: dialRight.quadrant1.width
        height: width

        anchors.centerIn: dialRight

        rotation: 75

        FQL.CircularSlider {
            id                   : upperRightSliderId

            anchors.right         : upperRightSliderItem.horizontalCenter
            anchors.bottom: upperRightSliderItem.verticalCenter

            activeQuadrant       : 1
            diameter             : (dialRight.quadrant2.diameter*1.3)
            koeff: 0.6
            scaleWidth : 0
            fillerWidth: dialRight.quadrant2.diameter*0.09
            invert: true
            usualDrirectionFill: false

            colorPattern: [MaterialColors.red400]
            valuePattern: [minValue,maxValue]

            value: 87
        }
    }

    Image {
        id: lowerRightSliderImage
        source: "qrc:/FQL/Resources/Icons/ISO7000/128.svg"

        width                  : dashboard.width*0.05
        height                 : dashboard.height*0.05

        anchors.centerIn: dialRight
        anchors.verticalCenterOffset: dialRight.quadrant2.diameter/2 + height/2

        visible: lowerRightSliderId.visible

        Text {
            id: textlowerRightSliderImage

            height                 : lowerRightSliderImage.height*0.5

            anchors.left: lowerRightSliderImage.right
            anchors.verticalCenter: lowerRightSliderImage.verticalCenter

            wrapMode : Text.WrapAtWordBoundaryOrAnywhere
            minimumPixelSize: 1

            font.italic: true
            font.bold: true
            font.pixelSize: Math.min(lowerRightSliderImage.width,height)*1.3*dashboard.pointFontKoef
            text                   : "/" + qsTr(dashboard.unitMessurementOfLowerRightSlider ?
                                                  dashboard.unitMessurementOfLowerRightSlider.name : "")

            color: dashboard.colorTextValues
        }
    }
    Image {
        id: upperRightSliderImage
        source: "qrc:/FQL/Resources/Icons/ISO7000/271.svg"

        width                  : dashboard.width*0.05
        height                 : dashboard.height*0.05

        anchors.centerIn: dialRight
        anchors.verticalCenterOffset: -dialRight.quadrant2.diameter/2 - height

        visible: upperRightSliderId.visible

        Text {
            id: textupperRightSliderImage

            height                 : upperRightSliderImage.height*0.5

            anchors.left: upperRightSliderImage.right
            anchors.verticalCenter: upperRightSliderImage.verticalCenter

            wrapMode : Text.WrapAtWordBoundaryOrAnywhere
            minimumPixelSize: 1

            font.italic: true
            font.bold: true
            font.pixelSize: Math.min(upperRightSliderImage.width,height)*1.3*dashboard.pointFontKoef
            text                   : "/" + qsTr(dashboard.unitMessurementOfUpperRightSlider ?
                                                  dashboard.unitMessurementOfUpperRightSlider.name : "")
            color: dashboard.colorTextValues
        }
    }

    WidgetsFQL.Dial {
        id: dialRight

        width: Math.min(dashboard.width,dashboard.height)*0.8*0.5
        height:  width

        anchors.right: dashboard.right
        anchors.verticalCenter: dashboard.verticalCenter

        minValue : 0
        maxValue : 60
        value    : 37

        quadrant3.colorPattern: [MaterialColors.blue100]
        quadrant3.valuePatternBorder: [quadrant3.minValue,quadrant3.maxValue]
        quadrant3.colorPatternBorder: [MaterialColors.grey400]
        quadrant3.colorPatternFillerBorder: [MaterialColors.blue600]

        quadrant2.colorPattern: [MaterialColors.blue100]
        quadrant2.valuePatternBorder: [quadrant2.minValue,quadrant2.maxValue]
        quadrant2.colorPatternBorder: [MaterialColors.grey400]
        quadrant2.colorPatternFillerBorder: [MaterialColors.blue600]

        quadrant1.colorPattern: [MaterialColors.blue100]
        quadrant1.valuePatternBorder: [quadrant1.minValue,quadrant1.maxValue]
        quadrant1.colorPatternBorder: [MaterialColors.grey400]
        quadrant1.colorPatternFillerBorder: [MaterialColors.blue600]

        quadrant4.colorPattern: [MaterialColors.red100]
        quadrant4.colorPatternBorder: [MaterialColors.red600]
        quadrant4.valuePattern: [quadrant4.minValue,quadrant4.maxValue]


        quadrant3.tickmarkEnabled: true
        quadrant3.tickmarkPattern: [0.0]
        quadrant3.tickmarkLabelPattern: [0.0.toString(),15.0.toString()]
        quadrant3.koefFontPixelSizeTickmark: 2.0
        quadrant3.scaleWidth: quadrant3.diameter*0.12
        quadrant3.fillerWidth: quadrant3.diameter*0.18

        quadrant2.tickmarkEnabled: true
        quadrant2.tickmarkPattern: [15.0]
        quadrant2.tickmarkLabelPattern: [15.0.toString()]
        quadrant2.koefFontPixelSizeTickmark: 2.0
        quadrant2.scaleWidth: quadrant2.diameter*0.12
        quadrant2.fillerWidth: quadrant2.diameter*0.18

        quadrant1.tickmarkEnabled: true
        quadrant1.tickmarkPattern: [30.0,45.0]
        quadrant1.tickmarkLabelPattern: [30.0.toString(),45.0.toString()]
        quadrant1.koefFontPixelSizeTickmark: 2.0
        quadrant1.scaleWidth: quadrant1.diameter*0.12
        quadrant1.fillerWidth: quadrant1.diameter*0.18

        quadrant4.tickmarkEnabled: true
        quadrant4.tickmarkPattern: [60.0]
        quadrant4.tickmarkLabelPattern: [60.0.toString()]
        quadrant4.koefFontPixelSizeTickmark: 2.0
        quadrant4.scaleWidth: quadrant4.diameter*0.12
        quadrant4.fillerWidth: quadrant4.diameter*0.18
    }

    Item {
        id: textupperRightSliderItem

        width                  : dashboard.width*0.03
        height                 : dashboard.height*0.05

        anchors.bottom: centrRightDial.top
        anchors.bottomMargin: height*0.15
        anchors.left: centrRightDial.right
        anchors.leftMargin: dialRight.quadrant2.diameter/2 + width*0.7

        visible: upperRightSliderId.visible

        Text {
            id: textValueOfUpperRightSlider

            height                 : textupperRightSliderItem.height*0.5

            anchors.verticalCenter: textupperRightSliderItem.verticalCenter

            wrapMode : Text.WrapAtWordBoundaryOrAnywhere
            minimumPixelSize: 1

            font.italic: true
            font.pixelSize: Math.min(textlowerRightSliderItem.width,textlowerRightSliderItem.height)*1.1*dashboard.pointFontKoef
            text                   : ((upperRightSliderId.value && !isNaN(upperRightSliderId.value)) ?
                                         upperRightSliderId.value.toFixed(0).toString() : "---")
            color: dashboard.colorTextValues
        }
    }
    Item {
        id: centrRightDial
        width                  : 1
        height                 : 1

        anchors.centerIn: dialRight

        visible: dialRight.visible

        Text {
            id: textValueOfRightDial

            height                 : dashboard.height*0.05

            anchors.bottom: centrRightDial.top
            anchors.bottomMargin: -height*0.4
            anchors.horizontalCenter: centrRightDial.horizontalCenter

            wrapMode : Text.WrapAtWordBoundaryOrAnywhere
            minimumPixelSize: 1

            font.bold: true
            font.italic: true
            font.pixelSize: Math.min(textlowerRightSliderItem.width,textMesValueORightDial.height*0.5)*2.2*dashboard.pointFontKoef
            text                   : ((dialRight.value && !isNaN(dialRight.value)) ?
                                         (dialRight.value).toFixed(0).toString() : "---")
            color: dashboard.colorTextValues
        }
        Text {
            id: textMesValueORightDial2

            height                 : dashboard.height*0.05

            anchors.bottom: centrRightDial.top
            anchors.bottomMargin: -height*2
            anchors.horizontalCenter: centrRightDial.horizontalCenter

            wrapMode : Text.WrapAtWordBoundaryOrAnywhere
            minimumPixelSize: 1

            font.italic: true
            font.pixelSize: Math.min(textLowerLeftSliderItem.width,textMesValueOfLeftDial.height)*dashboard.pointFontKoef
            text                   : dashboard.textOfFactorValueRightDial
            color: MaterialColors.grey500
        }
        Text {
            id: textMesValueORightDial

            height                 : dashboard.height*0.05

            anchors.top: textMesValueORightDial2.bottom
            anchors.horizontalCenter: textMesValueORightDial2.horizontalCenter

            wrapMode : Text.WrapAtWordBoundaryOrAnywhere
            minimumPixelSize: 1

            font.italic: true
            font.pixelSize: Math.min(textlowerRightSliderItem.width,textMesValueORightDial.height)*1.2*dashboard.pointFontKoef
            text                   : qsTr(dashboard.unitMessurementOfRightDial ?
                                              dashboard.unitMessurementOfRightDial.name : "")
            color: dashboard.colorText
        }

    }
    Item {
        id: textlowerRightSliderItem
        width                  : dashboard.width*0.03
        height                 : dashboard.height*0.05

        anchors.top: centrRightDial.bottom
        anchors.topMargin: -height*0.3
        anchors.left: centrRightDial.right
        anchors.leftMargin: dialRight.quadrant2.diameter/2 + width*0.7

        visible: lowerRightSliderId.visible

        Text {
            id: textValueOfLowerRightSlider

            height                 : textlowerRightSliderItem.height*0.5

            anchors.verticalCenter: textlowerRightSliderItem.verticalCenter

            wrapMode : Text.WrapAtWordBoundaryOrAnywhere
            minimumPixelSize: 1

            font.italic: true
            font.pixelSize: Math.min(textlowerRightSliderItem.width,textlowerRightSliderItem.height)*1.1*dashboard.pointFontKoef
            text                   : ((lowerRightSliderId.value && !isNaN(lowerRightSliderId.value)) ?
                                         lowerRightSliderId.value.toFixed(0).toString() : "---")
            color: dashboard.colorTextValues
        }
    }

}
