/**
******************************************************************************
* @file             Dial.qml
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

import "../"
import "../../Controls" as FQL
import "../../Resources/Colors"
import "../../Core/Meta"

Item {
    id: dial

    property double value
    property double maxValue : 100
    property double minValue : 0

    property alias quadrant1 : quadrant1_
    property alias quadrant2 : quadrant2_
    property alias quadrant3 : quadrant3_
    property alias quadrant4 : quadrant4_

    FQL.CircularSlider {
        id                   : quadrant2_

        activeQuadrant       : 1
        diameter             : (dial.width)

        value                : dial.value
        minValue             : dial.maxValue*0.25
        maxValue             : dial.maxValue*0.5
    }
    FQL.CircularSlider {
        id                   : quadrant1_

        anchors.left         : quadrant2_.right

        activeQuadrant       : 0
        diameter             : (dial.width)

        value                : dial.value
        minValue             : dial.maxValue*0.5
        maxValue             : dial.maxValue*0.75
    }

    FQL.CircularSlider {
        id                   : quadrant3_

        anchors.top          : quadrant2_.bottom

        usualDrirectionFill  : true
        invert               : true
        activeQuadrant       : 2
        koeff                : 0.45
        diameter             : (dial.width)

        value                : dial.value
        minValue             : dial.minValue
        maxValue             : dial.maxValue*0.25
    }
    FQL.CircularSlider {
        id                   : quadrant4_

        anchors.top          : quadrant1_.bottom
        anchors.left         : quadrant3_.right

        activeQuadrant       : 3
        koeff                : 0.45
        diameter             : (dial.width)

        value                : dial.value
        minValue             : dial.maxValue*0.75
        maxValue             : dial.maxValue
    }
}


