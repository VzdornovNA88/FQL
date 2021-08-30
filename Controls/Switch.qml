import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0

import "../Core"

Switch {
    id: switch_

    style: StyleConfigurator.getStyleCurrent( switch_ )

    property var  colorOn
    property var  colorOff

    // Механика и форма отображения свитча требуют конкретных пропорцией для корректного отображения и управления
    // по умолчанию идельный вариант пропорций свитча это 1:2 , в другом случае хэндл компонента может быть не
    // круглой формы и зависеть от высоты элемента в целом
    height: width/2

    Keys.onPressed: {
        if (event.key === Qt.Key_Space && !event.isAutoRepeat)
            checked = !checked;
    }
}
