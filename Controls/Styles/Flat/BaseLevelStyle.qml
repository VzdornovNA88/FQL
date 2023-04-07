/**
******************************************************************************
* @file             BaseLevelStyle.qml
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
import "../../Private"
import "../../../Controls" as FQL
import "../../widgets" as Widgets
import "../../../Core"

Style {
    id: styleitem

    property var colorLevel                   : StyleConfigurator.theme.systemAccnetSuccessActiveCollor
    property var colorDisplay                 : StyleConfigurator.theme.backgroundGeneral3Collor
    property var colorText                    : StyleConfigurator.theme.textGeneralCollor
    property var colorDisabled                : StyleConfigurator.theme.lighter50Collor
    property var borderColor                  : StyleConfigurator.theme.borderGeneralCollor
    property var colorHandle                  : StyleConfigurator.theme.backgroundAccentCollor

    readonly property int fixedPrecision      : control.fixedPrecision

    property Component horizontalLayout : Component {

        Item {
            id: horizontalLayoutItem

            width: control.width
            height: control.height

            function getIdxOfMaskedValueFor(vaulePattern_,currentValue) {
                if( vaulePattern_.length !== undefined && vaulePattern_.length > 0 )
                    for(var i_ = 0; i_ < vaulePattern_.length; i_++) {
                        if( Math.abs(vaulePattern_[i_] - currentValue) <= 1e-6 ){
                            idxOfMaskedValue__ = i_;
                            return idxOfMaskedValue__;
                        }
                    }
                return idxOfMaskedValue__;
            }

            property int idxOfMaskedValue__ : 0

            Column {
                id: layout

                width: horizontalLayoutItem.width
                height: horizontalLayoutItem.height

                spacing: 0

                Item{
                    id: header

                    width: layout.width
                    height: layout.height/3

                    Text {
                        id: headerText

                        anchors.top: header.top
                        anchors.horizontalCenter: header.horizontalCenter
                        text: qsTr(control.headerText) + ", " + qsTr(control.unit ? control.unit.name : "")

                        wrapMode : Text.WrapAtWordBoundaryOrAnywhere
                        minimumPixelSize: 1
                        font.pixelSize: Math.min(header.width,header.height*2)*0.2

                        color: control.colorText ? control.colorText : colorText
                    }

                    Text {
                        id: curValText

                        anchors.bottom: header.bottom
                        x : slider.__style.handlePosition
                        text:    qsTr( (control.maskLevelPattern.length && control.maskLevelPattern.length > 0) ?
                                            control.maskLevelPattern[horizontalLayoutItem.getIdxOfMaskedValueFor(control.levelPattern,slider.value)] :
                                          slider.value.toFixed(fixedPrecision))

                        wrapMode : Text.WrapAtWordBoundaryOrAnywhere
                        minimumPixelSize: 1
                        font.bold: true
                        font.pixelSize: Math.min(header.width,header.height*2.0)*0.2

                        color: control.colorText ? control.colorText : colorText
                    }
                }

                FQL.Slider {
                    id: slider

                    width: layout.width
                    height: layout.height/6

                    color: control.colorLevel ? control.colorLevel : colorLevel
                    clip: true
                    fullSizeOfControlArea: true
                    tickmarksEnabled: control.tickmarksEnabled
                    borderWidth: 0
                    minimumValue: control.min
                    maximumValue: control.max
                    stepSize: control.step
                    enabled: control.enabled
                    value: control.value
                    valueCurrent: control.valueCurrent

                    handle: Image {
                        id : img
                        source: "qrc:/FQL/Resources/Icons/Ui/Vector1lb.svg"

                        width:  height
                        height: slider.height*1.2

                        y: height*0.003
                        rotation: 90

                        ColorOverlay {
                            anchors.fill: img
                            source: img
                            color: control.colorHandle ? control.colorHandle : styleitem.colorHandle
                        }
                    }

                    Component.onCompleted: {
                        control.__valueSetPoint = Qt.binding(function(){
                            return slider.valueSetPoint.toFixed(fixedPrecision);
                        })
                    }
                }

                Item {
                    id: itemSlider
                    width: layout.width
                    height: layout.height/6

                    visible: control.hintVisible

                    Text {
                        id: minVal

                        anchors.left: itemSlider.left
                        text: qsTr((control.maskLevelPattern &&
                                     control.maskLevelPattern.length &&
                                     control.maskLevelPattern.length > 0 &&
                                     control.maskLevelPattern[control.maskLevelPattern.length - 1]) ?
                                       control.maskLevelPattern[0] :
                                       control.min.toString())

                        wrapMode : Text.WrapAtWordBoundaryOrAnywhere
                        minimumPixelSize: 1
                        font.pixelSize: Math.min(itemSlider.width/2,itemSlider.height)*0.7

                        color: control.colorText ? control.colorText : colorText
                    }

                    Text {
                        id: maxVal

                        anchors.right: itemSlider.right
                        text: qsTr((control.maskLevelPattern &&
                                    control.maskLevelPattern.length &&
                                    control.maskLevelPattern.length > 0 &&
                                    control.maskLevelPattern[control.maskLevelPattern.length - 1]) ?
                                       control.maskLevelPattern[control.maskLevelPattern.length - 1] :
                                       control.max.toString())

                        wrapMode : Text.WrapAtWordBoundaryOrAnywhere
                        minimumPixelSize: 1
                        font.pixelSize: Math.min(itemSlider.width/2,itemSlider.height)*0.7

                        color: control.colorText ? control.colorText : colorText
                    }
                }

                Rectangle {
                    id: display

                    width: layout.width
                    height: layout.height/3

                    border.color: borderColor
                    border.width: 1
                    color: control.colorDisplay ? control.colorDisplay : colorDisplay

                    Text {
                        id: curValDisplay
                        anchors.left: display.left
                        anchors.leftMargin: + display.width*0.05
                        anchors.verticalCenter: targetValDisplay.verticalCenter
                        text: qsTr(control.valueCurrent.toString()/*.toFixed(fixedPrecision)*/)

                        wrapMode : Text.WrapAtWordBoundaryOrAnywhere
                        minimumPixelSize: 1
                        font.pixelSize: Math.min(display.width/2,display.height/2)*0.7

                        color: control.colorText ? control.colorText : colorText
                    }

                    Text {
                        id: targetValDisplay
                        anchors.horizontalCenter: display.horizontalCenter
                        anchors.verticalCenter: display.verticalCenter
                        anchors.verticalCenterOffset: - display.height/8
                        text: qsTr( (control.maskLevelPattern.length && control.maskLevelPattern.length > 0) ?
                                       control.maskLevelPattern[horizontalLayoutItem.getIdxOfMaskedValueFor(control.levelPattern,slider.value)] :
                                     control.value.toFixed(fixedPrecision)) + " " + qsTr(control.unit ? control.unit.name : "")

                        wrapMode : Text.WrapAtWordBoundaryOrAnywhere
                        minimumPixelSize: 1
                        font.bold: true
                        font.pixelSize: Math.min(display.width,display.height*2.0)*0.225

                        color: control.colorText ? control.colorText : colorText
                    }
                    visible: control.displayVisible
                }
            }

            Rectangle {
                id: disabler

                width: horizontalLayoutItem.width
                height: horizontalLayoutItem.height

                color: control.enabled ?
                           StyleConfigurator.theme.transparent :
                           colorDisabled
            }
        }
    }

    property Component panel: Loader {
        id: loaderOfLayouts
        sourceComponent: horizontalLayout
    }
}
