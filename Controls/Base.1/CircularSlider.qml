/**
  ******************************************************************************
  * @file             CircularSlider.qml
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
import FQL.Controls.Private 1.0
import FQL.Resources.Colors 1.0

Control {
    id: circularSlider

    width: height
    height:  (__style.contentWidth)/2

//    property var backgroundColor           : StyleConfigurator.theme.systemGeneralNotActive2Collor
    property var valuePattern              : [ minValue   ,(maxValue-minValue)*0.1 + minValue,(maxValue-minValue)*0.7 + minValue ,maxValue             ]
    property var colorPattern              : [ MaterialColors.green200  ,MaterialColors.yellow200  ,MaterialColors.red200 ]
    property var valuePatternBorder        : valuePattern
    property var colorPatternBorder        : [ MaterialColors.green500  ,MaterialColors.yellow500  ,MaterialColors.red500 ]
    property var valuePatternFillerBorder  : valuePatternBorder
    property var colorPatternFillerBorder  : colorPatternBorder
    property bool invert                   : false
    property bool usualDrirectionFill      : false
    property int activeQuadrant            : 0

    property double scaleWidth             : 20
    property double koeff                  : 1
    property double diameter               : 50
    property double fillerWidth            : diameter*0.1

    property double value                  : 0
    property double maxValue               : 100
    property double minValue               : 0

    property var  tickmarkPattern : [ minValue   ,
                                     (maxValue-minValue)*0.25 + minValue,
                                     (maxValue-minValue)*0.5 + minValue ,
                                     (maxValue-minValue)*0.75 + minValue,
                                      maxValue ]

    property var  tickmarkLabelPattern : [ minValue   ,
                                     (maxValue-minValue)*0.25 + minValue,
                                     (maxValue-minValue)*0.5 + minValue ,
                                     (maxValue-minValue)*0.75 + minValue,
                                      "max" ]

    property bool tickmarkEnabled             : false

    property double koefFontPixelSizeTickmark : 1.0

    property var tickmarksColor
    property var tickmarkFontColor

    style: StyleConfigurator.getStyleCurrentByNameControl( "CircularSlider" )
}
