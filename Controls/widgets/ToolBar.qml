/**
******************************************************************************
* @file             ToolBar.qml
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

import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4
import QtQuick.Controls.Private 1.0

import "../../Core/Meta/Type.js" as Meta
import "../../Resources/Colors"
import "../" as FQL
import "../widgets" as Widgets
import "../../Core"

Control {
    id: toolBar

    property var    model

    property var   imageBackButtonURI  : ""
    property var   imageNextButtonURI  : ""
    property bool  vertical            : true
    property bool  isExclusiveGroup    : true

    property var   colorButtonsControl
    property var   colorTabItems
    property var   colorBackground

    style: StyleConfigurator.getStyleCurrent( toolBar )

    property Component horizontalLayout : Component {
//        id : horizontalLayout
        Row {
            id: layout

            width: toolBar.width
            height: toolBar.height

            spacing: 0

            Widgets.ContentItem {
                id: back

                width: layout.width*0.15
                height: layout.height

                color: colorButtonsControl
                activatable: false

                Item  {
                    id: item

                    width:  Math.min(back.contentAvailableHeight*0.8,back.contentAvailableWidth*0.8)
                    height: Math.min(back.contentAvailableHeight*0.8,back.contentAvailableWidth*0.8)

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter

                    Image {
                        id: imgback

                        width                    : item.height
                        height                   : item.height

                        source                   : toolBar.imageBackButtonURI

                        anchors.verticalCenter: item.verticalCenter
                        anchors.horizontalCenter: item.horizontalCenter
                    }
                }

                enabled: tools.currentIndex !== 0
                onClicked: tools.decrementCurrentIndex()
            }

            ListView {
                id: tools

                width: layout.width*0.7
                height: layout.height

                spacing     : 0
                clip        : true

                snapMode: ListView.SnapOneItem
                cacheBuffer: Math.max(currentItem.height*count,0)

                orientation: ListView.Horizontal

                ExclusiveGroup { id: tabGroup }

                model: toolBar.model
                delegate: Widgets.TabItem {
                    id: tab

                    width: tools.height
                    height: tools.height

                    vertical: false
                    exclusiveGroup: toolBar.isExclusiveGroup ? tabGroup : null
                    color: colorTabItems

                    onClicked: tools.currentIndex = index;

                    Item  {
                        id: itemdelegate

                        width:  tab.contentAvailableWidth
                        height: tab.contentAvailableWidth
                        Image {
                            id: img

                            width                    : itemdelegate.width*0.8
                            height                   : itemdelegate.width*0.8

                            source                   : model.imguri

                            anchors.verticalCenter   : itemdelegate.verticalCenter
                            anchors.horizontalCenter : itemdelegate.horizontalCenter
                        }
                    }
                }
            }

            Widgets.ContentItem {
                id: next

                width: layout.width*0.15
                height: layout.height

                color: colorButtonsControl
                activatable: false

                Item  {
                    id: itemnext

                    width:  Math.min(next.contentAvailableHeight*0.8,next.contentAvailableWidth*0.8)
                    height: Math.min(next.contentAvailableHeight*0.8,next.contentAvailableWidth*0.8)

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter

                    Image {
                        id: imgnext

                        width                    : itemnext.height
                        height                   : itemnext.height

                        source                   : toolBar.imageNextButtonURI

                        anchors.verticalCenter   : itemnext.verticalCenter
                        anchors.horizontalCenter : itemnext.horizontalCenter
                    }
                }

                enabled: tools.currentIndex !== tools.count - 1
                onClicked: tools.incrementCurrentIndex()
            }
        }
    }

    property Component verticalLayout : Component {
//        id : verticalLayout
        Column {
            id: layout

            width: toolBar.width
            height: toolBar.height

            spacing: 0

            Widgets.ContentItem {
                id: back

                width: layout.width
                height: layout.height*0.15

                color: colorButtonsControl
                activatable: false

                Item  {
                    id: item

                    width:  Math.min(back.contentAvailableHeight*0.8,back.contentAvailableWidth*0.8)
                    height: Math.min(back.contentAvailableHeight*0.8,back.contentAvailableWidth*0.8)

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter

                    Image {
                        id: imgback

                        width                    : item.height
                        height                   : item.height

                        source                   : toolBar.imageBackButtonURI

                        anchors.verticalCenter: item.verticalCenter
                        anchors.horizontalCenter: item.horizontalCenter
                    }
                }

                enabled: tools.currentIndex !== 0
                onClicked: tools.decrementCurrentIndex()
            }

            ListView {
                id: tools

                width: layout.width
                height: layout.height*0.7

                spacing     : 0
                clip        : true

                snapMode: ListView.SnapOneItem
                cacheBuffer: Math.max(currentItem.height*count,0)

                orientation: ListView.Vertical

                ExclusiveGroup { id: tabGroup }

                model: toolBar.model
                delegate: Widgets.TabItem {
                    id: tab

                    width: tools.width
                    height: tools.width

                    vertical: true
                    exclusiveGroup: toolBar.isExclusiveGroup ? tabGroup : null
                    color: colorTabItems

                    onClicked: tools.currentIndex = index;

                    Item  {
                        id: itemdelegate

                        width:  tab.contentAvailableWidth
                        height: tab.contentAvailableWidth
                        Image {
                            id: img

                            width                    : itemdelegate.width*0.8
                            height                   : itemdelegate.width*0.8

                            source                   : model.imguri

                            anchors.verticalCenter   : itemdelegate.verticalCenter
                            anchors.horizontalCenter : itemdelegate.horizontalCenter
                        }
                    }
                }
            }

            Widgets.ContentItem {
                id: next

                width: layout.width
                height: layout.height*0.15

                color: colorButtonsControl
                activatable: false

                Item  {
                    id: itemnext

                    width:  Math.min(next.contentAvailableHeight*0.8,next.contentAvailableWidth*0.8)
                    height: Math.min(next.contentAvailableHeight*0.8,next.contentAvailableWidth*0.8)

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter

                    Image {
                        id: imgnext

                        width                    : itemnext.height
                        height                   : itemnext.height

                        source                   : toolBar.imageNextButtonURI

                        anchors.verticalCenter   : itemnext.verticalCenter
                        anchors.horizontalCenter : itemnext.horizontalCenter
                    }
                }

                enabled: tools.currentIndex !== tools.count - 1
                onClicked: tools.incrementCurrentIndex()
            }
        }
    }

    Loader {
        id: loaderOfLayouts
        sourceComponent: vertical ? verticalLayout : horizontalLayout
    }
}
