/**
******************************************************************************
* @file             SettingPanel.qml
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

import FQL.Core.Base 1.0
import FQL.Controls.Base 1.0
import FQL.Resources.Colors 1.0

Item {
    id: settingPanel

    property alias iconSourceBtnInc  : inc.iconSource
    property alias iconSourceBtnDec  : dec.iconSource
    property alias iconSourceBtnFunc : func.iconSource

    property alias colorBtnInc       : inc.color
    property alias colorBtnDec       : dec.color
    property alias colorBtnFunc      : func.color

    property alias textBtnInc        : inc.text
    property alias textBtnDec        : dec.text
    property alias textBtnFunc       : func.text

    property alias enabledBtnFunc    : func.enabled
    property alias enabledBtnInc     : inc.enabled
    property alias enabledBtnDec     : dec.enabled

    property alias visibleBtnFunc    : func.visible
    property alias checkabledBtnFunc : func.checkable
    property alias checkedBtnFunc    : func.checked

    property alias min               : level.min
    property alias max               : level.max
    property real  valueSetPoint     : 0
    readonly property alias level    : level.value
    property alias step              : level.step
    property alias stepByButtons     : level.step
    property alias valueCurrent      : level.valueCurrent
//    property alias orientation
    property alias enabled           : level.enabled
    property alias colorLevel        : level.colorLevel
    property alias colorDisplay      : level.colorDisplay
    property alias colorText         : level.colorText
    property alias colorHandle       : level.colorHandle
    property alias unit              : level.unit
    property alias hintVisible       : level.hintVisible
    property alias displayVisible    : level.displayVisible
    property alias headerText        : level.headerText
    property alias fixedPrecision    : level.fixedPrecision
    property alias levelPattern      : level.levelPattern
    property alias maskLevelPattern  : level.maskLevelPattern
    property alias tickmarksEnabled  : level.tickmarksEnabled

    property real  koeffStepHoldingButton : 1.0

    signal clickedInc
    signal pressedAndHoldedInc
    signal clickedDec
    signal pressedAndHoldedDec
    signal clickedOnFunctionButton

    Component.onCompleted: {
        if(level.enabled) {
            level.value = settingPanel.valueSetPoint;
        }
    }

    onValueSetPointChanged:    {
        if(level.enabled) {
            level.value = settingPanel.valueSetPoint;
        }
    }

    Column {
        id: columnID

        spacing: settingPanel.height*0.05

        Level {
            id: level

            width: settingPanel.width
            height: settingPanel.height*0.7

            onEnabledChanged: {
                if(level.enabled) {
                    level.value = settingPanel.valueSetPoint;
                }
            }

            onValueChanged: {
                if(level.enabled) {
                    settingPanel.valueSetPoint = level.value;
                }
            }

            onValueSetPointChanged: {
                settingPanel.valueSetPoint = level.valueSetPoint;
            }

            onDisplayVisibleChanged: {
                rowBtns.y = !level.displayVisible ? level.height/3 + level.height/6 + columnID.spacing + (level.hintVisible ? level.height/6 : 0) : level.height + columnID.spacing
            }
        }

        Item {
            id: rowBtns

            width: settingPanel.width
            height: settingPanel.height*0.2

            onYChanged: {
                y = !level.displayVisible ? level.height/3 + level.height/6 + columnID.spacing + (level.hintVisible ? level.height/6 : 0) : level.height + columnID.spacing
            }

            property double spacing: 2

            Button {
                id: inc

                width: rowBtns.width/3 - rowBtns.spacing*3
                height: rowBtns.height

                anchors.right: rowBtns.right
                anchors.verticalCenter: rowBtns.verticalCenter

                color: StyleConfigurator.theme.buttonGeneralCollor

                focus: true
                textKoeffPointSize: 3.0

                enabled: valueSetPoint < max

                function inc_(step_) {
                    var value_ = 0.0;
                    var val_   = 0.0;

                    value_ = valueSetPoint;
                    val_ = value_ + step_;
                    if( val_ > max ) val_ = max;
                    valueSetPoint = val_;
                }

                onClicked: {
                    inc_(stepByButtons);
                    clickedInc();
                }

                Timer {
                    id: timerInc
                    interval: 1000
                    repeat: true
                    onTriggered: {
                        inc.inc_(stepByButtons*koeffStepHoldingButton);
                    }
                }

                onPressedChanged: {
                    if( !timerInc.running )
                        timerInc.start();
                    else
                        timerInc.stop();
                }
            }

            Button {
                id: func

                width: rowBtns.width/3 - rowBtns.spacing*3
                height: rowBtns.height

                anchors.horizontalCenter: rowBtns.horizontalCenter
                anchors.verticalCenter: rowBtns.verticalCenter

                color: StyleConfigurator.theme.buttonGeneralCollor
                textKoeffPointSize: 3.0

                onClicked: {
                    clickedOnFunctionButton();
                }

                focus: true
            }

            Button {
                id: dec

                width: rowBtns.width/3 - rowBtns.spacing*3
                height: rowBtns.height

                anchors.left: rowBtns.left
                anchors.verticalCenter: rowBtns.verticalCenter

                color: StyleConfigurator.theme.buttonGeneralCollor
                textKoeffPointSize: 3.0

                enabled: valueSetPoint > min

                function dec_(step_) {
                    var value_ = 0.0;
                    var val_   = 0.0;


                    value_ = valueSetPoint;
                    val_ = value_ - step_;
                    if( val_ > max ) val_ = max;
                    valueSetPoint = val_;
                }

                onClicked: {
                    dec_(stepByButtons);
                    clickedDec();
                }

                Timer {
                    id: timerDec
                        interval: 1000
                        repeat: true
                        onTriggered: dec.dec_(stepByButtons*koeffStepHoldingButton)
                    }

                onPressedChanged: {
                    if( !timerDec.running )
                        timerDec.start();
                    else
                        timerDec.stop();
                }

                focus: true
            }
        }
    }
}


