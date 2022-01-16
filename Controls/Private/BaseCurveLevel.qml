import QtQuick 2.0
import QtQuick.Controls.Private 1.0
import "../"

Control {
    id: root
    property real min: 10                      ///< минимальное значение
    property real max: 200                     ///< максимальное значение
    property real value: 95                    ///< текущее значение
    property int xCenter: 0                    ///< Х координата центра дуги окружности
    property int yCenter: 0                    ///< Y координата центра дуги окружности
    property int radius: 0                     ///< Радиус дуги окружности
    property real startAngle: 0                ///< Начальный угол отрисовки (в радианах)
    property real stopAngle: 0                 ///< Конечный угол отрисовки (в радианах)
    property int widthArc: 0                   ///< Толщина дуги
    property bool anticlockwise: false         ///< Против часовой стрелки

    signal valChanged(real val);               ///< Сигнал о том, что текущее значение изменилось

    Component.onCompleted: {
        var st = __style
        st.xCenter = xCenter
        st.yCenter = yCenter
        st.radius = radius
        st.startAngle = startAngle
        st.stopAngle = stopAngle
        st.widthArc = widthArc
        st.anticlockwise = anticlockwise
        st.height = root.height
        st.width = root.width
        root.valChanged.connect(st.setValue)
        valChanged(value);
    }

    onHeightChanged: valChanged(value)
    onWidthChanged: valChanged(value)
    onValueChanged: valChanged(value)
}

