/**
******************************************************************************
* @file             SliderStyle.qml
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

import "../../../../Resources/Colors"
import "../../../../Core/ColorHelpers.js" as ColorHelpers
import "../../../Private"

Style {
    id: styleitem

    property var backgroundColor     : MaterialColors.grey100
    property var fillColor           : MaterialColors.pink700
    property var borderHandleColor   : MaterialColors.grey100
    property var handleColor         : fillColor
    property var tickmarksColor      : MaterialColors.grey400
    property var borderColor         : MaterialColors.transparent
    property var colorDisabled       : ColorHelpers.addAlpha( 0.5,MaterialColors.grey50  )

    property var handlePosition

    property var valueLevelPatternFillColor : [control.color ? control.color : fillColor]

    property double handleWidth : 0

    property Component handle: Rectangle {
        id: backHandle
        width:  height
        height: ((control.orientation === Qt.Horizontal) ? control.height : control.width)

        radius: width/2

        color: MaterialColors.transparent
        border.width: control.borderWidth
        border.color: control.activeFocus ? styleitem.borderHandleColor : MaterialColors.transparent

        Rectangle {
            id: handle
            width: backHandle.width - 6
            height: backHandle.height - 6
            anchors.verticalCenter: backHandle.verticalCenter
            anchors.horizontalCenter: backHandle.horizontalCenter

            radius: width/2
            color: control.color ? control.color : handleColor

        }

        Rectangle {
            id: disablerHandle

            anchors.centerIn: handle

            width: handle.width
            height: handle.height

            color : control.enabled ? MaterialColors.transparent : colorDisabled
        }
    }

    property Component groove: Rectangle {
        id: border

        function getIdxOfColorFor(vaulePattern_,currentValue) {
            if( vaulePattern_.length !== undefined && vaulePattern_.length > 0 )
                for(var i_ = 0; i_ < vaulePattern_.length; i_++) {
                    var i__ = i_ + 1;
                    if((i__ < vaulePattern_.length && vaulePattern_[i_] <= currentValue && currentValue < vaulePattern_[i__]) ||
                      (i__ === vaulePattern_.length) && currentValue >= vaulePattern_[i_] ){
                        return i_;
                    }
                    console.log("getIdxOfColorFor ---> ",currentValue,i_,vaulePattern_[i_],styleitem.valueLevelPatternFillColor[i_]);
                }

            return 0;
        }

        property double __k : !control.fullSizeOfControlArea ? 0.4 : 1
        width: (control.orientation === Qt.Horizontal) ? control.width : control.height
        height: (control.orientation === Qt.Horizontal) ? (control.height)*__k : (control.width)*__k

        border.color: control.borderColor ? control.borderColor : borderColor
        border.width: control.borderWidth
        color : MaterialColors.transparent

        Rectangle {
            id: background

            anchors.centerIn: border
            width: border.width - control.borderWidth*2
            height: border.height - control.borderWidth*2

            color: control.backgroundColor ? control.backgroundColor : backgroundColor

            Item {
                clip: true
                width: styleData.handlePosition
                height: parent.height

                Rectangle {
                    id: filler
                    anchors.fill: parent
                    color: (control.colorPattern ?
                                control.colorPattern :
                                styleitem.valueLevelPatternFillColor)[border.getIdxOfColorFor(control.valuePattern,control.valueCurrent)]
                }
            }

            Repeater {
                id: repeater
                y: 0
                model: control.stepSize > 0 && control.tickmarksEnabled ? ((control.maximumValue - control.minimumValue) / control.stepSize +1) : 0
                Rectangle {
                    color: tickmarksColor
                    width: 2 ; height: background.height/2
                    y: control.tickmarksFrontSidePosition ? background.height - height : 0
                    x: index*background.width*(1 + control.stepSize/(control.maximumValue - control.minimumValue))/repeater.count - 2
                    visible: control.tickmarksEnabled && (0 < index && index < repeater.count-1)
                }
            }

            Repeater {
                id: repeater2
                y: 0
                model: control.valuePattern && control.valuePattern.length !== undefined && control.valuePattern.length > 0 ? control.valuePattern.length : 0
                Rectangle {
                    color: tickmarksColor
                    width: 1 ; height: background.height
                    y: 0
                    x: background.width*(control.valuePattern[index]/(control.maximumValue - control.minimumValue))
                }
            }
        }

        Rectangle {
            id: disabler

            anchors.centerIn: border

            width: border.width - control.borderWidth*2
            height: border.height - control.borderWidth*2

            color : control.enabled ? MaterialColors.transparent : colorDisabled
        }
    }

    property Component panel: Item {
        id: root
        property int handleWidth: handleLoader.width
        property int handleHeight: handleLoader.height

        property bool horizontal : control.orientation === Qt.Horizontal

        y: horizontal ? 0 : height
        rotation: horizontal ? 0 : -90
        transformOrigin: Item.TopLeft

        Item {

            anchors.fill: parent

            Loader {
                id: grooveLoader
                property QtObject styleData: QtObject {
                    property int __value : Math.round((control.valueCurrent - control.minimumValue) /
                                                      (control.maximumValue - control.minimumValue) *
                                                      ((root.horizontal ? root.width : root.height) )) -
                                           control.borderWidth*2
                    readonly property int handlePosition: __value < 0 ? 0 : __value
                }
                x: 0
                sourceComponent: groove
                width: (root.horizontal ? parent.width : parent.height)
                y:  Math.round((Math.round(root.horizontal ? parent.height : parent.width) - grooveLoader.item.height)/2)
            }
            Loader {
                id: handleLoader
                sourceComponent: control.handleVisible ? (control.handle !== null ? control.handle : handle) : null

                property double handlePosition: Math.round((control.valueSetPoint - control.minimumValue) /
                                                        (control.maximumValue - control.minimumValue) *
                                                        ((root.horizontal ? root.width : root.height) ))
                property double __value : handlePosition - handleLoader.width/2 -1
                x: __value < -handleLoader.width/2 + control.borderWidth ? -handleLoader.width/2 + control.borderWidth : __value

                onWidthChanged: styleitem.handleWidth = handleLoader.width

                onLoaded: {
                    control.__onHandleLoaded(item);
                    styleitem.handlePosition = Qt.binding(function(){return handleLoader.x;});
                }
            }
        }
    }
}
