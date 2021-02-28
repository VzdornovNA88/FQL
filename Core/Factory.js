/**
  ******************************************************************************
  * @file             Factory.js
  * @brief            Factory method for qml objects
  * @authors          Nik A. Vzdornov
  * @date             18.01.21
  *
  * @page 1 Factory for QML objects
  ******************************************************************************
  *   - ECMA-262 5 edition with Qt 5.5.1
  *   - Designed to create components from .qrc file
  *
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
