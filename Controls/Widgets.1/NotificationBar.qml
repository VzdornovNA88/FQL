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

import FQL.Core.Base 1.0
import FQL.Resources.Colors 1.0
import FQL.Controls.Base 1.0
import FQL.Compat.Effects.ColorOverlay 1.0

ContentItem {
    id: view

    width           : 0
    height          : 0

    clickable       : false
    checkable       : false
    activatable     : false
    borderFocus     : false
    contentUnder    : false
    propagateEvents : false

    readonly property var textId               : view.contentItem__.children[1]
    property var          colorText            : MaterialColors.grey900
    property var          colorImagePlace      : MaterialColors.transparent
    property var          text                 : ""
    property bool         closeButtonVisible   : false

    property var          imageCloseButtonURI  : ""
    property var          imageForTextURI      : ""
    property int          timeAutoCloseMS      : 500

    property double       expandedWidth        : expandedHeight*8
    property double       expandedHeight       : 50
    property bool         autoClosable         : false

    // Unfortunatly, we need to force manual load the style for that component as 'WidgetButton'
    // because while we adding a new itself property, we actualy disable the qml engine optimization for objects.
    // So, type that has a new itself property is a new type of controlls for qml engine and so we have to add new style for each new
    // type of controlls but we load the style that has been loaded because the representation of that component is the same as its parent
    // we do that we want to avoid cost of memory and process loading each new style
    style: StyleConfigurator.getStyleCurrentByNameControl( "WidgetButton" )

    signal close(int direction)
    signal open()

    onRightSwipe: close(1)
    onLeftSwipe:  close(-1)

    Component.onCompleted: {
        view.open.connect(autoCloseTimerID.openNotification);
        view.close.connect(autoCloseTimerID.closeNotification);
    }

    readonly property var autoCloseTimer: Timer {
        id : autoCloseTimerID
        running: view.autoClosable && extended
        repeat: false
        interval: view.timeAutoCloseMS
        onTriggered: view.close(0);

        property bool extend   : extended
        property bool extended : false
        property int direction : 0

        property double x__ : 0

        function openNotification (){
            extend = true;
            extended = false;
        }
        function closeNotification (direction){
            extend = false;
            extended = false;
            autoCloseTimerID.direction = direction;
        }
    }

    states: [
        State {
            when: autoCloseTimerID.extend
            PropertyChanges { target: view; width: view.expandedWidth }
            PropertyChanges { target: view; height: view.expandedHeight }
            onCompleted: {
                autoCloseTimerID.extended = true;
                autoCloseTimerID.x__ = view.x;
            }
        },
        State {
            when: !autoCloseTimerID.extend && autoCloseTimerID.direction === 1
            PropertyChanges { target: view; width: view.expandedWidth }
            PropertyChanges { target: view; height: view.expandedHeight }
            PropertyChanges { target: view; x: view.expandedWidth*2 }
            onCompleted: {
                view.height = 0;
                view.width = 0;
                view.x = autoCloseTimerID.x__;
            }
        },
        State {
            when: !autoCloseTimerID.extend && autoCloseTimerID.direction === -1
            PropertyChanges { target: view; width: view.expandedWidth }
            PropertyChanges { target: view; height: view.expandedHeight }
            PropertyChanges { target: view; x: -view.expandedWidth*2 }
            onCompleted: {
                view.height = 0;
                view.width = 0;
                view.x = autoCloseTimerID.x__;
            }
        }
    ]

    transitions:
        Transition {
        PropertyAnimation { properties: "width,height,x"; easing.type: Easing.InOutCubic;duration: 1000 }
    }

    Item  {
        id: row

        width:  view.contentAvailableWidth
        height: view.contentAvailableHeight

        Rectangle {
            id: imgtext

            width:  row.height*0.5
            height: row.height*0.5

            anchors.left: row.left
            anchors.verticalCenter: row.verticalCenter
            anchors.leftMargin: 10

            radius: width/2
            clip: true

            color : colorImagePlace

            Image {
                id: img

                width:  imgtext.width*0.7
                height: width

                anchors.centerIn: imgtext

                source : imageForTextURI
                visible : ( imageForTextURI !== undefined &&
                            imageForTextURI !== null      &&
                            imageForTextURI !== ""        )

                ColorOverlay {
                    anchors.fill: img
                    source: img
                    color: ColorHelpers
                    .suitableFor(imgtext.color)
                    .in([ StyleConfigurator.theme.iconGeneralCollor,
                    StyleConfigurator.theme.iconInvertCollor])[0].itemColor.color
                }
            }
        }

        Text {
            id: textID

            width: row.width*0.6
            height: row.height*0.5

            wrapMode : Text.WrapAtWordBoundaryOrAnywhere
//            fontSizeMode : Text.Fit
            minimumPixelSize: 1
            font.pixelSize: Math.min(row.width*0.5,row.height)*0.2

            anchors.verticalCenter: row.verticalCenter
            anchors.left: imgtext.right
            anchors.right: closeID.left
//            anchors.leftMargin: closeID.visible ? width*0.3 : width*0.3
            anchors.leftMargin: 35


            color: view.colorText
            text:  view.text
        }

        Button {
            id: closeID

            width:  visible ? row.height : 10
            height: row.height
            radius: view.radius
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

                width                    : closeID.width*0.5
                height                   : closeID.height*0.5
                source                   : imageCloseButtonURI
                anchors.verticalCenter   : closeID.verticalCenter
                anchors.horizontalCenter : closeID.horizontalCenter
            }

            onClicked: view.close(0)
        }
    }
}
