/**
******************************************************************************
* @file             CircularGaugeStyle.qml
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

import "../Flat" as Flat
import "../../../Resources/Colors"
import "../../../Core/ColorHelpers.js" as ColorHelpers


Flat.CircularSliderStyle {
    backgroundColor       : Qt.tint( RSM_Colors.background,RSM_Colors.white80 )
    backgroundFillerColor : MaterialColors.grey200
    fillColor             : RSM_Colors.green
    colorDisabled         : RSM_Colors.white50
    colorDisabledContent  : RSM_Colors.background
    tickmarksColor        : RSM_Colors.white_primary
    tickmarkFontColor     : MaterialColors.grey500

//    valueLevelPatternFillColor: [control.color ? control.color : fillColor,RSM_Colors.orange,RSM_Colors.red_error]
}
