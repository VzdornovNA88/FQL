/**
******************************************************************************
* @file             GridContentItem.qml
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

import FQL.Core.Base 1.0

Item {
    id: listContentItem

    property int       columns : 1
    property int       rows : 1
    property Component delegate
    property var       model
    property bool      contentUnder: true
    property bool      propagateEvents: true
    property bool      checkable: false
    property bool      activatable: true
    property bool      clickable: true
    property var       color: StyleConfigurator.theme.transparent
    property double    radius : 0

    property alias     checked : contentItem.checked
    property alias     activated : contentItem.activated
    property alias     activatedFromFocus : contentItem.activatedFromFocus

    property alias     hovered : contentItem.hovered
    property alias     pressed : contentItem.pressed

    signal clicked()

    ContentItem {

        id: contentItem

        width: listContentItem.width
        height: listContentItem.height

        color: listContentItem.color
        contentUnder: listContentItem.contentUnder
        propagateEvents: listContentItem.propagateEvents
        checkable: listContentItem.checkable
        activatable: listContentItem.activatable
        clickable: listContentItem.clickable
        radius: listContentItem.radius

        onClicked: listContentItem.clicked()

        Item {
            id : item

            width: contentItem.contentAvailableWidth
            height: contentItem.contentAvailableHeight
        Grid {
            columns: listContentItem.columns
            rows: listContentItem.rows

            width: item.width*0.99
            height: item.height*0.99

            anchors.centerIn: item

//            spacing: 1
            Repeater{
                model: listContentItem.model
                delegate: listContentItem.delegate
            }
        }
        }
    }
}
