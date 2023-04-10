  /**
  ******************************************************************************
  * @file             Factory.js
  * @brief            Factory method for qml objects(ECMA-262 5 edition with Qt 5.5.1 , designed to create components from .qrc file)
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

/** @fn QtObject function create( QString url, QtObject parent )
    @brief it creates object from usual relative path in your filesystem as example (../controls/button.qml)
    @param url is usual relative path in your filesystem as example (../controls/button.qml)
    @param parent is object parent for new object
*/
function create( url,parent ) {

    var __isValidURL__ = url !== undefined && url !== null && url !== "";

    if ( __isValidURL__ === true )
    {
        var __component__ = Qt.createComponent( url, parent );
        var __object__ = __component__.createObject( parent );

        if ( __object__ === null )
            console.log( "Could not create " + url + ":\n" + __component__.errorString() );

        return __object__;
    }
    else
    {
        console.log( "URL is not valid : " + url );
        return null;
    }
}
