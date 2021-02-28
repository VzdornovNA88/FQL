/**
  ******************************************************************************
  * @file             Type.js
  * @brief            Method to getting type of any QML component(object)
  * @authors          Nik A. Vzdornov
  * @date             18.01.21
  *
  * @page 1 Factory for QML objects
  ******************************************************************************
  *   - ECMA-262 5 edition with Qt 5.5.1
  *
  */

.pragma library

/** @fn string(type of qml object) function Of( ANY QML COMPONENT object )
*/
function of(object) {
    var rawType = object.toString();
    var start = 0;
    var end = rawType.indexOf("_",start);
    if( end === -1 )
        return undefined;
    else
        return rawType.slice( start,end );
}
