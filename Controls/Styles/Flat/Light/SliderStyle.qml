/**
******************************************************************************
* @file             SliderStyle.qml
* @brief
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

import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0

import "../../../../Resources/Colors"
import "../../../../Core/ColorHelpers.js" as ColorHelpers

Style {
    id: styleitem

    property var backgroundColor     : MaterialColors.grey100
    property var fillColor           : MaterialColors.pink700
    property var borderHandleColor   : MaterialColors.grey100
    property var handleColor         : fillColor
    property var tickmarksColor      : MaterialColors.grey400

    /*! The \l Slider this style is attached to. */
    readonly property Slider control: __control

    padding { top: 0 ; left: 0 ; right: 0 ; bottom: 0 }

    /*! This property holds the item for the slider handle.
        You can access the slider through the \c control property
    */
    property Component handle: Rectangle{
            id: backHandle
            width:  height
            height: control.height * 4

            radius: width/2

            color: MaterialColors.transparent
            border.width: 1
            border.color: control.activeFocus ? styleitem.borderHandleColor : MaterialColors.transparent

            Rectangle {
                id: handle
                width: backHandle.width - 6
                height: backHandle.height - 6
                anchors.verticalCenter: backHandle.verticalCenter
                anchors.horizontalCenter: backHandle.horizontalCenter

                radius: width/2
                color: handleColor

            }
    }
    /*! This property holds the background groove of the slider.

        You can access the handle position through the \c styleData.handlePosition property.
    */
    property Component groove: Rectangle {

        anchors.verticalCenter: parent.verticalCenter
//        implicitWidth: Math.round(TextSingleton.implicitHeight * 4.5)
//        implicitHeight: Math.max(6, Math.round(TextSingleton.implicitHeight * 0.3))
        width:  control.width
        height: control.height

        color: backgroundColor

        Item {
            clip: true
            width: styleData.handlePosition
            height: parent.height

            Rectangle {
                anchors.fill: parent
                color: fillColor
            }
        }
    }

    /*! This property holds the tick mark labels
        \since QtQuick.Controls.Styles 1.1

        You can access the handle width through the \c styleData.handleWidth property.
    */
    property Component tickmarks: Repeater {
        id: repeater
        model: control.stepSize > 0 ? 1 + (control.maximumValue - control.minimumValue) / control.stepSize : 0
        Rectangle {
            color: tickmarksColor
            width: 1 ; height: 3
            y: repeater.height
            x: styleData.handleWidth / 2 + index * ((repeater.width - styleData.handleWidth) / (repeater.count-1))
        }
    }

    /*! This property holds the slider style panel.

        Note that it is generally not recommended to override this.
    */
    property Component panel: Item {
        id: root
        property int handleWidth: handleLoader.width
        property int handleHeight: handleLoader.height

        property bool horizontal : control.orientation === Qt.Horizontal
        property int horizontalSize: grooveLoader.implicitWidth + padding.left + padding.right
        property int verticalSize: Math.max(handleLoader.implicitHeight, grooveLoader.implicitHeight) + padding.top + padding.bottom

        implicitWidth: horizontal ? horizontalSize : verticalSize
        implicitHeight: horizontal ? verticalSize : horizontalSize

        y: horizontal ? 0 : height
        rotation: horizontal ? 0 : -90
        transformOrigin: Item.TopLeft

        Item {

            anchors.fill: parent

            Loader {
                id: grooveLoader
                property QtObject styleData: QtObject {
                    readonly property int handlePosition: handleLoader.x + handleLoader.width/2
                }
                x: padding.left
                sourceComponent: groove
                width: (horizontal ? parent.width : parent.height) - padding.left - padding.right
                y:  Math.round(padding.top + (Math.round(horizontal ? parent.height : parent.width - padding.top - padding.bottom) - grooveLoader.item.height)/2)
            }
            Loader {
                id: tickMarkLoader
                anchors.fill: parent
                sourceComponent: control.tickmarksEnabled ? tickmarks : null
                property QtObject styleData: QtObject { readonly property int handleWidth: control.__panel.handleWidth }
            }
            Loader {
                id: handleLoader
                sourceComponent: handle
                anchors.verticalCenter: grooveLoader.verticalCenter
                x: Math.round((control.__handlePos - control.minimumValue) / (control.maximumValue - control.minimumValue) * ((horizontal ? root.width : root.height) - item.width))
            }
        }
    }
}
