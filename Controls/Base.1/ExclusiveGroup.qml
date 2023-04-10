/**
  ******************************************************************************
  * @file             ExclusiveGroup.qml
  * @brief
  * @author           Nik A. Vzdornov (VzdornovNA88@yandex.ru)
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

Item {
    id: eg

    onChildrenChanged: {

        var items = data[data.length - 1];

        if( Type.self.typeof(items) === "QQuickRow"           ||
                Type.self.typeof(items) === "QQuickColumn"        ||
                Type.self.typeof(items) === "QQuickGrid"          ||
                Type.self.typeof(items) === "QQuickRowLayout"     ||
                Type.self.typeof(items) === "QQuickColumnLayout"  ||
                Type.self.typeof(items) === "QQuickGridLayout"     ) {
            for( var i = 0 ; i < items.data.length ; i++ ) {
                bindCheckable(items.data[i]);
            }
        }
        else
            bindCheckable(items);
    }

    Private {
        id: d

        property var checkables : []
        signal checked(var obj)
    }

    function bindCheckable(obj) {
        if( obj && obj.checkable ) {

            var checkable = {
                object : obj ,
                checked : function() {
                    d.checked( obj );
                },

                action : function( o_ ) {

                    if( obj && o_ && obj !== o_ && o_.checked ) {
                        obj.checked = false;
                    }
                }
            };

            obj.desroyed.connect( eg.unbindCheckable );
            obj.onCheckedChanged.connect( checkable.checked );

            d.checked.connect( checkable.action );
            d.checkables.push( checkable );

            d.checked( obj );
        }
    }

    function unbindCheckable(obj) {
        if( obj && obj.checkable ) {
            var idx = d.checkables.findIndex( function(o_) { return obj === o_.object; } );
            if( idx >= 0 ) {
                d.checked.disconnect( d.checkables[idx].action );
                d.checkables[idx].object.onCheckedChanged.disconnect( d.checkables[idx].checked );
                d.checkables.splice(idx,1);
            }
        }
    }
}
