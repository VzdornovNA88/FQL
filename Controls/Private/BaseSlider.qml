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

import QtQuick.Controls.Private 1.0
import QtQuick 2.2
import QtQuick.Controls 1.2

Control {
    id: slider

    property int   orientation                 : Qt.Horizontal
    property alias minimumValue                : range.minimumValue
    property alias maximumValue                : range.maximumValue
    property bool  updateValueWhileDragging    : true

    readonly property alias pressed            : mouseArea.pressed
    readonly property alias hovered            : mouseArea.handleHovered

    property alias stepSize                    : range.stepSize
    property alias value                       : range.value

    property bool activeFocusOnPress           : false
    property bool tickmarksEnabled             : false


    property bool __horizontal                 : orientation === Qt.Horizontal
    property real __handlePos                  :  range.valueForPosition(__horizontal ? fakeHandle.x : fakeHandle.y,
                                                  range.positionAtMinimum, range.positionAtMaximum, range.minimumValue, range.maximumValue)

    activeFocusOnTab                           : true

    property real feedbackValue                : value
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

    Accessible.role: Accessible.Slider

    function accessibleIncreaseAction() {
        range.increaseSingleStep()
    }

    function accessibleDecreaseAction() {
        range.decreaseSingleStep()
    }

    Keys.onRightPressed: if (__horizontal) range.increaseSingleStep()
    Keys.onLeftPressed: if (__horizontal) range.decreaseSingleStep()
    Keys.onUpPressed: if (!__horizontal) range.increaseSingleStep()
    Keys.onDownPressed: if (!__horizontal) range.decreaseSingleStep()

    RangeModel {
        id: range
        minimumValue: 0.0
        maximumValue: 1.0
        value: 0
        stepSize: 0.0
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
            if (updateValueWhileDragging && !mouseArea.drag.active)
                            range.position = __horizontal ? x : y
        }

        onXChanged: updatePos();
        onYChanged: updatePos();
    }

    MouseArea {
        id: mouseArea

        anchors.fill: slider
        hoverEnabled: Settings.hoverEnabled
        property int clickOffset: 0
        property real pressX: 0
        property real pressY: 0
        property bool handleHovered: false

        enabled: slider.interactive && slider.enabled && slider.activated

        function clamp ( val ) {
            return Math.max(range.positionAtMinimum, Math.min(range.positionAtMaximum, val));
        }

        function updateHandlePosition(mouse, force) {
            var pos, overThreshold;
            if (__horizontal) {
                pos = clamp (mouse.x + clickOffset - fakeHandle.width/2)
                overThreshold = Math.abs(mouse.x - pressX) >= Settings.dragThreshold;
                if (overThreshold)
                    preventStealing = true;
                if (overThreshold || force)
                    fakeHandle.x = pos;
            } else if (!__horizontal) {
                pos = clamp (mouse.y + clickOffset- fakeHandle.height/2);
                overThreshold = Math.abs(mouse.y - pressY) >= Settings.dragThreshold;
                if (overThreshold)
                    preventStealing = true;
                if (overThreshold || force)
                    fakeHandle.y = pos;
            }
        }

        onPositionChanged: {
            if (pressed)
                updateHandlePosition(mouse, !Settings.hasTouchScreen || preventStealing);

            var point = mouseArea.mapToItem(fakeHandle, mouse.x, mouse.y);
            handleHovered = fakeHandle.contains(Qt.point(point.x, point.y));
        }

        onPressed: {
            if (slider.activeFocusOnPress)
                slider.forceActiveFocus();

            if (handleHovered) {
                var point = mouseArea.mapToItem(fakeHandle, mouse.x, mouse.y);
                clickOffset = __horizontal ? fakeHandle.width/2 - point.x : fakeHandle.height/2 - point.y;
            }
            pressX = mouse.x;
            pressY = mouse.y;
            updateHandlePosition(mouse, !Settings.hasTouchScreen);
        }

        onReleased: {
            updateHandlePosition(mouse, Settings.hasTouchScreen);
            // If we don't update while dragging, this is the only
            // moment that the range is updated.
            if (!slider.updateValueWhileDragging)
                range.position = __horizontal ? fakeHandle.x : fakeHandle.y;
            clickOffset = 0;
            preventStealing = false;
        }

        onExited: handleHovered = false;

        onDoubleClicked: {
            handleClicked( slider );
        }
    }


    // During the drag, we simply ignore the position set from the range, this
    // means that setting a value while dragging will not "interrupt" the
    // dragging activity.
    Binding {
        when: !mouseArea.drag.active
        target: fakeHandle
        property: __horizontal ? "x" : "y"
        value: range.position
//        restoreMode: Binding.RestoreBinding
    }

    WheelArea {
        id: wheelarea
        anchors.fill: parent
        verticalValue: slider.value
        horizontalValue: slider.value
        horizontalMinimumValue: slider.minimumValue
        horizontalMaximumValue: slider.maximumValue
        verticalMinimumValue: slider.minimumValue
        verticalMaximumValue: slider.maximumValue
        property real step: (slider.maximumValue - slider.minimumValue)/(range.positionAtMaximum - range.positionAtMinimum)

        onVerticalWheelMoved: {
            if (verticalDelta !== 0) {
                var delta = Math.abs(verticalDelta)*step > stepSize ? verticalDelta*step : verticalDelta/Math.abs(verticalDelta)*stepSize;
                range.position = range.positionForValue(value - delta * (inverted ? 1 : -1));
            }
        }

        onHorizontalWheelMoved: {
            if (horizontalDelta !== 0) {
                var delta = Math.abs(horizontalDelta)*step > stepSize ? horizontalDelta*step : horizontalDelta/Math.abs(horizontalDelta)*stepSize;
                range.position = range.positionForValue(value + delta * (inverted ? 1 : -1));
            }
        }
    }
}

