pragma Singleton

import QtQuick 2.0
import "./Meta/"
import "./Meta/Type.js" as Type
import "../Controls/Styles"

Class {
    id: configurator

    property string pathStyle:  "../Controls/Styles/"
    property string styleDefault:  Styles.system
    property string themeDefault:  Themes.light

    Private {
        id: d

        property var cache : ({})
        property string styleCurrent:  styleDefault
        property string themeCurrent:  themeDefault

        function getStyle(path) {

            if( path in cache ) {
                console.log("getStyle - path in cache ")
                return cache[path];
            }
            else {
                cache[path] = Qt.createComponent( path, configurator );
                console.log("getStyle - path create - ",path,cache[path])
                return cache[path];
            }
        }
    }

    function getStyle( style,control ) {

        var path = pathStyle + style + "/" + d.themeCurrent + "/" +Type.of( control ) + "Style.qml";
        return d.getStyle( path );
    }

    function getStyleDefault( control ) {

        var path = pathStyle + styleDefault + "/" + d.themeCurrent + "/"  + Type.of( control ) + "Style.qml";
        return d.getStyle( path );
    }

    function getStyleCurrent( control ) {

        var path = pathStyle + d.styleCurrent + "/" + d.themeCurrent + "/"  + Type.of( control ) + "Style.qml";
        return d.getStyle( path );
    }

    function switchToStyle( style ) {
        d.styleCurrent = style;
    }

    function backToDefaultStyle() {
        d.styleCurrent = styleDefault;
    }

    function switchToTheme( theme ) {
        d.themeCurrent = theme;
    }

    function backToDefaultTheme() {
        d.themeCurrent = themeDefault;
    }

    function cacheClear() {
        cache = {};
    }
}
