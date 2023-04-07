/**
******************************************************************************
* @file             NavigationBar.qml
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

import "../"
import "../../Controls" as FQL
import "../../Resources/Colors"
import "../../Core"
import "../../Core/ColorHelpers.js" as ColorHelpers

ContentItem {
    id: view

    clickable   : false
    checkable   : false
    activatable : false
    borderFocus : false
    contentUnder: false

    readonly property var textId               : view.contentItem__.children[1]
    property var          colorText            : ColorHelpers
                                                 .suitableFor(view.color)
                                                 .in([ StyleConfigurator.theme.textGeneralCollor,
                                                       StyleConfigurator.theme.textInvertCollor])[0].itemColor.color
    property var          colorIcon            : ColorHelpers
                                                 .suitableFor(view.color)
                                                 .in([ StyleConfigurator.theme.iconGeneralCollor,
                                                       StyleConfigurator.theme.iconInvertCollor])[0].itemColor.color
    property var          text                 : ""
    property bool         closeButtonVisible   : false
    property bool         backButtonVisible    : false

    property var          imageBackButtonURI   : ""
    property var          imageCloseButtonURI  : ""

    style: StyleConfigurator.getStyleCurrentByNameControl( "WidgetButton" )

    signal back()
    signal close()

    Item  {
        id: row

        width:  view.contentAvailableWidth
        height: view.contentAvailableHeight

        FQL.Button {
            id:back

            width:  row.height
            height: row.height
            anchors.left: row.left
            anchors.verticalCenter: row.verticalCenter

            color: StyleConfigurator.theme.transparent
            focus: true

            visible: backButtonVisible

            Component.onCompleted: {
                if( imageBackButtonURI !== undefined &&
                        imageBackButtonURI !== null && imageBackButtonURI !== "" )
                    visible = true;
            }

            Image {
                id: imgback

                width                    : back.width*0.6
                height                   : back.height*0.6
                source                   : imageBackButtonURI
                anchors.verticalCenter   : back.verticalCenter
                anchors.horizontalCenter : back.horizontalCenter

                ColorOverlay {
                    anchors.fill: imgback
                    source: imgback
                    color: view.colorIcon ? view.colorIcon : StyleConfigurator.theme.iconGeneralCollor
                }
            }

            onClicked: view.back()
        }

        Text {
            id: textID

            width: row.width*0.6
            height: row.height*0.5

            wrapMode : Text.WrapAtWordBoundaryOrAnywhere
            fontSizeMode : Text.Fit
            minimumPixelSize: 1
            font.pixelSize: 480

            anchors.verticalCenter: row.verticalCenter
            anchors.right: close.left
            anchors.left: back.right
            anchors.leftMargin: 35


            color: view.colorText
            text:  view.text
        }

        FQL.Button {
            id: close

            width:  row.height
            height: row.height
            anchors.right: row.right
            anchors.verticalCenter: row.verticalCenter

            color: StyleConfigurator.theme.transparent
            focus: true

            visible: closeButtonVisible

            Component.onCompleted: {
                if( imageCloseButtonURI !== undefined &&
                        imageCloseButtonURI !== null && imageCloseButtonURI !== "" )
                    visible = true;
            }

            Image {
                id: imgclose

                width                    : close.width*0.5
                height                   : close.height*0.5
                source                   : imageCloseButtonURI
                anchors.verticalCenter   : close.verticalCenter
                anchors.horizontalCenter : close.horizontalCenter

                ColorOverlay {
                    anchors.fill: imgclose
                    source: imgclose
                    color: view.colorIcon ? view.colorIcon : StyleConfigurator.theme.iconGeneralCollor
                }
            }

            onClicked: view.close()
        }
    }
}
