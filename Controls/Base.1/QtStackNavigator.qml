  /**
  ******************************************************************************
  * @file             QtStackNavigator.qml
  * @brief            The set of constants of styles(name) 
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
import FQL.Compat.Controls.QtQuickControls 1.0

Navigator {
    id: qtStackNavigator

    anchors.fill: parent
    focus: true

    property alias stack : d

    StackView {
        id: d
        anchors.fill: qtStackNavigator
        focus: true
    }

    navigateTo : function (nextItem) {

        if( !stack ) {

            console.error( "error: FQL::Core::Navigator::QtStackNavigator - Navigator instance is not exist in navigateTo function" );
            return;
        }

        var previousItem = null;

        var predicate = function(currentItem) {
            return currentItem.objectName === nextItem.objectName;
        }

        if(typeof nextItem === 'undefined' || nextItem === null ) {
            stack.pop( {immediate: true} );
        }
        else
        if ((previousItem = stack.find(predicate)) !== null && typeof previousItem !== 'undefined') {
            stack.pop( {item: previousItem, immediate: true} );
        }
        else {
            stack.push( {item: nextItem, immediate: true} );
            stack.currentItem.forceActiveFocus();
        }
    }
}
