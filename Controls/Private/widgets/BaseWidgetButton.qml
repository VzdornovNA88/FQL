/**
  ******************************************************************************
  * @file             BaseWidgetButton.qml
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
import QtQuick.Controls 1.4
import QtQuick.Controls.Private 1.0

Control {
    id: button

    property var  color
    property bool borderFocus : true
    property bool contentUnder: true
    property bool propagateEvents: true

    property Component content__        : null
    property QtObject  contentItem__    : null
    signal contentLoaded__(QtObject item_)
    property alias contentLoader__ : contentLoader

    property bool clickable : true
    signal clicked

    property var contentAvailableWidth : contentLoader.width
    property var contentAvailableHeight : contentLoader.height

    readonly property alias pressed: button.__effectivePressed

    readonly property alias hovered: behavior.containsMouse

    property bool checkable: false
    Accessible.checkable: checkable

    property bool checked: false
    Accessible.checked: checked

    property bool activatable: false
    readonly property bool activated: behavior.activated__

    onActivatableChanged: if(!activatable) behavior.activated__ = false;

    property ExclusiveGroup exclusiveGroup: null

    property Action action: null

    property bool activeFocusOnPress: activatable

    property string tooltip: action ? (action.tooltip) : ""

    property string __position: "only"

    property Action __action: action || ownAction

    onExclusiveGroupChanged: {
        if (exclusiveGroup)
            exclusiveGroup.bindCheckable(button)
    }

    Accessible.role: Accessible.Button
    Accessible.description: tooltip

    function accessiblePressAction() {
        __action.trigger(button)
    }

    Action {
        id: ownAction
        enabled: button.enabled
    }

    Connections {
        target: __action
        onTriggered: button.clicked()
    }

    activeFocusOnTab: false

    Keys.onPressed: {
        if( !clickable ) return;
        if (event.key === Qt.Key_Space && !event.isAutoRepeat && !behavior.pressed)
            behavior.keyPressed = true;
    }

    onFocusChanged:{
        if( activatable ) {
            behavior.activated__ = !behavior.activated__;
            if( !behavior.activated__ )
                button.focus = false;
        }
        if( !activatable ) focus = false;
        if (!focus) behavior.keyPressed = false
    }

    Keys.onReleased: {
        if( !clickable ) return;
        if (event.key === Qt.Key_Space && !event.isAutoRepeat && behavior.keyPressed) {
            behavior.keyPressed = false;
            __action.trigger(button)
            behavior.toggle()
        }
    }

    Loader {
        id: contentLoader

        z: !contentUnder ? 1 : 0

        // костыль, привязку к визуальному отображению данного компонента
        // необходимо делать в стиле, так как именно стиль знает как
        // располагаются все визуальные элементы друг относительно друга
        // в том числе и эти

        anchors.verticalCenter: button.verticalCenter
        anchors.horizontalCenter: button.horizontalCenter

        width:  button.width  - 6
        height: button.height - 6

        sourceComponent  : content__

        onLoaded: {

            contentItem__ = item
            contentLoaded__( contentItem__,contentLoader );
        }
    }

    MouseArea {
        id: behavior
        property bool keyPressed: false
        property bool effectivePressed: clickable ? pressed && containsMouse || keyPressed : false

        anchors.fill: parent
        enabled: !keyPressed
        property bool activated__ : false
//        hoverEnabled: false

        function toggle() {
            if( !clickable ) return;
//            if( activatable ) {
//                activated__ = !activated__;
//                if( !activated__ )
//                    button.focus = false;
//            }

            if (button.checkable && !button.action && !(button.checked && button.exclusiveGroup))
                button.checked = !button.checked
        }

        onReleased: {
            if( !clickable ) return;
            if (containsMouse) {
                toggle()
                __action.trigger(button)
            }
        }
        onExited: Tooltip.hideText()
        onCanceled: Tooltip.hideText()
        onPressed: {
            if( !clickable ) return;
            if (activeFocusOnPress)
                button.forceActiveFocus()
        }

        Timer {
            interval: 1000
            running: behavior.containsMouse && !pressed && tooltip.length
            onTriggered: Tooltip.showText(behavior, Qt.point(behavior.mouseX, behavior.mouseY), tooltip)
        }
    }


    property var __behavior: behavior
    property bool __effectivePressed: behavior.effectivePressed

    states: [
        State {
            name: "boundAction"
            when: action !== null
            PropertyChanges {
                target: button
                enabled: action.enabled
                checkable: action.checkable
                checked: action.checked
            }
        }
    ]
}
