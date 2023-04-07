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

import "../../Core/Meta/Type.js" as Meta
import "../../Resources/Colors"
import "../" as FQL
import "../widgets" as Widgets
import "../../Core/"

Item {
    id: listContentItem

    property Component delegate
    property var       model
    property bool      contentUnder: true
    property bool      propagateEvents: true
    property bool      checkable: true
    property var       color: StyleConfigurator.theme.transparent

    Widgets.ContentItem {

        id: contentItem

        width: listContentItem.width
        height: listContentItem.height

        color: listContentItem.color
        contentUnder: listContentItem.contentUnder
        propagateEvents: listContentItem.propagateEvents
        checkable: listContentItem.checkable

        Grid {
            columns: 1
            spacing: 1
            Repeater{
                model: listContentItem.model
                delegate: listContentItem.delegate
            }
        }
    }
}
