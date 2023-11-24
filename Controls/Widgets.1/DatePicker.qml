/**
******************************************************************************
* @file             DatePicker.qml
* @brief
* @authors          Nik A. Vzdornov
* @date             21.11.23
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

import FQL.Core.Meta 1.0
import FQL.Core.Base 1.0
import FQL.Resources.Colors 1.0
import FQL.Controls.Private 1.0

Control {
    id: toolBar

    property var   imageBackButtonURI  : ""
    property var   imageNextButtonURI  : ""

    property var   colorButtonsControl
    property var   colorBorderHighliter
    property var   colorBackground

    property bool  visibleControlButtons : true

    Private {
        id : d
        property var date_ : new Date()
    }

    readonly property int maxDays: new Date(year, monthNumber, 0).getDate();
    readonly property int maxMonths: 12
    property int minYear: 1976
    property int maxYear: 2200

    property int dayNumber: d.date_.getDate()
    property int monthNumber: d.date_.getMonth() + 1
    property int year: d.date_.getFullYear()

    style: StyleConfigurator.getStyleCurrentByNameControl( "DatePicker" )
}
