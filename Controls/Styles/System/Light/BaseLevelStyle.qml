import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Private 1.0
import QtQuick.Layouts 1.1
import "../../../../Resources/Colors"
import "../../../../Controls"

Style {
    id: root
    readonly property Level control: __control
    property bool verticalOrientation: false   ///< true - вертикальная ориентация; false - горизонтальная
    property bool extendedHandle: false        ///< true - выдвинутый указатель; false - задвинутый указатель
    property bool handleFolowToValue: true     ///< true - указатель будет на месте текущего значения; false - они могут быть в разных местах
    property bool handlesWithoutControl: false ///< true - указательи можно будет двигать пальцем
    property var handleMoved: []               ///< Текущий указатель перемещён
    property int width: 150
    property int height: 50
    property int curItemForMove: -1            ///< Индекс текущего указателя. -1 установка текущего значения без указателя
    property var funcSetValItem: []            ///< Массив функций установки текущих значений для указателей

    onVerticalOrientationChanged: {
        setVerticalOrientation(verticalOrientation)
    }

    function setVerticalOrientation(val) {
        verticalOrientation = val
        var cnt = control.handles.children.length;
        for (var i=0; i<cnt; ++i) {
            funcSetValItem[i](control.handles.children[i].value)
            handleMoved[i]=false
        }
    }

    signal setValue(real val);
    property Component panel: Rectangle {
        id: rectCommonCanvas
        width: root.width
        height: root.height
        clip: false
        onHeightChanged: setValue1(control.value)
        onWidthChanged: setValue1(control.value)

        Component.onCompleted: {
            root.setValue.connect(setValue1)

            var cnt = control.handles.children.length;
            var qml = "";
            var height = verticalOrientation ? root.width : root.height
            var angle = verticalOrientation ? 90 : 0
            var offset = verticalOrientation ? height : 0
            for (var i=0; i<cnt; ++i) {
                //--------------------------------
                //--- Создание объекта handle-a ---
                qml="
                import QtQuick 2.0;
                Image {
                    id: handle
                    property bool selected: false
                    property int angle: 0
                    property int offset: 0
                    source: \""+control.handles.children[i].sourceImg+"\"
                    height: "+height+"
                    width: "+height+"
                    transform: ["+control.handles.children[i].transform+"]
                }"
                control.handles.children[i].img = Qt.createQmlObject(qml, rectCommonCanvas)
                //-----------------------------------------------------------------
                //--- Создание функций для установки handle-ов в нужные значения ---
                funcSetValItem.push( setFuncGenerator(i) );
                handleMoved.push(false)
                //------------------------------------------------
                //--- Коннект для установки значений handle-ов ---
                control.handles.children[i].valChanged.connect( funcSetValItem[i] )
            }
        }

        /** Генератор функций для установки текущего значения для handle */
        function setFuncGenerator(curIndex) {
            return function setValItem(val) {
                var handlePos = calcValInterpolation(val)
                if (verticalOrientation) control.handles.children[curIndex].img.y = rectCommonCanvas.height - handlePos -control.handles.children[curIndex].img.height/2
                else control.handles.children[curIndex].img.x = handlePos - control.handles.children[curIndex].img.width/2

                var cnt = control.handles.children.length;
                var i=0
                var startWidth = 0
                var stopWidth = 0
                var curPos = 0
                if (verticalOrientation) curPos = control.handles.children[i].img.y + control.handles.children[i].img.height / 2
                else curPos = control.handles.children[i].img.x + control.handles.children[i].img.width / 2

                for (i=0; i<cnt; ++i) {
                    if (i === curIndex) continue
                    startWidth = verticalOrientation ? control.handles.children[i].img.y : control.handles.children[i].img.x
                    stopWidth = verticalOrientation ? control.handles.children[i].img.y + control.handles.children[i].img.height : control.handles.children[i].img.x + control.handles.children[i].img.width
                    if (verticalOrientation) { // Вертикальная ориентация
                        if ((curPos >= startWidth) && (curPos <= stopWidth) && !handleMoved[curIndex]) {
                            control.handles.children[curIndex].img.x -= (rectCommonCanvas.width - rectCanvasSolid.width)
                            handleMoved[curIndex] = true
                            break
                        }
                        else if (((curPos < startWidth) || (curPos > stopWidth)) && handleMoved[curIndex]) {
                            handleMoved[i] = false
                            control.handles.children[curIndex].img.x += (rectCommonCanvas.width - rectCanvasSolid.width)
                        }
                    }
                    else { // Горизонтальная ориентация
                        if ((curPos >= startWidth) && (curPos <= stopWidth) && !handleMoved[curIndex]) {
                            control.handles.children[curIndex].img.y += (rectCommonCanvas.height - rectCanvasSolid.height)
                            handleMoved[curIndex] = true
                            break
                        }
                        else if (((curPos < startWidth) || (curPos > stopWidth)) && handleMoved[curIndex]) {
                            handleMoved[curIndex] = false
                            control.handles.children[curIndex].img.y -= (rectCommonCanvas.height - rectCanvasSolid.height)
                        }
                    }
                }
            }
        }

        /** Функция обработки перемещения указателя */
        function mousePosChanged(ev) {
            //-------------------------------------------------------
            //--- Если позиция указателя выходит за границы канвы ---
            if (verticalOrientation) {
                if ( (ev.y < rectCommonCanvas.y) || (ev.y >= (rectCommonCanvas.y + rectCommonCanvas.height)) )  {return}
            }
            else {
                if ( (ev.x < rectCommonCanvas.x) || (ev.x >= (rectCommonCanvas.x + rectCommonCanvas.width)) ) {return}
            }
            //------------------------------------------------------------
            //--- Перемещаем Handle если он совпадает с каким-либо ещё ---
            if (curItemForMove != -1) {
                var cnt = control.handles.children.length;
                var i=0
                var startWidth = 0
                var stopWidth = 0
                for (i=0; i<cnt; ++i) {
                    if (i === curItemForMove) continue
                    startWidth = verticalOrientation ? control.handles.children[i].img.y : control.handles.children[i].img.x
                    stopWidth = verticalOrientation ? control.handles.children[i].img.y + control.handles.children[i].img.height : control.handles.children[i].img.x + control.handles.children[i].img.width
                    if ((control.handles.children[curItemForMove].transform.indexOf("-90") !== -1) ||
                        (control.handles.children[curItemForMove].transform.indexOf("270") !== -1) ||
                        (control.handles.children[i].transform.indexOf("-90") !== -1) ||
                        (control.handles.children[i].transform.indexOf("270") !== -1)) continue
                    if (verticalOrientation) { // Вертикальная ориентация
                        if ((ev.y >= startWidth) && (ev.y <= stopWidth) && !handleMoved[curItemForMove]) {
                            control.handles.children[curItemForMove].img.x -= (rectCommonCanvas.width - rectCanvasSolid.width)
                            handleMoved[curItemForMove] = true
                            break
                        }
                        else if (((ev.y < startWidth) || (ev.y > stopWidth)) && handleMoved[curItemForMove]) {
                            handleMoved[curItemForMove] = false
                            control.handles.children[curItemForMove].img.x += (rectCommonCanvas.width - rectCanvasSolid.width)
                        }
                    }
                    else { // Горизонтальная ориентация
                        if ((ev.x >= startWidth) && (ev.x <= stopWidth) && !handleMoved[curItemForMove]) {
                            control.handles.children[curItemForMove].img.y += (rectCommonCanvas.height - rectCanvasSolid.height)
                            handleMoved[curItemForMove] = true
                            break
                        }
                        else if (((ev.x < startWidth) || (ev.x > stopWidth)) && handleMoved[curItemForMove]) {
                            handleMoved[curItemForMove] = false
                            control.handles.children[curItemForMove].img.y -= (rectCommonCanvas.height - rectCanvasSolid.height)
                        }
                    }
                }
            }

            //----------------------------------------------
            //--- Устанавливаем текущее значение виджета ---
            if (!root.handleFolowToValue && (curItemForMove != -1)) ;
            else control.value = calcVal(ev)
            if (curItemForMove >= 0) {
                if (verticalOrientation)
                    control.handles.children[curItemForMove].img.y = ev.y - control.handles.children[curItemForMove].img.height/2
                else
                    control.handles.children[curItemForMove].img.x = ev.x - control.handles.children[curItemForMove].img.width/2
            }
        }

        /** Захват текущего указателя по нажатию на ЛКМ*/
        function captureHandle(x, y) {
            if (handleFolowToValue) {
                if (control.handles.children.length > 0)
                    curItemForMove = 0
                else curItemForMove = -1
            }
            else {
                var i = 0
                var cnt = control.handles.children.length;
                for (i=0; i<cnt; ++i) {
                    if (verticalOrientation) {
                        if ((y >= control.handles.children[i].img.y) && (y <= (control.handles.children[i].img.y+control.handles.children[i].img.height))) {
                            curItemForMove = i
                            break
                        }
                    }
                    else {
                        if ((x >= control.handles.children[i].img.x) && (x <= (control.handles.children[i].img.x+control.handles.children[i].img.width))) {
                            curItemForMove = i
                            break
                        }
                    }
                }
                if (i === cnt ) curItemForMove = -1
            }
        }

        /** Освобождение текущего указателя по отпусканию ЛКМ */
        function freeHandle() {
            curItemForMove = -1
        }

        /** Функция расчитывает текущее значение уровня и выставляет его заполненным и пустым прямоугольником */
        function calcVal(ev) {
            if (verticalOrientation) { // Вертикальня ориентация
                setRectangles(ev.y)
                if ((ev.y >= rectCanvasSolid.y) && (ev.y <= (rectCanvasSolid.y + rectCanvasSolid.height))) {
                    var val = calcY(rectCanvasSolid.y, rectCanvasSolid.height, control.min, control.max, ev.y)
                }
                else if (ev.y < rectCanvasSolid.y) {
                    val = calcY(rectCanvasSolid.y, rectCanvasSolid.height, control.min, control.max, rectCanvasSolid.y + rectCanvasSolid.height)
                }
                else if (ev.y > (rectCanvasSolid.y + rectCanvasSolid.height)) {
                     val = calcY(rectCanvasSolid.y, rectCanvasSolid.height, control.min, control.max, 0)
                }
            }
            else {// Горизонтальная ориентация
                setRectangles(ev.x)
                if ((ev.x >= rectCanvasSolid.x) && (ev.x <= (rectCanvasSolid.x + rectCanvasSolid.width))) {
                    val = calcY(rectCanvasSolid.x, rectCanvasSolid.width, control.min, control.max, ev.x)
                }
                else if (ev.x < rectCanvasSolid.x) {
                    val = calcY(rectCanvasSolid.x, rectCanvasSolid.width, control.min, control.max, 0)
                }
                else if (ev.x > (rectCanvasSolid.x + rectCanvasSolid.width)) {
                     val = calcY(rectCanvasSolid.x, rectCanvasSolid.width, control.min, control.max, rectCanvasSolid.x + rectCanvasSolid.width)
                }
            }
            return val
        }

        /** Находит текущее положение курсора в зависимости от переданного значения */
        function calcValInterpolation(val) {
            var retVal = 0.0
            if (verticalOrientation) retVal = calcX(rectCanvasSolid.y, rectCanvasSolid.height, control.min, control.max, val)
            else retVal = calcX(rectCanvasSolid.x, rectCanvasSolid.width, control.min, control.max, val)
            return retVal
        }

        /** Функция установки текущего значения val на слайдере*/
        function setValue1(val) {
            //------------------------------
            //--- Ищем положение курсора ---
            var valInterpolation = calcValInterpolation(val)
            //----------------------------------------------------------
            //--- Устанавливаем заполненный и пустойт прямоугольники ---
            setRectangles(valInterpolation)
            //------------------------------
            //--- Устанавливаем значение ---
            control.value = val
        }

        /** Функция установки текущего значения val для слайдера ind */
        function setValueHandle(ind, val) {
            //------------------------------
            //--- Ищем положение курсора ---
            var valInterpolation = 0.0
            if (verticalOrientation) {
                valInterpolation = calcX(rectCanvasSolid.y, rectCanvasSolid.height, control.min, control.max, val)
                control.handles.children[ind].img.y = valInterpolation
            }
            else {
                valInterpolation = calcX(rectCanvasSolid.x, rectCanvasSolid.width, control.min, control.max, val)
                control.handles.children[ind].img.x = valInterpolation
            }
        }

        /** Устанавливает пустой и заполненный прямоугольники слева и справа от курсоса  */
        function setRectangles(xValInterpolation) {
            if (verticalOrientation) {
                rectEmptyCanvas.height = xValInterpolation
                rectFilledCanvas.height = rectCanvasSolid.height - rectEmptyCanvas.height
            }
            else {
                rectFilledCanvas.width = xValInterpolation  - rectCanvasSolid.x - 1
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
//            anchors.bottom: parent.bottom
//            anchors.left: parent.left
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            height: verticalOrientation ? parent.height : (extendedHandle ? 0.5 : 1) * parent.height
            width: verticalOrientation ? (extendedHandle ? 0.5 : 1) * parent.width : parent.width

            Rectangle {
                id: rectFilledCanvas
                color: MaterialColors.green500
                height: verticalOrientation ? 0 : parent.height
                width:  verticalOrientation ? parent.width : 0
                anchors.bottom: parent.bottom
                x: verticalOrientation ? rectEmptyCanvas.x : parent.x
                y: verticalOrientation ? rectEmptyCanvas.y+rectEmptyCanvas.height : parent.y

            }
            Rectangle {
                id: rectEmptyCanvas
                color: MaterialColors.gray300
                height: verticalOrientation ? 0 : parent.height
                width: verticalOrientation ? parent.width : 0
                anchors.top: parent.top
                x: verticalOrientation ? parent.x : rectFilledCanvas.x+rectFilledCanvas.width
                y: verticalOrientation ? parent.y: parent.y
            }

        }
        MouseArea {
            id: mouseArea
            enabled: !handlesWithoutControl
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            height: parent.height
            width:  parent.width
            Connections {
                onPressed: captureHandle(mouseArea.mouseX, mouseArea.mouseY)
            }

            Component.onCompleted: {
                mouseArea.positionChanged.connect( mousePosChanged )
                mouseArea.released.connect( freeHandle )
            }
        }
    }
}
