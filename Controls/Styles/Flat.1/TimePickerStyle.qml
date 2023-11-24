/**
******************************************************************************
* @file             TimePickerStyle.qml
* @brief
* @authors          Nik A. Vzdornov
* @date             21.11.23
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

import FQL.Compat.Effects.ColorOverlay 1.0
import FQL.Resources.Colors 1.0
import FQL.Core.Meta 1.0
import FQL.Core.Base 1.0
import FQL.Controls.Private 1.0
import FQL.Controls.Base 1.0
import FQL.Controls.Widgets 1.0

Style {
    id: timePickerStyle

    property var colorBackground     : StyleConfigurator.theme.transparent
    property var colorButtonsControl : StyleConfigurator.theme.buttonGeneralCollor
    property var colorBorderHighliter: StyleConfigurator.theme.borderAccent2Collor

    property alias timePicker        : timePickerStyle.control

    property Component panel: Rectangle {
        id : focusable

        width               : timePicker.width
        height              : timePicker.height

        color: timePicker.colorBackground ? timePicker.colorBackground : timePickerStyle.colorBackground

        property int hoursCurrentIndex : 0
        property int minutesCurrentIndex : 0

        //        property Component horizontalLayout : Component {

        //        }

        property Component verticalLayout : Row {
            id: row

            spacing: 4

            Column {

                id: layout

                width: focusable.width*0.45 - row.spacing*2
                height: focusable.height

                spacing: 5

                Button {
                    id: back

                    width: layout.width
                    height: layout.height*0.2

                    color: timePicker.colorButtonsControl ? timePicker.colorButtonsControl : timePickerStyle.colorButtonsControl

                    visible: timePicker.visibleControlButtons

                    iconSource: timePicker.imageBackButtonURI

                    onClicked: view.decrementCurrentIndex()
                }

                PathView {
                    id: view

                    width: layout.width
                    height: layout.height*0.6 - layout.spacing*2

                    property real itemHeight: 30

                    clip: true
                    model: timePicker.maxHours

                    currentIndex: timePicker.is24h ? timePicker.hours : timePicker.hours - 1
                    pathItemCount: height/itemHeight
                    preferredHighlightBegin: 0.5
                    preferredHighlightEnd: 0.5

                    highlight: Rectangle {
                        width: view.width
                        height: view.itemHeight+4
                        color : StyleConfigurator.theme.transparent
                        border.color: colorBorderHighliter
                        border.width: 2
                    }

                    delegate: Rectangle {
                        id : delegate
                        width: view.width - 8
                        height: view.itemHeight - 6
                        color : StyleConfigurator.theme.lighter50Collor

                        Text {
                            id: textInfo

                            width: delegate.width*0.4

                            wrapMode : Text.WrapAtWordBoundaryOrAnywhere
                            minimumPixelSize: 1
                            font.pixelSize: Math.min(delegate.width*0.5,delegate.height*2.0)*0.4
                            font.bold: true
                            font.italic: true

                            anchors.verticalCenter: delegate.verticalCenter
                            anchors.horizontalCenter: delegate.horizontalCenter

                            color: StyleConfigurator.theme.textGeneralCollor
                            text: timePicker.is24h ? modelData : modelData + 1
                        }
                    }

                    dragMargin: view.width/2

                    path: Path {
                        startX: view.width/2; startY: -view.itemHeight/2
                        PathLine { x: view.width/2; y: view.pathItemCount*view.itemHeight + view.itemHeight }
                    }

                    onCurrentIndexChanged: timePicker.hours = timePicker.is24h ? currentIndex : currentIndex + 1

                    Keys.onDownPressed: incrementCurrentIndex()
                    Keys.onUpPressed: decrementCurrentIndex()
                }

                Button {
                    id: next

                    width: layout.width
                    height: layout.height*0.2

                    color: timePicker.colorButtonsControl ? timePicker.colorButtonsControl : timePickerStyle.colorButtonsControl

                    visible: timePicker.visibleControlButtons

                    iconSource: timePicker.imageNextButtonURI

                    onClicked: view.incrementCurrentIndex()
                }
            }

//            Text {
//                id: text

//                width: focusable.width*0.1 - row.spacing*2

//                wrapMode : Text.WrapAtWordBoundaryOrAnywhere
//                minimumPixelSize: 1
//                font.pixelSize: Math.min(focusable.width*0.5,focusable.height*2.0)*0.3
//                font.bold: true
//                font.italic: true

//                anchors.verticalCenter: layout.verticalCenter

//                color: StyleConfigurator.theme.textGeneralCollor
//                text: ":"
//            }

            Column {

                id: layout2

                width: focusable.width*0.45 - row.spacing*2
                height: focusable.height

                spacing: 5

                Button {
                    id: back2

                    width: layout2.width
                    height: layout2.height*0.2

                    color: timePicker.colorButtonsControl ? timePicker.colorButtonsControl : timePickerStyle.colorButtonsControl

                    visible: timePicker.visibleControlButtons

                    iconSource: timePicker.imageBackButtonURI

                    onClicked: view2.decrementCurrentIndex()
                }

                PathView {
                    id: view2

                    width: layout2.width
                    height: layout2.height*0.6 - layout2.spacing*2

                    property real itemHeight: 30

                    clip: true
                    model: timePicker.maxMinutes

                    currentIndex: timePicker.minutes
                    pathItemCount: height/itemHeight
                    preferredHighlightBegin: 0.5
                    preferredHighlightEnd: 0.5

                    highlight: Rectangle {
                        width: view2.width
                        height: view2.itemHeight+4
                        color : StyleConfigurator.theme.transparent
                        border.color: colorBorderHighliter
                        border.width: 2
                    }

                    delegate: Rectangle {
                        id : delegate2
                        width: view2.width - 8
                        height: view2.itemHeight - 6
                        color : StyleConfigurator.theme.lighter50Collor

                        Text {
                            id: textInfo2

                            width: delegate2.width*0.4

                            wrapMode : Text.WrapAtWordBoundaryOrAnywhere
                            minimumPixelSize: 1
                            font.pixelSize: Math.min(delegate2.width*0.5,delegate2.height*2.0)*0.4
                            font.bold: true
                            font.italic: true

                            anchors.verticalCenter: delegate2.verticalCenter
                            anchors.horizontalCenter: delegate2.horizontalCenter

                            color: StyleConfigurator.theme.textGeneralCollor
                            text: modelData
                        }
                    }

                    dragMargin: view2.width/2

                    path: Path {
                        startX: view2.width/2; startY: -view2.itemHeight/2
                        PathLine { x: view2.width/2; y: view2.pathItemCount*view2.itemHeight + view2.itemHeight }
                    }

                    onCurrentIndexChanged: timePicker.minutes = currentIndex

                    Keys.onDownPressed: incrementCurrentIndex()
                    Keys.onUpPressed: decrementCurrentIndex()
                }

                Button {
                    id: next2

                    width: layout2.width
                    height: layout2.height*0.2

                    color: timePicker.colorButtonsControl ? timePicker.colorButtonsControl : timePickerStyle.colorButtonsControl

                    visible: timePicker.visibleControlButtons

                    iconSource: timePicker.imageNextButtonURI

                    onClicked: view2.incrementCurrentIndex()
                }
            }

        }

        Loader {
            id: loaderOfLayouts
            sourceComponent: /*toolBar.vertical ? */verticalLayout /*: horizontalLayout*/
        }
    }
}
