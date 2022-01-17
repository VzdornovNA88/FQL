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

import QtQuick.Layouts 1.1

import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4
import "../"
import "../../Controls" as FQL
import "../../Resources/Colors"
import "../../Core"

ContentItem {
    id: view

    clickable   : false
    checkable   : false
    activatable : false
    borderFocus : false
    contentUnder: false

    readonly property var textId               : view.contentItem__.children[1]
    property var          colorText            : MaterialColors.grey900
    property var          text                 : ""
    property bool         closeButtonVisible   : false

    property var          imageCloseButtonURI  : ""
    property var          imageForTextURI      : ""

    // Unfortunatly, we need to force manual load the style for that component as 'WidgetButton'
    // because while we adding a new itself property, we actualy disable the qml engine optimization for objects.
    // So, type that has a new itself property is a new type of controlls for qml engine and so we have to add new style for each new
    // type of controlls but we load the style that has been loaded because the representation of that component is the same as its parent
    // we do that we want to avoid cost of memory and process loading each new style
    style: StyleConfigurator.getStyleCurrentByNameControl( "WidgetButton" )

    signal close()

    Item  {
        id: row

        width:  view.contentAvailableWidth
        height: view.contentAvailableHeight

        Image {
            id: imgtext

            width:  row.height*0.5
            height: row.height*0.5
            anchors.left: row.left
            anchors.verticalCenter: row.verticalCenter
            anchors.leftMargin: 10

            source                 : imageForTextURI

            Component.onCompleted: {
                if( imageForTextURI !== undefined &&
                        imageForTextURI !== null && imageForTextURI !== "" )
                    visible = true;
            }
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
            anchors.left: imgtext.right
            anchors.right: close.left 
//            anchors.leftMargin: close.visible ? width*0.3 : width*0.3
            anchors.leftMargin: 35


            color: view.colorText
            text:  view.text
        }

        FQL.Button {
            id: close

            width:  visible ? row.height : 10
            height: row.height
            anchors.right: row.right
            anchors.verticalCenter: row.verticalCenter

            color: MaterialColors.transparent
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
            }

            onClicked: view.close()
        }
    }
}
