  /**
  ******************************************************************************
  * @file             Presenter.qml
  * @brief            free implementation of the MVP pattern (ECMA-262 5 edition with Qt 5.5.1/QtQuick 2.0)
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

import QtQuick 2.0
import QtQuick.Controls 1.4
import "Factory.js" as Factory
import "../Core/Meta/"

FocusScope {
    id: root

    Private {
        id: privateScoupe

        function modelToViewBind() {
            if( ( root.model === null || root.model === undefined ) ||
                ( root.view === null  || root.view === undefined )  ) return;

            var name;
            for ( var i in root.modelToViewBindings ) {
                name = root.modelToViewBindings[ i ];
                dynamicBinding.createObject( root, {
                    target: root.view, property: name, source: root.model, sourceProperty: name
                } );
            }
        }

        function viewToModelBind() {
            if( ( root.model === null || root.model === undefined ) ||
                ( root.view === null  || root.view === undefined )  ) return;

            var name;
            for ( var j in root.viewToModelBindings ) {
                name = root.viewToModelBindings[ j ];
                dynamicBinding.createObject( root, {
                    target: root.model, property: name, source: root.view, sourceProperty: name
                } );
            }
        }
    }

    /// set the property to instance of QML StackView to control navigation your chain of Presenters
    property StackView navigator: null

    /// set these properties to usual relative path in your filesystem of components
    /// to use the automatic binding mechanism between them or use properties ( view, model )
    property string   pathView      : ""
    property string   pathModel     : ""

    /// set these properties to really objects to use the automatic binding mechanism between them or use
    /// properties ( pathView, pathModel )
    property Item     view  : Factory.create( pathView ,root )
    property var      model : Factory.create( pathModel,root )

    /// set these arrays of properties to really name properties of objects to use the automatic binding mechanism between them
    property var modelToViewBindings: []
    property var viewToModelBindings: []

    /// Auto binding mechanism
    onModelChanged: privateScoupe.modelToViewBind()
    onViewChanged:  privateScoupe.viewToModelBind()

    onPathModelChanged: privateScoupe.modelToViewBind()
    onPathViewChanged:  privateScoupe.viewToModelBind()

    Component.onCompleted: {

        root.view.anchors.fill = root;
        root.view.focus = true;

        privateScoupe.modelToViewBind();
        privateScoupe.viewToModelBind();
    }

    Component {
        id: dynamicBinding

        Binding {
            id: binding

            property var source
            property string sourceProperty

            value: binding.source[ binding.sourceProperty ]
        }
    }


    /** @fn function navigateTo( QML Item nextItem )
        @brief it navigates from current Presenteer to next Presenter(requires to provide instance QML StackView in property "navigator")
        @param nextItem is next Presenter which must be QML Item
    */
    function navigateTo(nextItem) {

        var previousItem = null;

        var predicate = function(currentItem) {
            return currentItem.objectName === nextItem.objectName;
        }

        if(typeof nextItem === 'undefined' || nextItem === null ) {
            navigator.pop( {immediate: true} );
        }
        else
        if ((previousItem = navigator.find(predicate)) !== null && typeof previousItem !== 'undefined') {
            navigator.pop( {item: previousItem, immediate: true} );
        }
        else {
            navigator.push( {item: nextItem, immediate: true} );
            navigator.currentItem.forceActiveFocus();
        }
    }
}

