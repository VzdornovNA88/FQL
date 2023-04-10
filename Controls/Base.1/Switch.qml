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

import FQL.Core.Meta 1.0
import FQL.Core.Base 1.0
import FQL.Controls.Private 1.0

AbstractCheckable {
    id: root

    // Механика и форма отображения свитча требуют конкретных пропорцией для корректного отображения и управления
    // по умолчанию идельный вариант пропорций свитча это 1:2 , в другом случае хэндл компонента может быть не
    // круглой формы и зависеть от высоты элемента в целом
    height: width/2

    property var  colorOn
    property var  colorOff

    internal.drag.threshold: 0
    internal.drag.target: __panel.__handle
    internal.drag.axis: Drag.XAxis
    internal.drag.minimumX: __panel.min
    internal.drag.maximumX: __panel.max

    __cycleStatesHandler : function() {
        if (internal.drag.active) {
            checked = (__panel.__handle.x < __panel.max/2) ? false : true;
            __panel.__handle.x = checked ? __panel.max : __panel.min
        } else {
            checked = (__panel.__handle.x === __panel.max) ? false : true
        };
    }

    onCheckedChanged:  {
        if (internal.handle)
            __panel.__handle.x = checked ? __panel.max : __panel.min
    }

    style: StyleConfigurator.getStyleCurrentByNameControl( "Switch" )
}
