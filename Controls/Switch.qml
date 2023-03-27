/**
******************************************************************************
* @file             Switch.qml
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
import "../Controls"

PrivateFQL.Control {
    id: root

    // Механика и форма отображения свитча требуют конкретных пропорцией для корректного отображения и управления
    // по умолчанию идельный вариант пропорций свитча это 1:2 , в другом случае хэндл компонента может быть не
    // круглой формы и зависеть от высоты элемента в целом
    height: width/2

    property var  colorOn
    property var  colorOff

    readonly property bool checkable : true
    property bool checked: false

    readonly property alias pressed: internal.pressed

    property bool activeFocusOnPress: false

    property ExclusiveGroup exclusiveGroup: null

    signal clicked

    Keys.onPressed: {
        if (event.key === Qt.Key_Space && !event.isAutoRepeat && (!exclusiveGroup || !checked))
            checked = !checked;
    }

    onExclusiveGroupChanged: {
        if (exclusiveGroup)
            exclusiveGroup.bindCheckable(root)
    }

    MouseArea {
        id: internal

        property Item handle: __panel.__handle
        property int min: __panel.min
        property int max: __panel.max
        focus: true
        anchors.fill: parent
        drag.threshold: 0
        drag.target: handle
        drag.axis: Drag.XAxis
        drag.minimumX: min
        drag.maximumX: max

        onPressed: {
            if (activeFocusOnPress)
                root.forceActiveFocus()
        }

        onReleased: {
            if (drag.active) {
                checked = (handle.x < max/2) ? false : true;
                internal.handle.x = checked ? internal.max : internal.min
            } else {
                checked = (handle.x === max) ? false : true
            }
        }

        onClicked: root.clicked()
    }

    onCheckedChanged:  {
        if (internal.handle)
            internal.handle.x = checked ? internal.max : internal.min
    }

    style: StyleConfigurator.getStyleCurrentByNameControl( "Switch" )
}
