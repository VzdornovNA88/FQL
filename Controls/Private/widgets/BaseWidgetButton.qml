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

import QtQuick 2.2

import "../../../Controls/Private" as PrivateFQL
import "../../../Controls"

PrivateFQL.Control {
    id: button

    property var  color
    property bool borderFocus : true
    property var contentBorderColor
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

    property bool checked: false

    property bool activatable: false
    readonly property bool activated: behavior.activated__

    property bool showPressedState : true

    onActivatableChanged: if(!activatable) behavior.activated__ = false;

    property ExclusiveGroup exclusiveGroup: null

    property bool activeFocusOnPress: activatable

    property string __position: "only"

    onExclusiveGroupChanged: {
        if (exclusiveGroup)
            exclusiveGroup.bindCheckable(button)
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
            button.clicked()
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
            contentLoaded__( contentItem__ );
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

            if (button.checkable || (exclusiveGroup && !checked))
                button.checked = !button.checked
        }

        onReleased: {
            if( !clickable ) return;
            if (containsMouse) {
                toggle()
                button.clicked()
            }
        }
        onPressed: {
            if( !clickable ) return;
            if (activeFocusOnPress)
                button.forceActiveFocus()
        }
    }


    property var __behavior: behavior
    property bool __effectivePressed: behavior.effectivePressed
}
