import QtQuick 2.0
import QtQuick.Controls.Private 1.0
import "../"

Control {
    id: root
    property real min: 10                      ///< минимальное значение
    property real max: 200                     ///< максимальное значение
    property real value: 95                    ///< текущее значение
    property bool verticalOrientation: false   ///< true - вертикальная ориентация; false - горизонтальная
    property bool extendedHandle: true         ///< true - выдвинутый указатель; false - задвинутый указатель
    property bool handleFolowToValue: true     ///< true - указатель будет на месте текущего значения; false - они могут быть в разных местах
    property bool handlesWithoutControl: false ///< true - указательи можно будет двигать пальцем
    property ListLevelHandles handles:[]


    signal valChanged(real val);             ///< Сигнал о том, что текущее значение изменилось

    Component.onCompleted: {
        var st = __style
        root.valChanged.connect(st.setValue)
        st.verticalOrientation = verticalOrientation
        st.setVerticalOrientation(verticalOrientation)
        st.extendedHandle = extendedHandle
        st.handleFolowToValue = handleFolowToValue
        st.handlesWithoutControl = handlesWithoutControl
        st.height = root.height
        st.width = root.width
        valChanged(value);
    }

    onHeightChanged: valChanged(value)
    onWidthChanged: valChanged(value)
}

