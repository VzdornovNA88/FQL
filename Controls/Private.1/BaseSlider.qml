/**
******************************************************************************
* @file             BaseSlider.qml
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

import FQL.Controls.Private 1.0
import FQL.Core.Base 1.0

Control {
    id: slider

    property int   orientation                 : Qt.Horizontal
    property real minimumValue                : 0
    property real maximumValue                : 100
    property bool  updateValueWhileDragging    : true

    readonly property alias pressed            : mouseArea.pressed

    property real stepSize                    : 1

    property bool activeFocusOnPress           : false
    property bool tickmarksEnabled             : false

    property bool __horizontal                 : orientation === Qt.Horizontal



    readonly property real valueSetPoint       : range.value // from handle's set point
    property real value                        : minimumValue // from external set point
    property real valueCurrent                 : range.value // current value to broken link between in and out of slider



    property var valuePattern                  : []
    property var colorPattern                  : null
    property var color                         : null
    property var backgroundColor               : null
    property var borderColor                   : null
    property int borderWidth                   : 2
    property bool handleVisible                : true
    property bool interactive                  : true
    property bool enabled                      : true
    property bool fullSizeOfControlArea        : false
    property bool activated                    : true
    property bool tickmarksFrontSidePosition   : true
    property Component handle                  : null


     activeFocusOnTab                           : true

    signal handleClicked(var slider_);
    signal handleLoaded( var handle_ )


    function __onHandleLoaded(handle_) {
        if( handle_.clicked !== null && handle_.clicked !== undefined ) {
            var handleClicked_ = function(){
                handleClicked( slider );
            }
            handle_.clicked.connect( handleClicked_ );
        }
        if( handle_.frontDirection !== null && handle_.frontDirection !== undefined )
            tickmarksFrontSidePosition = handle_.frontDirection;
        else
            tickmarksFrontSidePosition = true;
        handleLoaded( handle_ );
    }

    Keys.onRightPressed: if (__horizontal) range.increaseSingleStep()
    Keys.onLeftPressed: if (__horizontal) range.decreaseSingleStep()
    Keys.onUpPressed: if (!__horizontal) range.increaseSingleStep()
    Keys.onDownPressed: if (!__horizontal) range.decreaseSingleStep()

    RangeModel {
        id: range

        minimumValue: slider.minimumValue
        maximumValue: slider.maximumValue
        stepSize: slider.stepSize
        inverted: __horizontal ? false : true
        positionAtMinimum: 0
        positionAtMaximum: __horizontal ? slider.width - fakeHandle.width : slider.height - fakeHandle.height
    }

    Item {
        id: fakeHandle
        anchors.verticalCenter: __horizontal ? parent.verticalCenter : undefined
        anchors.horizontalCenter: !__horizontal ? parent.horizontalCenter : undefined
        width: __panel.handleWidth
        height: __panel.handleHeight

        function updatePos() {
            if (updateValueWhileDragging && mouseArea.containsMouse) {
                range.setPosition( __horizontal ? x : y );
            }
        }

        onXChanged: updatePos();
        onYChanged: updatePos();
    }

    MouseArea {
        id: mouseArea

        anchors.fill: slider
        hoverEnabled: true
        property real pressX: 0
        property real pressY: 0

        enabled: slider.interactive && slider.enabled && slider.activated

        function clamp ( val ) {
            return Math.max(range.positionAtMinimum, Math.min(range.positionAtMaximum, val));
        }

        function updateHandlePosition(mouse, force) {
            var pos, overThreshold;
            if (__horizontal) {
                pos = clamp (mouse.x - fakeHandle.width/2)
                overThreshold = Math.abs(mouse.x - pressX) >= 1;
                if (overThreshold)
                    preventStealing = true;
                if (overThreshold || force)
                    fakeHandle.x = pos;
            } else if (!__horizontal) {
                pos = clamp (mouse.y - fakeHandle.height/2);
                overThreshold = Math.abs(mouse.y - pressY) >= 1;
                if (overThreshold)
                    preventStealing = true;
                if (overThreshold || force)
                    fakeHandle.y = pos;
            }
        }

        Component.onCompleted: {
            onPositionChanged.connect(function(mouse){
                if (pressed)
                    updateHandlePosition(mouse, !true/*!Settings.hasTouchScreen*/ || preventStealing);
            });

            onPressed.connect(function(mouse){
                if (slider.activeFocusOnPress)
                    slider.forceActiveFocus();

                pressX = mouse.x;
                pressY = mouse.y;

                updateHandlePosition(mouse, !true/*!Settings.hasTouchScreen*/);
            });

            onReleased.connect(function(mouse){
                updateHandlePosition(mouse, true/*Settings.hasTouchScreen*/);
                if (!slider.updateValueWhileDragging) {
                    range.setPosition( __horizontal ? fakeHandle.x : fakeHandle.y );
                }
                preventStealing = false;
            } );
        }

        onDoubleClicked: {
            handleClicked( slider );
        }
    }

    onValueChanged: {
        range.setValue( value );
    }
}

