/**
******************************************************************************
* @file             MultiSlider.qml
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

import QtQuick.Layouts 1.1

import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Controls 1.4
import "../"
import "../../Controls" as FQL
import "../../Resources/Colors"
import "../../Core/Meta"

Item {

    id: root

    property alias fullSizeOfControlArea       : multiSlider.fullSizeOfControlArea

    property alias maximumValue                : multiSlider.maximumValue
    property alias minimumValue                : multiSlider.minimumValue
    property alias stepSize                    : multiSlider.stepSize

    property alias activated                   : multiSlider.activated
    property alias interactive                 : multiSlider.interactive
    property alias backgroundColor             : multiSlider.backgroundColor
    property alias borderColor                 : multiSlider.borderColor
    property alias color                       : multiSlider.color
    property alias handleVisible               : multiSlider.handleVisible
    property alias handle                      : multiSlider.handle
    property alias activeFocusOnTab            : multiSlider.activeFocusOnTab
    property alias enabled                     : multiSlider.enabled
    property alias tickmarksFrontSidePosition  : multiSlider.tickmarksFrontSidePosition
    property alias value                       : multiSlider.value
    property alias feedbackValue               : multiSlider.feedbackValue
    property alias updateValueWhileDragging    : multiSlider.updateValueWhileDragging
    readonly property alias pressed            : multiSlider.pressed
    readonly property alias hovered            : multiSlider.hovered
    property alias activeFocusOnPress          : multiSlider.activeFocusOnPress
    property alias tickmarksEnabled            : multiSlider.tickmarksEnabled
    default property alias handles             : multiSlider.__handles
    readonly property alias activatedSlider    : multiSlider.__activatedSlider
    property alias orientation                 : multiSlider.orientation
    property alias clip: multiSlider.clip
    property alias borderWidth                 : multiSlider.borderWidth

    Component {
        id: template

        FQL.Slider {
            id: slider

            width                   : multiSlider.width
            height                  : multiSlider.height
            orientation             : multiSlider.orientation
            fullSizeOfControlArea   : multiSlider.fullSizeOfControlArea

            maximumValue            : multiSlider.maximumValue
            minimumValue            : multiSlider.minimumValue
            stepSize                : multiSlider.stepSize

            activated               : false
            interactive             : false
            backgroundColor         : MaterialColors.transparent
            color                   : MaterialColors.transparent
            handleVisible           : true

            handle                  : null
            onValueChanged          : if( multiSlider.handleVisible ) multiSlider.value = value;
        }
    }


    FQL.Slider {
        id: multiSlider

        width: root.width
        height: root.height

        handle         : null

        handleVisible  : false
        activated      : false

        property list<Component>  __handles
        property var              __sliders         : []
        property var              __activatedSlider : null

        function __activate( targetSlider_ ) {

                if( __activatedSlider !== null ) {
                    multiSlider.handleVisible = false;
                    multiSlider.handle = null;
                    multiSlider.activated = false;
                    __activatedSlider.handleVisible = true;
                    __activatedSlider.value = multiSlider.value;
                }
                __activatedSlider = targetSlider_;
                targetSlider_.handleVisible = false;
                multiSlider.activated = true;
                multiSlider.handle = targetSlider_.handle;
                multiSlider.value = targetSlider_.value;
                multiSlider.handleVisible = true;
        }

        function __deactivate( dummy_ ) {
                __activatedSlider.value = multiSlider.value;
                __activatedSlider.handleVisible = true;
                multiSlider.handleVisible = false;
                multiSlider.handle = null;
                multiSlider.activated = false;
                __activatedSlider = null;
        }

        Component.onCompleted: {
            for ( var i = 0; i < multiSlider.__handles.length; i++ ) {
                var componentHandle = multiSlider.__handles[i];
                var slider = template.createObject( root );
                __sliders[i] = slider;
                slider.handle = componentHandle;
                slider.handleClicked.connect(__activate);
            }
            multiSlider.handleClicked.connect(__deactivate);
        }
    }

    function setValue( handle_,val ) {
        multiSlider.__sliders[handle_].value = val;
    }

    function isActiveHandle( handle_ ) {
        return multiSlider.__activatedSlider === multiSlider.__sliders[handle_];
    }

    function activateHandle( handle_ ) {
        multiSlider.__activate(multiSlider.__sliders[handle_])
    }

}


