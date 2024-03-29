/**
******************************************************************************
* @file             Control.qml
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

FocusScope {
    id: root

    property Component style
    property QtObject __style: styleLoader.item
    property Item __panel: panelLoader.item

    implicitWidth: __panel ? __panel.implicitWidth: 0
    implicitHeight: __panel ? __panel.implicitHeight: 0
    baselineOffset: __panel ? __panel.baselineOffset: 0
    activeFocusOnTab: false

    Loader {
        id: panelLoader
        anchors.fill: parent
        sourceComponent: __style ? __style.panel : null
        onStatusChanged: if (status === Loader.Error) console.error("Failed to load Style for", root)
        Loader {
            id: styleLoader
            sourceComponent: style
            property var __control: root
            onStatusChanged: {
                if (status === Loader.Error)
                    console.error("Failed to load Style for", root)
            }
        }
    }

    signal desroyed
    Component.onDestruction: desroyed();
}
