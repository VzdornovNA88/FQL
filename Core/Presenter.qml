/**
  ******************************************************************************
  * @file             Presenter.qml
  * @brief            free implementation of the MVP pattern
  * @authors          Nik A. Vzdornov
  * @date             18.01.21
  *
  * @page 2 Presenter is as MVP
  ******************************************************************************
  *   - ECMA-262 5 edition with Qt 5.5.1/QtQuick 2.0
  *
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
            var name;
            for ( var i in root.modelToViewBindings ) {
                name = root.modelToViewBindings[ i ];
                dynamicBinding.createObject( root, {
                    target: root.view, property: name, source: root.model, sourceProperty: name
                } );
            }
        }

        function viewToModelBind() {
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
    property QtObject model : Factory.create( pathModel,root )

    /// set these arrays of properties to really name properties of objects to use the automatic binding mechanism between them
    property var modelToViewBindings: []
    property var viewToModelBindings: []

    /// Auto binding mechanism
    onModelChanged: privateScoupe.modelToViewBind()
    onViewChanged:  privateScoupe.viewToModelBind()

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

