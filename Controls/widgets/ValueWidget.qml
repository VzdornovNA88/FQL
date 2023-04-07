/**
******************************************************************************
* @file             ValueWidget.qml
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

import "../../Resources/Colors"
import "../" as FQL
import "../widgets"
import "../../Core"
import "../../Core/ColorHelpers.js" as ColorHelpers

ContentItem {
    id: valueWidget

    property int orientation : Qt.Vertical

    property double value
    property UnitMeasurement unit
    property var valueColor         /* : StyleConfigurator.theme.valueCollor*/
    property var unitMessureColor /* : StyleConfigurator.theme.unitMessureCollor*/

    property string iconSource
    property var iconColor
    property double koefFontValuePixelSize : 1
    property int fixedPrecision            : 0

    color                                  : MaterialColors.transparent
    clickable                              : false

    style                                  : StyleConfigurator.getStyleCurrentByNameControl( "ValueWidget" )
}
