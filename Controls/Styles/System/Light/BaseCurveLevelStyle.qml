import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Private 1.0
import QtQuick.Layouts 1.1
import "../../../../Resources/Colors"
import "../../../../Controls"

Style {
    id: root
    readonly property CurveLevel control: __control
    property int width: 150
    property int height: 50
    property int xCenter: 0
    property int yCenter: 0
    property int radius: 0
    property real startAngle: 0
    property real stopAngle: 0
    property int widthArc: 0
    property bool anticlockwise: false
    property int criticalLevel: 10 ///< Критический уровень отрисовки (в тех же единицах, что и шкала)
    property int warningLevel: 30 ///< Предупреждающий уровень отрисовки (в тех же единицах, что и шкала)

    function stopAngleVal(val) {
        return root.startAngle + ((root.stopAngle-root.startAngle) * val/(control.max-control.min))
    }

    function radToDeg(rad) {
        var retVal = rad * 180 / Math.PI
        return retVal
    }

    function degToRad(deg) {
        return deg * Math.PI / 180
    }

    signal setValue(real val);

    property Component panel: Rectangle {
        Canvas {
            id: arc
            height: root.height
            width:  root.width
            Component.onCompleted: {root.setValue.connect( repaintCanvas )}
            onPaint: repaintCanvas()

            function repaintCanvas() {
                var ctx = getContext("2d")
                ctx.clearRect(0,0,root.width,root.height)

                if (control.value <= root.criticalLevel) {
                    ctx.lineWidth = root.widthArc
                    ctx.strokeStyle = RSM_Colors.gray_light
                    ctx.fillStyle =   RSM_Colors.gray_light
                    ctx.beginPath()
                    ctx.arc(root.xCenter, root.yCenter, root.radius, root.startAngle, root.stopAngle, root.anticlockwise)
                    ctx.stroke()
                    ctx.closePath()

                    ctx.beginPath()
                    ctx.lineWidth = 2
                    ctx.strokeStyle = RSM_Colors.red_brand
                    ctx.fillStyle =   RSM_Colors.red_brand

                    ctx.arc(root.xCenter, root.yCenter, root.radius+root.widthArc/2, root.startAngle, root.stopAngle, root.anticlockwise)
                    ctx.arc(root.xCenter, root.yCenter, root.radius-root.widthArc/2, root.stopAngle, root.startAngle, !root.anticlockwise)
                    ctx.closePath()
//                    ctx.arc(root.xCenter, root.yCenter, root.radius+root.widthArc/2, root.startAngle, root.stopAngle, root.anticlockwise)
                    ctx.stroke()
                }
                else if (control.value > root.criticalLevel) {
                    ctx.lineWidth = root.widthArc
                    if (control.value <= root.warningLevel) {
                        ctx.strokeStyle = RSM_Colors.orange
                        ctx.fillStyle =   RSM_Colors.orange
                    }
                    if (control.value > root.warningLevel) {
                        ctx.strokeStyle = RSM_Colors.green
                        ctx.fillStyle =   RSM_Colors.green
                    }

                    ctx.beginPath()
                    ctx.arc(root.xCenter, root.yCenter, root.radius, root.startAngle, stopAngleVal(control.value), root.anticlockwise)
                    ctx.stroke()

                    ctx.beginPath()
                    ctx.strokeStyle = RSM_Colors.gray_light
                    ctx.fillStyle =   RSM_Colors.gray_light
                    ctx.arc(root.xCenter, root.yCenter, root.radius, stopAngleVal(control.value), root.stopAngle, root.anticlockwise)
                    ctx.stroke()
                }
                arc.requestPaint()
            }
        }
    }
}
