/**
******************************************************************************
* @file             WidgetButtonStyle.qml
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

import "../../../../Core/Meta"
import "../../../../Core/Meta/Type.js" as Meta
import "../../../../Resources/Colors"
import "../../../../Core/ColorHelpers.js" as ColorHelpers

ButtonBaseStyle {

    signal componentLoaded( string type_ );

    Private {

        id: d

        function forEach_ ( child_ ) {

            var activities_ = 0;

            if( child_ !== null && child_ !== undefined ) {

                var type_ = Meta.self.typeof( child_ );

                child_.activeFocusOnTab = false;

                if( child_.checked !== undefined && type_ !== "Button" )
                    type_ = "Checkable";
                switch( type_ ) {

                case "QQuickText" :

                    var lighter_ = child_.color.toString();
                    var darker_  = Qt.tint( child_.color,colorForeground__ );

                    child_.color = Qt.binding(function() {

                        if( control.enabled )
                            return lighter_;
                        else
                            return darker_;
                    });

                    activities_++;
                    componentLoaded( type_ );
                    break;

                case "Button" :

                    if( control.clickable ) {

                        child_.activeFocusOnPress = false;

                        if(  control.propagateEvents === true ) {
                            child_.clicked.connect(function(){
                                child_.checkable = false;
                                child_.checked = false;
                            });

                            control.__behavior.entered.connect(function(event){
                                child_.checkable = true;
                                child_.checked = !child_.checked;
                                child_.__behavior.keyPressed = true;
                            });

                            control.__behavior.released.connect(function(event){
                                child_.checkable = true;
                                child_.checked = !child_.checked;
                                child_.__behavior.keyPressed = false;
                                child_.__action.trigger(child_)
                                child_.__behavior.toggle()
                            });
                        }
                    }
                    activities_++;
                    componentLoaded( type_ );

                    break;

                case "Checkable" :

                    if( control.propagateEvents === true ) {
                    control.clicked.connect(function(){

                        child_.checked = !child_.checked;
                    });
                    }
                    activities_++;
                    componentLoaded( type_ );
                    break;

                case "QQuickTextEdit" :

                    activities_++;
                    componentLoaded( type_ );
                    break;

                case "QQuickImage" :
                    // TODO: incorrect handling for size bindings of image !!!
                    activities_++;
                    componentLoaded( type_ );
                    break;

//                case "QQuickRectangle" :

//                    activities_++;
//                    componentLoaded( type_ );

//                    break;

                default:
                    for(var i = 0; i < child_.children.length; ++i) {

                        activities_ += forEach_( child_.children[i] );
                    }
                    if( child_.children.length === 0 )
                        child_.visible = false;
                    componentLoaded( type_ );
                    break;
                }

                if( activities_ === 0 )
                    child_.visible = false;

                return activities_;
            }
        }
    }

    Component.onCompleted: {

        widthAvailable  = Qt.binding(function(){return control.contentLoader__.width});
        heightAvailable = Qt.binding(function(){return control.contentLoader__.height});

        d.forEach_( control.contentItem__ );
        control.contentLoaded__.connect( d.forEach_ );
    }
}
