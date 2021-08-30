/**
******************************************************************************
* @file             ButtonStyle.qml
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
import QtQuick.Window 2.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0


Style {
    readonly property Button control: __control

    property Component panel: Rectangle {
        id: panel

        color: "black"
        readonly property real minWidth: 50
        readonly property real minHeight: 50

        readonly property bool hasIcon: icon.status === Image.Ready || icon.status === Image.Loading

        implicitWidth: Math.max(minWidth, minWidth)
        implicitHeight: Math.max(minHeight, minHeight)

        RowLayout {
            id: row

            Image {
                id: icon
                visible: hasIcon
                source: control.iconSource
                Layout.alignment: Qt.AlignCenter
            }

            Label {
                id: label
                text: "sdklhfdkshn"
                Layout.fillWidth: true
                color: "white"
            }
        }
    }
}
