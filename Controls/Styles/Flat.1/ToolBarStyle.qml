/**
******************************************************************************
* @file             ToolBarStyle.qml
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

import FQL.Compat.Effects.ColorOverlay 1.0
import FQL.Resources.Colors 1.0
import FQL.Core.Meta 1.0
import FQL.Core.Base 1.0
import FQL.Controls.Private 1.0
import FQL.Controls.Base 1.0
import FQL.Controls.Widgets 1.0

Style {
    id: toolBarStyle

    property var colorBackground     : StyleConfigurator.theme.backgroundSpecialToolBarCollor
    property var colorButtonsControl : StyleConfigurator.theme.buttonGeneralCollor
    property var colorTabItems       : StyleConfigurator.theme.transparent

    property alias toolBar: toolBarStyle.control

    property Component panel: Rectangle {
        id : focusable

        width               : toolBar.width
        height              : toolBar.height

        color: toolBar.colorBackground ? toolBar.colorBackground : toolBarStyle.colorBackground

        property Component horizontalLayout : Component {

            Row {
                id: layout

                width: toolBar.width
                height: toolBar.height

                spacing: 0

                ContentItem {
                    id: back

                    width: layout.width*0.15
                    height: layout.height

                    color: toolBar.colorButtonsControl ? toolBar.colorButtonsControl : toolBarStyle.colorButtonsControl
                    activatable: false

                    visible: toolBar.visibleControlButtons

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

                            ColorOverlay {
                                anchors.fill: imgback
                                source: imgback
                                color: ColorHelpers
                                .suitableFor(back.color)
                                .in([ StyleConfigurator.theme.iconGeneralCollor,
                                     StyleConfigurator.theme.iconAccentCollor,
                                     StyleConfigurator.theme.iconInvertCollor])[0].itemColor.color
                            }
                        }
                    }

                    enabled: tools.currentIndex !== 0
                    onClicked: tools.decrementCurrentIndex()
                }

                ListView {
                    id: tools

                    width: toolBar.visibleControlButtons ? layout.width*0.7 : layout.width
                    height: layout.height

                    spacing     : 0
                    clip        : true

                    snapMode: ListView.SnapOneItem
                    cacheBuffer: Math.max(currentItem.height*count,0)

                    orientation: ListView.Horizontal

                    ExclusiveGroup { id: tabGroup }

                    model: toolBar.model
                    delegate: TabItem {
                        id: tab

                        width: tools.height
                        height: tools.height

                        vertical: false
                        exclusiveGroup: toolBar.isExclusiveGroup ? tabGroup : null
                        color: toolBar.colorTabItems ? toolBar.colorTabItems : toolBarStyle.colorTabItems

                        onClicked: {

                            tools.currentIndex = index;
                            toolBar.tabCliked( tools.currentIndex );
                        }

                        Item  {
                            id: itemdelegate

                            width:  tab.contentAvailableWidth
                            height: tab.contentAvailableWidth
                            Image {
                                id: img

                                width                    : itemdelegate.width*0.8
                                height                   : itemdelegate.width*0.8

                                source                   : modelData

                                anchors.verticalCenter   : itemdelegate.verticalCenter
                                anchors.horizontalCenter : itemdelegate.horizontalCenter

                                ColorOverlay {
                                    anchors.fill: img
                                    source: img
                                    color: ColorHelpers
                                    .suitableFor(tab.color)
                                    .in([ StyleConfigurator.theme.iconGeneralCollor,
                                         StyleConfigurator.theme.iconAccentCollor,
                                         StyleConfigurator.theme.iconInvertCollor])[0].itemColor.color
                                }
                            }
                        }
                    }
                }

                ContentItem {
                    id: next

                    width: layout.width*0.15
                    height: layout.height

                    color: toolBar.colorButtonsControl ? toolBar.colorButtonsControl : toolBarStyle.colorButtonsControl
                    activatable: false

                    visible: toolBar.visibleControlButtons

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

                            ColorOverlay {
                                anchors.fill: imgnext
                                source: imgnext
                                color: ColorHelpers
                                .suitableFor(itemnext.color)
                                .in([ StyleConfigurator.theme.iconGeneralCollor,
                                     StyleConfigurator.theme.iconAccentCollor,
                                     StyleConfigurator.theme.iconInvertCollor])[0].itemColor.color
                            }
                        }
                    }

                    enabled: tools.currentIndex !== tools.count - 1
                    onClicked: tools.incrementCurrentIndex()
                }
            }
        }

        property Component verticalLayout : Component {

            Column {
                id: layout

                width: toolBar.width
                height: toolBar.height

                spacing: 0

                ContentItem {
                    id: back

                    width: layout.width
                    height: layout.height*0.15

                    color: toolBar.colorButtonsControl ? toolBar.colorButtonsControl : toolBarStyle.colorButtonsControl
                    activatable: false

                    visible: toolBar.visibleControlButtons

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

                            ColorOverlay {
                                anchors.fill: imgback
                                source: imgback
                                color: ColorHelpers
                                .suitableFor(back.color)
                                .in([ StyleConfigurator.theme.iconGeneralCollor,
                                     StyleConfigurator.theme.iconAccentCollor,
                                     StyleConfigurator.theme.iconInvertCollor])[0].itemColor.color
                            }
                        }
                    }

                    enabled: tools.currentIndex !== 0
                    onClicked: tools.decrementCurrentIndex()
                }

                ListView {
                    id: tools

                    width: layout.width
                    height: toolBar.visibleControlButtons ? layout.height*0.7 : layout.height

                    spacing     : 0
                    clip        : true

                    snapMode: ListView.SnapOneItem
                    cacheBuffer: Math.max(currentItem.height*count,0)

                    orientation: ListView.Vertical

                    ExclusiveGroup { id: tabGroup }

                    model: toolBar.model
                    delegate: TabItem {
                        id: tab

                        width: tools.width
                        height: tools.width

                        vertical: true
                        exclusiveGroup: toolBar.isExclusiveGroup ? tabGroup : null
                        color: toolBar.colorTabItems ? toolBar.colorTabItems : toolBarStyle.colorTabItems

                        onClicked: {

                            tools.currentIndex = index;
                            toolBar.tabCliked( tools.currentIndex );
                        }

                        Item  {
                            id: itemdelegate

                            width:  tab.contentAvailableWidth
                            height: tab.contentAvailableWidth
                            Image {
                                id: img

                                width                    : itemdelegate.width*0.8
                                height                   : itemdelegate.width*0.8

                                source                   : modelData

                                anchors.verticalCenter   : itemdelegate.verticalCenter
                                anchors.horizontalCenter : itemdelegate.horizontalCenter

                                ColorOverlay {
                                    anchors.fill: img
                                    source: img
                                    color: ColorHelpers
                                    .suitableFor(tab.color)
                                    .in([ StyleConfigurator.theme.iconGeneralCollor,
                                         StyleConfigurator.theme.iconAccentCollor,
                                         StyleConfigurator.theme.iconInvertCollor])[0].itemColor.color
                                }
                            }
                        }
                    }
                }

                ContentItem {
                    id: next

                    width: layout.width
                    height: layout.height*0.15

                    color: toolBar.colorButtonsControl ? toolBar.colorButtonsControl : toolBarStyle.colorButtonsControl
                    activatable: false

                    visible: toolBar.visibleControlButtons

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

                            ColorOverlay {
                                anchors.fill: imgnext
                                source: imgnext
                                color: ColorHelpers
                                .suitableFor(next.color)
                                .in([ StyleConfigurator.theme.iconGeneralCollor,
                                     StyleConfigurator.theme.iconAccentCollor,
                                     StyleConfigurator.theme.iconInvertCollor])[0].itemColor.color
                            }
                        }
                    }

                    enabled: tools.currentIndex !== tools.count - 1
                    onClicked: tools.incrementCurrentIndex()
                }
            }
        }

        Loader {
            id: loaderOfLayouts
            sourceComponent: toolBar.vertical ? verticalLayout : horizontalLayout
        }
    }
}
