import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Private 1.0
import QtQuick.Layouts 1.1
import "../../../../Resources/Colors"
import "../../../../Controls"

Style {
    id: root
    readonly property Level control: __control
    property bool verticalOrientation: false ///< true - вертикальная ориентация; false - горизонтальная
    property bool extendedHandle: false      ///< true - выдвинутый указатель; false - задвинутый указатель

    signal setValue(real val);
    property Component panel: Rectangle {
        id: rectCommonCanvas
        height: control.height
        width: control.width
        clip: true
        onHeightChanged: setValue1(control.value)
        onWidthChanged: setValue1(control.value)

        /** Функция обработки перемещения указателя */
        function mousePosChanged(ev) {
            if (verticalOrientation) { // Вертикальня ориентация
                if ((ev.y >= rectCanvasSolid.y) && (ev.y <= (rectCanvasSolid.y + rectCanvasSolid.height))) {
                    imgHandle.y = ev.y - imgHandle.height/2
                    setRectangles()

                    var val = calcY(rectCanvasSolid.y, rectCanvasSolid.height, control.min, control.max, rectCanvasSolid.height - imgHandle.y - imgHandle.height/2)
                }
                else if (ev.y < rectCanvasSolid.y) {
                    imgHandle.y = -imgHandle.width/2
                    setRectangles()

                    val = calcY(rectCanvasSolid.y, rectCanvasSolid.height, control.min, control.max, rectCanvasSolid.y + rectCanvasSolid.height)
                }
                else if (ev.y > (rectCanvasSolid.y + rectCanvasSolid.height)) {
                     imgHandle.y = rectCanvasSolid.y + rectCanvasSolid.height - imgHandle.width/2
                     setRectangles()

                     val = calcY(rectCanvasSolid.y, rectCanvasSolid.height, control.min, control.max, 0)
                }
            }
            else {// Горизонтальная ориентация
                if ((ev.x >= rectCanvasSolid.x) && (ev.x <= (rectCanvasSolid.x + rectCanvasSolid.width))) {
                    imgHandle.x = ev.x - imgHandle.width/2
                    setRectangles()

                    val = calcY(rectCanvasSolid.x, rectCanvasSolid.width, control.min, control.max, ev.x)
                }
                else if (ev.x < rectCanvasSolid.x) {
                    imgHandle.x = -imgHandle.width/2
                    setRectangles()

                    val = calcY(rectCanvasSolid.x, rectCanvasSolid.width, control.min, control.max, 0)
                }
                else if (ev.x > (rectCanvasSolid.x + rectCanvasSolid.width)) {
                     imgHandle.x = rectCanvasSolid.x + rectCanvasSolid.width - imgHandle.width/2
                     setRectangles()

                     val = calcY(rectCanvasSolid.x, rectCanvasSolid.width, control.min, control.max, rectCanvasSolid.x + rectCanvasSolid.width)
                }
            }
            control.value = val
        }

        Connections {
            target: root
            Component.onCompleted: {
                root.setValue.connect(setValue1)
            }
        }
        /** Функция установки текущего значения val на слайдере*/
        function setValue1(val) {
            //------------------------------
            //--- Ищем положение курсора ---
            if (verticalOrientation) {
                var y = calcX(rectCanvasSolid.y, rectCanvasSolid.height, control.min, control.max, val)
                y = y + imgHandle.height/2
                imgHandle.y = rectCanvasSolid.height + rectCanvasSolid.y - y
            }
            else {
                var x = calcX(rectCanvasSolid.x, rectCanvasSolid.width, control.min, control.max, val)
                x = x - imgHandle.width/2
                imgHandle.x = x
            }
            //----------------------------------------------------------
            //--- Устанавливаем заполненный и пустойт прямоугольники ---
            setRectangles()
            //------------------------------
            //--- Устанавливаем значение ---
            control.value = val
        }

        /** Устанавливает пустой и заполненный прямоугольники слева и справа от курсоса
          * @param st установленный стиль (__style) */
        function setRectangles() {
            if (verticalOrientation) {
                rectEmptyCanvas.height = imgHandle.y + imgHandle.width/2 - rectCanvasSolid.y
                rectEmptyCanvas.width = rectCanvasSolid.width
                rectFilledCanvas.height = rectCanvasSolid.height - rectEmptyCanvas.height
                rectFilledCanvas.width = rectCanvasSolid.width
            }
            else {
                rectFilledCanvas.width = imgHandle.x + imgHandle.width/2 - rectCanvasSolid.x
                rectEmptyCanvas.width = rectCanvasSolid.width - rectFilledCanvas.width
            }
        }

        /** Возвращает y, при линейной интерполяции из отрезка от (x0,y0) до (x1,y1) */
        function calcY(x0, x1, y0, y1, x) {
            var retVal = ((y1-y0)*(x-x0)/(x1-x0)) + y0
            return retVal
        }

        /** Возвращает x, при линейной интерполяции из отрезка от (x0,y0) до (x1,y1) */
        function calcX(x0, x1, y0, y1, y) {
            var retVal = 1+(y-y0)*(x1-x0)/(y1-y0)
            return retVal
        }

        Rectangle {
            id: rectCanvasSolid
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            height: verticalOrientation ? parent.height : (extendedHandle ? 0.7 : 1) * parent.height
            width: verticalOrientation ? (extendedHandle ? 0.7 : 1) * parent.width : parent.width

            Rectangle {
                id: rectFilledCanvas
                color: RSM_Colors.green
                height: verticalOrientation ? 0 : parent.height
                width:  verticalOrientation ? parent.width : 50
                anchors.bottom: parent.bottom
                x: verticalOrientation ? imgHandle.x : parent.x
                y: verticalOrientation ? imgHandle.y + imgHandle.height/2 : parent.y
            }
            Rectangle {
                id: rectEmptyCanvas
                color: RSM_Colors.gray_light
                height: verticalOrientation ? 0 : parent.height
                width: verticalOrientation ? parent.width : 0
                anchors.top: parent.top
                x: verticalOrientation ? parent.x : (imgHandle.x + imgHandle.width/2)
                y: verticalOrientation ? parent.y: parent.y
            }

        }
        Image {
            id: imgHandle
            source: "qrc:/Vector.svg"
            height: verticalOrientation ? width : rectCommonCanvas.height
            width: verticalOrientation ? rectCommonCanvas.width : height
            transform: [
                Rotation { origin.x: 0; origin.y: 0; angle: verticalOrientation ? 90 : 0},
                Translate { x: verticalOrientation ? /*root*/control.width : 0 }
            ]
            onVisibleChanged: {
                if (visible) {
                    if (verticalOrientation) imgHandle.anchors.right = rectCommonCanvas.right
                    else imgHandle.anchors.top = rectCommonCanvas.top
                }
            }
        }
        MouseArea {
            id: mouseArea
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            height: parent.height
            width:  parent.width
            Component.onCompleted: {
                mouseArea.positionChanged.connect( mousePosChanged );
            }
        }
    }
}
