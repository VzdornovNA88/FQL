/**
  ******************************************************************************
  * @file             StackLoaderNavigator.qml
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

import FQL.Core.Base 1.0
import FQL.Core.Meta 1.0

Navigator {
    id                      : navigator

    width                   : parent.width
    height                  : parent.height

    focus                   : true

    property alias item     : d.item

    Loader {
        id                  : d
        width               : navigator.width
        height              : navigator.height
        focus               : true
        asynchronous        : true

        onLoaded            : {
            item.forceActiveFocus();
            d.handleLoadedState(item,sourceComponent_);
        }
        onStatusChanged: if (d.status == Loader.Null
                                 || d.status == Loader.Error) {
                             handleLoadedState(item,sourceComponent_)
                         }

        property var stack_ : []
        property bool isItemRemoving_ : false
        property var cmdWhileStackBusy_: undefined
        property Component sourceComponent_ : undefined

        onSourceComponent_Changed: {
            d.sourceComponent = sourceComponent_;
        }

        function handleLoadedState(item,comp) {
            d.isItemRemoving_ = false;

            if( d.cmdWhileStackBusy_ ) {

                d.cmdWhileStackBusy_();
                d.cmdWhileStackBusy_ = undefined;
            }

            itemLoaded(item,comp);
        }

        function setContent (newContent) {
            sourceComponent_ = newContent;
        }
    }

    acceptRemove   : function (item) {
        //        console.log("NAVIGATOR acceptRemove ",d.item,item)
        if( item === d.item ) {
            d.setContent( d.stack_.length-1 < 0 ? null : d.stack_[d.stack_.length-1] );
        }
    }

    property var isItemRemoving : function () {
        return d.isItemRemoving_;
    }

    currentItem     : function () {
        return d.item;
    }

    currentComponent     : function () {
        return d.sourceComponent_;
    }

    popAll          : function (list) {
        if( list.lenght === 0 ) return;

        if( d.isItemRemoving_ ) {
            d.cmdWhileStackBusy_ = function () {
                navigator.popAll(list);
            };
            return;
        }

        list.forEach(function(itemList,indexStack) {
            var stack_ = d.stack_;
            d.stack_ = stack_.filter(function(itemStack) {
//                                console.log("STACK - POP ALL - ",list,d.stack_,itemStack,itemList)
                return itemStack !== itemList;
            });
        });

        length = d.stack_.length;

        var newContent = d.stack_.length-1 < 0 ? null : d.stack_[d.stack_.length-1];

        if( newContent === d.sourceComponent_ ) {
            return;
        }

        d.isItemRemoving_ = true;
        removeRequested( d.item,d.sourceComponent_ );
    }

    pop             : function (nextItem) {

        if( d.isItemRemoving_ ) {
            d.cmdWhileStackBusy_ = function () {
                navigator.pop(nextItem);
            };
            return;
        }

        var previousIdxItem = null;

        if(typeof nextItem === 'undefined') {
            d.stack_.pop();
//                        console.log("STACK - POP UNDEFINED - ",d,d.stack_,nextItem)
        }
        else
            if(nextItem === null) {
                d.stack_ = [];
//                            console.log("STACK - POP NULL - ",d,d.stack_,nextItem)
            }
            else
                if ((previousIdxItem = d.stack_.indexOf(nextItem, 0)) !== -1) {
                    d.stack_.splice(previousIdxItem,1);
//                                console.log("STACK - POP - ",d,d.stack_,nextItem)
                }

        length = d.stack_.length;

        var newContent = d.stack_.length-1 < 0 ? null : d.stack_[d.stack_.length-1];

        if( newContent === d.sourceComponent_ ) {
            return;
        }

        d.isItemRemoving_ = true;
        removeRequested( d.item,d.sourceComponent_ );
    }

    navigateTo              : function (nextItem) {
//        console.log("navigateTo - ",d.isItemRemoving_,d.sourceComponent_,nextItem);
        if( d.isItemRemoving_ ) {
            d.cmdWhileStackBusy_ = function () {
                navigator.navigateTo(nextItem);
            };
            return;
        }

        if( d.sourceComponent_ === nextItem ) {
            return;
        }

        var previousIdxItem = null;

        if(typeof nextItem === 'undefined') {
            d.stack_.pop();
//            console.log("STACK - NAVIGATE -> UNDEFINED - ",d,d.stack_,nextItem)
        }
        else
            if(nextItem === null) {
                d.stack_ = [];
//                console.log("STACK - NAVIGATE -> NULL - ",d,d.stack_,nextItem)
            }
            else
                if ((previousIdxItem = d.stack_.indexOf(nextItem, /*d.stack_.length-1*/0)) !== -1) {
                    d.stack_.splice(previousIdxItem+1,d.stack_.length-1-previousIdxItem);
//                    console.log("STACK - SPLICE - ",d,d.stack_,nextItem)
                }
                else {
                    d.stack_.push( nextItem );
//                    console.log("STACK - PUSH - ",d,d.stack_,nextItem)
                }

        length = d.stack_.length;

        var newContent = d.stack_.length-1 < 0 ? null : d.stack_[d.stack_.length-1];

        if( newContent === d.sourceComponent_ )
            return;
//console.log("INSTANT CONTENT navigate - ",d,d.item,d.sourceComponent_,newContent)
        if( d.sourceComponent_ ) {
            d.isItemRemoving_ = true;
            removeRequested( d.item,d.sourceComponent_ );
        }
        else
            d.setContent(newContent);
    }
}
