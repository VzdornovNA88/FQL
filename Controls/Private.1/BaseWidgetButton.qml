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

import FQL.Controls.Private 1.0
import FQL.Controls.Base 1.0

Control {
    id: button

    property var  color
    property bool borderFocus : true
    property var contentBorderColor
    property bool contentUnder: true
    property bool propagateEvents: true
    property double radius : 0

    property Component content__        : null
    property QtObject  contentItem__    : null
    signal contentLoaded__(QtObject item_)
    property alias contentLoader__ : contentLoader

    property bool clickable : true
    signal clicked
    signal rightSwipe
    signal leftSwipe

    property var contentAvailableWidth : contentLoader.width
    property var contentAvailableHeight : contentLoader.height

    readonly property alias pressed: button.__effectivePressed

    readonly property alias hovered: behavior.containsMouse

    property bool checkable: false

    property bool checked: false

    property bool activatable: false
    property bool activated: false
    property bool activatedFromFocus: false

    property bool showPressedState : true

    onActivatableChanged: if(!activatable) activated = false;

    property ExclusiveGroup exclusiveGroup: null

    property bool activeFocusOnPress: activatable

    property string __position: "only"

    onExclusiveGroupChanged: {
        if (exclusiveGroup)
            exclusiveGroup.bindCheckable(button)
    }

    activeFocusOnTab: false

    function toggle() {
        if( !clickable ) return;

        if( !activatedFromFocus )
            activated = !activated;
        if (button.checkable && (!exclusiveGroup || !checked))
            button.checked = !button.checked
    }

    Keys.onPressed: {
        if( !clickable ) return;
        if (event.key === Qt.Key_Space && !event.isAutoRepeat && !behavior.pressed)
            behavior.keyPressed = true;
    }

    onFocusChanged:{
        if( button.activatedFromFocus ) {
            button.activated = focus;
        }
        if (!focus) behavior.keyPressed = false
    }

    onActivatedChanged: {
        if( button.activatedFromFocus ) {
            button.focus = button.activated;
        }
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
        property bool keyPressed      : false
        property bool effectivePressed: clickable ? pressed && containsMouse || keyPressed : false
        property bool activated__     : false
        property double contentX__    : 0

        anchors.fill: parent
        enabled     : !keyPressed

//        hoverEnabled: false

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
            contentX__ = mouseX;
        }
        onPositionChanged: {
            if( mouseX - contentX__ > behavior.width*0.1 )
                rightSwipe();
            else if ( mouseX - contentX__ < -behavior.width*0.1 )
                leftSwipe();
        }
    }


    property var __behavior: behavior
    property bool __effectivePressed: behavior.effectivePressed
}
