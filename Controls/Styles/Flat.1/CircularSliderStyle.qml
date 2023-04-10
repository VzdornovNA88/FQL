/**
******************************************************************************
* @file             CircularGaugeStyle.qml
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

import FQL.Compat.Effects.OpacityMask 1.0
import FQL.Resources.Colors 1.0
import FQL.Core.Meta 1.0
import FQL.Core.Base 1.0
import FQL.Controls.Private 1.0
import FQL.Controls.Base 1.0

Style {
    id: circularGaugeStyle

    property var backgroundColor                         : StyleConfigurator.theme.backgroundGeneral4Collor
    property var backgroundFillerColor                   : StyleConfigurator.theme.backgroundGeneral1Collor
    property var fillColor                               : StyleConfigurator.theme.systemAccnetSuccessActiveCollor
//    property var borderHandleColor                       : MaterialColors.grey100
//    property var handleColor                             : fillColor
//    property var tickmarksColor                          : MaterialColors.grey50

    property var colorDisabled                           : StyleConfigurator.theme.lighter50Collor
    property double alphaFiller                          : 1.0
    property var colorDisabledContent                    : Qt.tint( circularGaugeStyle.backgroundColor,
                                                                    StyleConfigurator.theme.lighter50Collor )

    property var tickmarksColor                          : StyleConfigurator.theme.backgroundGeneral4Collor
    property var tickmarkFontColor                       : StyleConfigurator.theme.textGeneralCollor

    readonly property double contentWidth                : contentHeight
    readonly property double contentHeight               : circularGaugeStyle.control.diameter

    readonly property double maxRotation                 : 90*circularGaugeStyle.control.koeff
    readonly property double offsetAngleRotate           : (90 - maxRotation)


    function value2AngleRot(val_,minValue_,maxValue_,limit_,maxOut) {
        if(val_ > limit_)
            val_ = limit_;
        return (val_-minValue_)/(maxValue_-minValue_)*maxOut;
    }

    property Component panel: Item {
        id: rootItem

        width: height
        height:  (circularGaugeStyle.contentWidth)/2

        readonly property var tabQuadrantFillerNotInverted   : [  {x:0,y:0,rot:1}                                  ,{x:0,y:rootItem.height,rot:1}     ,{x:rootItem.width,y:rootItem.height,rot:1}         ,{x:rootItem.width,y:0,rot:1}            ]
        readonly property var tabQuadrantFillerInverted      : [  {x:rootItem.width,y:rootItem.height,rot:-1}      ,{x:rootItem.width,y:0,rot:-1}     ,{x:0,y:0,rot:-1}                                   ,{x:0,y:rootItem.height,rot:-1}          ]
        readonly property var tabQuadrantLens                : [  {x:-rootItem.width,y:0}                          ,{x:0,y:0}                         ,{x:0,y:-rootItem.height}                           ,{x:-rootItem.width,y:-rootItem.height}  ]

        readonly property var tabQuadrantCommonRef           : circularGaugeStyle.control.invert ? tabQuadrantFillerInverted : tabQuadrantFillerNotInverted
        readonly property var tabQuadrantFillerRef           : !circularGaugeStyle.control.usualDrirectionFill && circularGaugeStyle.control.invert ? tabQuadrantFillerInverted : tabQuadrantFillerNotInverted


        readonly property double startPointAngleRotation     : circularGaugeStyle.control.usualDrirectionFill && circularGaugeStyle.control.invert ? parentShortener.rotation : 0

        clip: true

        Rectangle {
            id : externalCircle

            x: rootItem.tabQuadrantLens[circularGaugeStyle.control.activeQuadrant].x
            y: rootItem.tabQuadrantLens[circularGaugeStyle.control.activeQuadrant].y

            width: circularGaugeStyle.control.diameter
            height: width

            radius: externalCircle.width/2

            color: circularGaugeStyle.colorDisabledContent
        }


        Repeater {
            id: repeaterBorder
            model: circularGaugeStyle.control.colorPatternBorder.length

            anchors.fill: externalCircle

            readonly property int lenVal_ : circularGaugeStyle.control.valuePatternBorder.length - 1
            readonly property int lenCol_ : circularGaugeStyle.control.colorPatternBorder.length - 1

            Item {
                anchors.fill: externalCircle

                layer.enabled: true
                layer.effect: OpacityMask {
                    maskSource: externalCircle
                }

                rotation: circularGaugeStyle.value2AngleRot( circularGaugeStyle.control.valuePatternBorder[index + 1],
                                                   circularGaugeStyle.control.minValue,
                                                   circularGaugeStyle.control.valuePatternBorder[repeaterBorder.lenVal_],
                                                   circularGaugeStyle.control.valuePatternBorder[index + 1],
                                                   circularGaugeStyle.maxRotation )*rootItem.tabQuadrantCommonRef[circularGaugeStyle.control.activeQuadrant].rot

                Rectangle {
                    x: rootItem.tabQuadrantCommonRef[circularGaugeStyle.control.activeQuadrant].x
                    y: rootItem.tabQuadrantCommonRef[circularGaugeStyle.control.activeQuadrant].y

                    width: externalCircle.width/2
                    height: externalCircle.height/2

                    color: Qt.tint( circularGaugeStyle.control.colorPatternBorder ?
                                       circularGaugeStyle.control.colorPatternBorder[ index ] :
                                       circularGaugeStyle.fillColor,
                                   StyleConfigurator.theme.darker20Collor );
                }
            }
        }



        Repeater {
            id: repeaterFillerBorder
            model: circularGaugeStyle.control.valuePatternFillerBorder ?
                       circularGaugeStyle.control.colorPatternFillerBorder.length :
                       0

            anchors.fill: externalCircle

            readonly property int lenVal_ : circularGaugeStyle.control.valuePatternFillerBorder ?
                                                circularGaugeStyle.control.valuePatternFillerBorder.length - 1 :
                                                0
            readonly property int lenCol_ : circularGaugeStyle.control.colorPatternFillerBorder ?
                                                circularGaugeStyle.control.colorPatternFillerBorder.length - 1 :
                                                0

            Item {
                anchors.fill: externalCircle

                layer.enabled: true
                layer.effect: OpacityMask {
                    maskSource: externalCircle
                }

                rotation: rootItem.startPointAngleRotation + circularGaugeStyle.value2AngleRot( circularGaugeStyle.control.value,
                                                                         circularGaugeStyle.control.minValue,
                                                                         circularGaugeStyle.control.valuePatternFillerBorder[repeaterFillerBorder.lenVal_],
                                                                         !circularGaugeStyle.control.usualDrirectionFill || !circularGaugeStyle.control.invert ?
                                                                             circularGaugeStyle.control.valuePatternFillerBorder[repeaterFillerBorder.lenVal_ - index] :
                                                                             circularGaugeStyle.control.valuePatternFillerBorder[repeaterFillerBorder.lenVal_] - circularGaugeStyle.control.valuePatternFillerBorder[index],
                                                                         circularGaugeStyle.maxRotation )*rootItem.tabQuadrantFillerRef[circularGaugeStyle.control.activeQuadrant].rot

                Rectangle {
                    y: rootItem.tabQuadrantFillerRef[circularGaugeStyle.control.activeQuadrant].y /*- circularGaugeStyle.control.scaleWidth/4*/
                    x: rootItem.tabQuadrantFillerRef[circularGaugeStyle.control.activeQuadrant].x /*- circularGaugeStyle.control.scaleWidth/4*/

                    width: externalCircle.width/2
                    height: externalCircle.height/2

                    color: ColorHelpers.addAlpha(
                               circularGaugeStyle.alphaFiller,
                               circularGaugeStyle.control.colorPatternFillerBorder ?
                                   circularGaugeStyle.control.colorPatternFillerBorder[ (!circularGaugeStyle.control.usualDrirectionFill ||
                                                                             !circularGaugeStyle.control.invert ?
                                                                                 repeaterFillerBorder.lenCol_ - index : index) ] :
                                   StyleConfigurator.theme.transparent)
                }
            }
        }


        Rectangle {
            id : internalCircle

            anchors.horizontalCenter: externalCircle.horizontalCenter
            anchors.verticalCenter: externalCircle.verticalCenter

            width: externalCircle.width - circularGaugeStyle.control.scaleWidth/2
            height: width

            radius: internalCircle.width/2

            color: circularGaugeStyle.backgroundFillerColor
        }


        Repeater {
            id: repeaterFiller
            model: circularGaugeStyle.control.colorPattern.length

            anchors.fill: internalCircle

            readonly property int lenVal_ : circularGaugeStyle.control.valuePattern.length - 1
            readonly property int lenCol_ : circularGaugeStyle.control.colorPattern.length - 1

            Item {
                anchors.fill: internalCircle

                layer.enabled: true
                layer.effect: OpacityMask {
                    maskSource: internalCircle
                }

                rotation: rootItem.startPointAngleRotation + circularGaugeStyle.value2AngleRot( circularGaugeStyle.control.value,
                                                                         circularGaugeStyle.control.minValue,
                                                                         circularGaugeStyle.control.valuePattern[repeaterFiller.lenVal_],
                                                                         !circularGaugeStyle.control.usualDrirectionFill || !circularGaugeStyle.control.invert ?
                                                                             circularGaugeStyle.control.valuePattern[repeaterFiller.lenVal_ - index] :
                                                                             circularGaugeStyle.control.valuePattern[repeaterFiller.lenVal_] - circularGaugeStyle.control.valuePattern[index],
                                                                         circularGaugeStyle.maxRotation )*rootItem.tabQuadrantFillerRef[circularGaugeStyle.control.activeQuadrant].rot

                Rectangle {
                    y: rootItem.tabQuadrantFillerRef[circularGaugeStyle.control.activeQuadrant].y - circularGaugeStyle.control.scaleWidth/4
                    x: rootItem.tabQuadrantFillerRef[circularGaugeStyle.control.activeQuadrant].x - circularGaugeStyle.control.scaleWidth/4

                    width: externalCircle.width/2
                    height: externalCircle.height/2

                    color: ColorHelpers.addAlpha(
                               circularGaugeStyle.alphaFiller,
                               circularGaugeStyle.control.colorPattern ?
                                   circularGaugeStyle.control.colorPattern[ (!circularGaugeStyle.control.usualDrirectionFill ||
                                                                             !circularGaugeStyle.control.invert ?
                                                                                 repeaterFiller.lenCol_ - index : index) ] :
                                   circularGaugeStyle.fillColor)
                }
            }
        }


        Rectangle {
            id : internalCircle1

            anchors.horizontalCenter: externalCircle.horizontalCenter
            anchors.verticalCenter: externalCircle.verticalCenter

            z: Math.min(circularGaugeStyle.control.valuePattern.length,circularGaugeStyle.control.colorPattern.length) + 1
            width: circularGaugeStyle.control.diameter - 2*circularGaugeStyle.control.fillerWidth
            height: width

            radius: internalCircle.width/2

            color: circularGaugeStyle.backgroundColor
        }


        Repeater {
            id: repeater

            anchors.fill: externalCircle

            readonly property int lenVal_ : circularGaugeStyle.control.tickmarkEnabled && circularGaugeStyle.control.tickmarkPattern ? circularGaugeStyle.control.tickmarkPattern.length : 0
            model: lenVal_

            Item {
                id: item
                width: circularGaugeStyle.control.diameter
                height: width

                z: Math.min(circularGaugeStyle.control.valuePattern.length,circularGaugeStyle.control.colorPattern.length) + 2

                anchors.fill: externalCircle

                rotation: ( (circularGaugeStyle.control.tickmarkPattern[index] - circularGaugeStyle.control.minValue)/
                            (circularGaugeStyle.control.maxValue - circularGaugeStyle.control.minValue)*
                            (maxRotation) + (circularGaugeStyle.control.invert ? parentShortener.rotation : 0) ) - (circularGaugeStyle.control.activeQuadrant+1)*90


                Rectangle {
                    id:tickmark
                    height: Math.max( circularGaugeStyle.control.diameter*0.01,2 )
                    width: circularGaugeStyle.control.fillerWidth
                    anchors.verticalCenter: item.verticalCenter
                    anchors.right: item.right
                    anchors.verticalCenterOffset: Math.abs(circularGaugeStyle.control.tickmarkPattern[index] - circularGaugeStyle.control.minValue) < 2 ?
                                                      externalCircle.width*0.008 :
                                                      Math.abs(circularGaugeStyle.control.tickmarkPattern[index] - circularGaugeStyle.control.maxValue) < 2 ?
                                                          -externalCircle.width*0.008 :
                                                          0

                    color: circularGaugeStyle.control.tickmarksColor ? circularGaugeStyle.control.tickmarksColor : circularGaugeStyle.tickmarksColor
                }

                Text {
                    id: text

                    anchors.verticalCenter: item.verticalCenter
                    anchors.right: item.right
                    anchors.rightMargin: tickmark.width*1.1
                    anchors.verticalCenterOffset: Math.abs(circularGaugeStyle.control.tickmarkPattern[index] - circularGaugeStyle.control.minValue) < 2 ?
                                                      externalCircle.width*0.05 :
                                                      Math.abs(circularGaugeStyle.control.tickmarkPattern[index] - circularGaugeStyle.control.maxValue) < 2 ?
                                                          -externalCircle.width*0.05 : 1

                    wrapMode : Text.WrapAtWordBoundaryOrAnywhere
                    minimumPixelSize: 1
                    font.pixelSize: externalCircle.width*0.05*circularGaugeStyle.control.koefFontPixelSizeTickmark

                    text                   : circularGaugeStyle.control.tickmarkLabelPattern[index]

                    rotation: -item.rotation

                    color: circularGaugeStyle.control.tickmarkFontColor ? circularGaugeStyle.control.tickmarkFontColor : circularGaugeStyle.tickmarkFontColor
                }
            }
        }


        Item {
            id: parentShortener
            anchors.fill: externalCircle

            z: Math.min(circularGaugeStyle.control.valuePattern.length,circularGaugeStyle.control.colorPattern.length) + 1

            rotation : (90 - circularGaugeStyle.maxRotation) *
                       (!circularGaugeStyle.control.invert ?
                            rootItem.tabQuadrantFillerInverted :
                            rootItem.tabQuadrantFillerNotInverted)[circularGaugeStyle.control.activeQuadrant].rot

            Rectangle {
                id : shortener

                x: (!circularGaugeStyle.control.invert ?
                        rootItem.tabQuadrantFillerInverted :
                        rootItem.tabQuadrantFillerNotInverted)[circularGaugeStyle.control.activeQuadrant].x /*- circularGaugeStyle.control.scaleWidth/4*/
                y: (!circularGaugeStyle.control.invert ?
                        rootItem.tabQuadrantFillerInverted :
                        rootItem.tabQuadrantFillerNotInverted)[circularGaugeStyle.control.activeQuadrant].y /*- circularGaugeStyle.control.scaleWidth/4*/

                width: externalCircle.width/2
                height: externalCircle.height/2

                color: circularGaugeStyle.backgroundColor
            }
        }
    }
}
