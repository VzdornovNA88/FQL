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

import QtQuick 2.2

import FQL.Core.Meta 1.0
import FQL.Core.Base 1.0

FocusScope {
  id: root

  Private {
      id: privateScoupe

      property bool isBound : false
      property var bindings : []

      function isNotHandler (item,index,array) {
          return  item.toString().indexOf("Changed") === -1;
      }

      function isSignal (item) {
          return  item instanceof Function  &&
                  item.prototype === undefined &&
                  item.connect instanceof Function;
      }

      function isSlot (item) {
          return  item instanceof Function;
      }

      function createBinding(name,index,array) {
          console.log("createBinding - ",name);
          var functionInView = root.view[name];
          var functionInModel = root.model[name];
          if( isSlot(functionInModel) && isSignal(functionInView) )
              functionInView.connect(functionInModel);
          else
              privateScoupe.bindings.push( dynamicBinding.createObject( root, {
                                                                       target: root.view,
                                                                       property: name,
                                                                       source: root.model,
                                                                       sourceProperty: name
                                                                   } ) );
      }

      function modelToViewBind() {

          if( ( ( root.model == null || root.model == undefined )  ||
                ( root.view == null  || root.view == undefined ) ) &&
              isBound ) {

              for ( var i in privateScoupe.bindings ) {
                  privateScoupe.bindings[ i ].destroy();
              }
              privateScoupe.bindings = [];
              isBound = false;

              return;
          }
          else if( ( ( root.model == null || root.model == undefined )  ||
                    ( root.view == null  || root.view == undefined ) ) ||
                  isBound )
              return;

          if( root.bindings )
              root.bindings
                  .forEach ( createBinding );
          Object  .keys    ( root.model    )
                  .filter  ( isNotHandler  )
                  .forEach ( createBinding );

          isBound = true;
      }

      function removeReqHandler ( item,component ) {
          if( root && item === root ) {
              root.acceptRemove( item,component );
          }
      }
  }

  function bind() {
      privateScoupe.modelToViewBind();
  }

  /// set the property to instance of QML Navigator to control navigation your chain of Presenters
  property Navigator navigator: null
  onNavigatorChanged: {
      if( navigator ) {
          navigator.removeRequested.connect(privateScoupe.removeReqHandler);
          if( navigator.isItemRemoving() )
              privateScoupe.removeReqHandler(navigator.currentItem(),navigator.currentComponent());
      }
  }


  property var acceptRemove : defaultAcceptRemove
  onAcceptRemoveChanged: {
      if( navigator ) {
          navigator.removeRequested.disconnect(privateScoupe.removeReqHandler);
          navigator.removeRequested.connect(privateScoupe.removeReqHandler);
          if( navigator.isItemRemoving() )
              privateScoupe.removeReqHandler(navigator.currentItem(),navigator.currentComponent());
      }
  }

  function defaultAcceptRemove(item,component) {
      if( navigator )
          navigator.acceptRemove( item );
  }

  function isRemoving() {
      return navigator && navigator.isItemRemoving();
  }

  /// set these properties to usual relative path in your filesystem of components
  /// to use the automatic binding mechanism between them or use properties ( view, model )
  property string         pathView : ""

  /// set these properties to really objects to use the automatic binding mechanism between them
  property Item           view  : Factory.create( pathView ,root )
  property var            model : undefined

  /// set these arrays of properties to really name properties of objects to use the automatic binding mechanism between them
  property var bindings: []

  /// Auto binding mechanism
  onModelChanged: privateScoupe.modelToViewBind()
  onViewChanged: privateScoupe.modelToViewBind()

  Component.onCompleted: {

      if( root.view.parent == root )
          root.view.anchors.fill = root;
      root.view.focus = true;

      privateScoupe.modelToViewBind();
      if( navigator && navigator.isItemRemoving() )
          privateScoupe.removeReqHandler(navigator.currentItem(),navigator.currentComponent());
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

      if( !navigator ) {

          console.error( "error: FQL::Core::Presenter - Navigator instance is not exist in navigateTo function" );
          return;
      }

      if( typeof navigator.navigateTo !== 'function' ) {

          console.error( "error: FQL::Core::Presenter - In Navigator instance 'navigateTo' is not a function" );
          return;
      }

      navigator.navigateTo( nextItem );
  }
}

