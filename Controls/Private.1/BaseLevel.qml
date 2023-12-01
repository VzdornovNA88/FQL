/**
******************************************************************************
* @file             Level.qml
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

import FQL.Core.Base 1.0

Control {
    id: root
    property var levelPattern             : []
    property var maskLevelPattern         : []
    property real min                     : 10
    property real max                     : 200
    property real value                   : valueSetPoint
    property real valueCurrent            : valueSetPoint
    readonly property real valueSetPoint  : __valueSetPoint
    property real step                    : 1
//    property int orientation : Qt.Horizontal
    property bool enabled                 : true
    property var colorLevel
    property var colorDisplay
    property var colorText
    property var colorHandle
    property UnitMeasurement unit
    property bool hintVisible             : true
    property bool displayVisible          : true
    property bool visibleCurrentValaue    : true
    property string  headerText           : ""
    /*readonly*/ property int fixedPrecision  : ( Math.abs(parseInt(step.toExponential().split('e')[1])) +
                                                  (step.toExponential().split('e')[0].split('.')[1] !== undefined ?
                                                       step.toExponential().split('e')[0].split('.')[1].length :
                                                       0) )

    property bool tickmarksEnabled        : false
    property double koefPointSizeTextHeader : 1.0
    property double koefPointSizeTextHints : 1.0
    property double koefPointSizeTextCurValue : 1.0
    property bool interactive: true
    property bool handleVisible: true

    // TODO : remove
    property real __valueSetPoint  : 0

    signal positionChanged
}

