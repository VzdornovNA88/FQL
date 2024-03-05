  /**
  ******************************************************************************
  * @file             StyleConfigurator.qml
  * @brief            Config manager for styles and themes (ECMA-262 5 edition with Qt 5.5.1/QtQuick 2.0)
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

pragma Singleton

import FQL.Controls.Styles.Types 1.0
import FQL.Core.Meta 1.0
import FQL.Core.Base 1.0

Class {
    id: configurator

    property string pathStyle:  "../../Controls/Styles/"
    property string styleDefault:  Styles.flat
    property string themeDefault:  Themes.dark
    
    readonly property var theme : d.themeCurrentObject
    readonly property var nameOfCurrentTheme : d.themeCurrent

    Private {
        id: d

        property var cache : ({})
        property var cacheTheme : ({})
        property string styleCurrent:  styleDefault
        property string themeCurrent:  themeDefault

        property var themeCurrentObject

        onThemeCurrentChanged: {
            var theme_ = configurator.getTheme();
            if( theme_ )
              themeCurrentObject = theme_;
            else
              console.log("FQL::StyleConfigurator.getTheme() - theme is undefined : 'themeCurrent'");
            console.log("onThemeCurrentChanged - ",themeCurrentObject.valueCollor,themeCurrent)
        }

        function getStyle(path) {

            if( path in cache ) {
//                console.log("getStyle - path in cache ")
                return cache[path];
            }
            else {
                cache[path] = Qt.createComponent( path, configurator );
//                console.log("getStyle - path create - ",path,cache[path])
                return cache[path];
            }
        }
        
        function getTheme(path) {

            if( path in cacheTheme ) {
                console.log("getTheme - path in cacheTheme ")
                return cacheTheme[path];
            }
            else {
                cacheTheme[path] = Factory.create( path, configurator );
                console.log("getTheme - path create - ",path,cacheTheme[path])
                return cacheTheme[path];
            }
        }     
    }


    function getStyle( style,control ) {

        var path = pathStyle + style + "/" + Type.self.typeof( control ) + "Style.qml";
        return d.getStyle( path );
    }

    function getStyleDefault( control ) {

        var path = pathStyle + styleDefault + "/" + Type.self.typeof( control ) + "Style.qml";
        return d.getStyle( path );
    }

    function getStyleCurrent( control ) {

        var path = pathStyle + d.styleCurrent + "/" + Type.self.typeof( control ) + "Style.qml";
        return d.getStyle( path );
    }

    function getStyleCurrentByNameControl( nameControl ) {

        var path = pathStyle + d.styleCurrent + "/" + nameControl + "Style.qml";
        return d.getStyle( path );
    }

    function switchToStyle( style ) {
        d.styleCurrent = style;
    }

    function backToDefaultStyle() {
        d.styleCurrent = styleDefault;
    }


    function getTheme() {

        var path = pathStyle + d.styleCurrent + "/Themes/" + d.themeCurrent + ".qml";
        return d.getTheme( path );
    }
    
    function switchToTheme( theme ) {
        d.themeCurrent = theme;
    }

    function backToDefaultTheme() {
        d.themeCurrent = themeDefault;
    }      
}
