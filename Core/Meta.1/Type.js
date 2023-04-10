  /**
  ******************************************************************************
  * @file             Type.js
  * @brief            Method to getting type of any QML object (ECMA-262 5 edition with Qt 5.5.1)
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
  
.pragma library

/** @fn string(type of qml object) function Of( ANY QML COMPONENT object )
*/
var self = {
    typeof : function (object) {
        var rawType = object.toString();
        var start = 0;
        var end = rawType.indexOf("_",start);
        if( end === -1 ) {
            end = rawType.indexOf("(",start);
            if( end === -1 )
                return undefined;
            else
                return rawType.slice( start,end );
        }
        else
            return rawType.slice( start,end );
    }
}
