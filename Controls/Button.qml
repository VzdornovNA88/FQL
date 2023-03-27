  /**
  ******************************************************************************
  * @file             Button.qml
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

import "../Core"
import "../Controls/Private" as PrivateFQL

PrivateFQL.Control {
    id: button

    property var  color
    property var  color_text
    property bool borderFocus : true
    property double  textKoeffPointSize : 1.0

    property bool showPressedState : true

    property var __behavior: behavior

    property bool __effectivePressed: behavior.effectivePressed

    signal clicked
    readonly property alias pressed: button.__effectivePressed
    readonly property alias hovered: behavior.containsMouse

    property bool checkable: false

    property bool checked: false

    property ExclusiveGroup exclusiveGroup: null

    property bool activeFocusOnPress: true

    property string text: ""

    property url iconSource: ""

    property string iconName: ""

    property string __position: "only"


    onExclusiveGroupChanged: {
        if (exclusiveGroup)
            exclusiveGroup.bindCheckable(button)
    }

    activeFocusOnTab: true

    onFocusChanged: if (!focus) behavior.keyPressed = false

    Keys.onPressed: {
        if ((event.key === Qt.Key_Enter || event.key === Qt.Key_Return) && !event.isAutoRepeat && !__behavior.pressed)
            __behavior.keyPressed = true;
    }

    Keys.onReleased: {
        if ((event.key === Qt.Key_Enter || event.key === Qt.Key_Return) && !event.isAutoRepeat && __behavior.keyPressed) {
            __behavior.keyPressed = false;
            button.clicked()
            __behavior.toggle()
        }
    }

    MouseArea {
        id: behavior
        property bool keyPressed: false
        property bool effectivePressed: pressed && containsMouse || keyPressed

        anchors.fill: parent
        hoverEnabled: true
        enabled: !keyPressed

        function toggle() {
            if (button.checkable || (exclusiveGroup && !checked))
                button.checked = !button.checked
        }

        onReleased: {
            if (containsMouse) {
                toggle()
                button.clicked()
            }
        }

        onPressed: {
            if (activeFocusOnPress)
                button.forceActiveFocus()
        }
    }

    style: StyleConfigurator.getStyleCurrentByNameControl( "Button" )
}
