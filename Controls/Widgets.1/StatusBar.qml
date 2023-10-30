/**
******************************************************************************
* @file             StatusBar.qml
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

import FQL.Core.Meta 1.0
import FQL.Core.Base 1.0
import FQL.Resources.Colors 1.0
import FQL.Compat.Effects.ColorOverlay 1.0
import FQL.Controls.Base 1.0

ContentItem {
    id: view

    clickable   : true
    checkable   : false
    activatable : false
    borderFocus : false
    contentUnder: false
    color: StyleConfigurator.theme.transparent

    Component.onCompleted: {
        view.__style.invertPressedColor = Qt.binding(function(){
            return invertPressedColor;
        });
    }

    property var          iconAccount      : ""
    property string       machineName      : ""
    property var          iconNotificationMachine : ""
    property var          iconNotificationEngine : ""
    property var          iconLevelLink    : ""
    property var          iconNumberOfSatellities    : ""
    property int          valueNumberOfSatellities : 0
    property var          valueTemperOutside : ""
    property string       date : ""
    property string       time : ""
    property int          valueNumberOfNotificationsMachine : 0
    property int          valueNumberOfNotificationsEngine : 0
    property bool         isCriticalErorrsOfMachine : false
    property bool         isCriticalErorrsOfEngine : false
    property bool         invertPressedColor : false
    property bool         enabledTemperOutside : true


    signal close()


    Item  {
        id: row

        width:  view.contentAvailableWidth
        height: view.contentAvailableHeight

        Image {
            id: accountImage

            width:  Math.min(row.width*0.05,row.height)*0.8
            height: width
            anchors.left: row.left
            anchors.leftMargin: row.width*0.008
            anchors.verticalCenter: row.verticalCenter

            source                 : view.iconAccount

            ColorOverlay {
                anchors.fill: accountImage
                source: accountImage
                color: StyleConfigurator.theme.iconGeneralCollor
            }
        }


        Text {
            id: timeText

            height                 : row.height*0.5

            anchors.left: accountImage.right
            anchors.leftMargin: row.width*0.01
            anchors.bottom: row.bottom
            anchors.bottomMargin: row.height*0.35

            wrapMode : Text.WrapAtWordBoundaryOrAnywhere
            minimumPixelSize: 1

            font.pixelSize: Math.min(row.width*0.08,row.height)*0.6
            text                   : view.time
            color: StyleConfigurator.theme.textAccentCollor
        }
        Text {
            id: dateText

            height                 : row.height*0.5

            anchors.left: timeText.right
            anchors.leftMargin: row.width*0.01
            anchors.bottom: row.bottom
            anchors.bottomMargin: row.height*0.15

            wrapMode : Text.WrapAtWordBoundaryOrAnywhere
            minimumPixelSize: 1

            font.pixelSize: Math.min(row.width*0.08,row.height)*0.4
            text                   : view.date
            color: StyleConfigurator.theme.textAccentCollor
        }


        Text {
            id: machineNameText

            height                 : row.height*0.5

            anchors.bottom: row.bottom
            anchors.bottomMargin: row.height*0.15
            anchors.horizontalCenter: row.horizontalCenter
            anchors.horizontalCenterOffset: row.width*0.02

            wrapMode : Text.WrapAtWordBoundaryOrAnywhere
            minimumPixelSize: 1

            font.bold: true
            font.italic: true
            font.pixelSize: Math.min(row.width*0.08,row.height)*0.4

            property bool   isMachineNameExists : !( view.machineName == undefined ||
                                                 view.machineName == null      ||
                                                 view.machineName == ""         )

            text                   : isMachineNameExists ? view.machineName : "---"

            color: StyleConfigurator.theme.textAccentCollor
        }


        Item {
            id: recNotificationMachineImageParent

            width:  Math.min(row.width*0.05,row.height)
            height: width

            visible: valueNumberOfNotificationsMachine > 0

            anchors.right: recNotificationEngineImageParent.left
            anchors.rightMargin: row.width*0.015
            anchors.verticalCenter: row.verticalCenter

        Rectangle {
            id: recNotificationMachineImage

            width:  recNotificationMachineImageParent.width*0.85
            height: width

            anchors.centerIn: recNotificationMachineImageParent

            radius: width/2
            clip: true

            color : view.isCriticalErorrsOfMachine ?
                        StyleConfigurator.theme.systemAccnetErrorActiveCollor :
                        StyleConfigurator.theme.systemAccnetWornActiveCollor

        Image {
            id: notificationMachineImage

            width:  recNotificationMachineImage.width*0.7
            height: width

            anchors.centerIn: recNotificationMachineImage

            source                 : view.iconNotificationMachine

            ColorOverlay {
                anchors.fill: notificationMachineImage
                source: notificationMachineImage
                color: ColorHelpers
                .suitableFor(recNotificationMachineImage.color)
                .in([ StyleConfigurator.theme.iconGeneralCollor,
                      StyleConfigurator.theme.iconInvertCollor])[0].itemColor.color
            }
        }
        }

        Text {
            id: valueNumNotificationMachineText

            height                 : row.height*0.5

            anchors.left: recNotificationMachineImage.right
            anchors.leftMargin: recNotificationMachineImage.width*0.02
            anchors.top: recNotificationMachineImage.top
            anchors.topMargin: -height*0.25

            wrapMode : Text.WrapAtWordBoundaryOrAnywhere
            minimumPixelSize: 1

            font.pixelSize: Math.min(notificationMachineImage.width,notificationMachineImage.height)*0.7
            text                   : view.valueNumberOfNotificationsMachine
            color: StyleConfigurator.theme.textAccentCollor
        }
        }

        Item {
            id: recNotificationEngineImageParent

            width:  Math.min(row.width*0.05,row.height)
            height: width

            visible: valueNumberOfNotificationsEngine > 0

            anchors.right: temperOutsideText.left
            anchors.rightMargin: row.width*0.035
            anchors.verticalCenter: row.verticalCenter

        Rectangle {
            id: recNotificationEngineImage

            width:  recNotificationEngineImageParent.width*0.85
            height: width

            anchors.centerIn: recNotificationEngineImageParent

            radius: width/2

            color: view.isCriticalErorrsOfEngine ?
                       StyleConfigurator.theme.systemAccnetErrorActiveCollor :
                       StyleConfigurator.theme.systemAccnetWornActiveCollor

        Image {
            id: notificationEngineImage

            width:  recNotificationMachineImage.width*0.7
            height: width

            anchors.centerIn: recNotificationEngineImage

            source                 : view.iconNotificationEngine

            ColorOverlay {
                anchors.fill: notificationEngineImage
                source: notificationEngineImage
                color: ColorHelpers
                .suitableFor(recNotificationEngineImage.color)
                .in([ StyleConfigurator.theme.iconGeneralCollor,
                      StyleConfigurator.theme.iconInvertCollor])[0].itemColor.color
            }
        }
        }

        Text {
            id: valueNumNotificationEngineText

            height                 : row.height*0.5

            anchors.left: recNotificationEngineImage.right
            anchors.leftMargin: recNotificationEngineImage.width*0.02
            anchors.top: recNotificationEngineImage.top
            anchors.topMargin: -height*0.25

            wrapMode : Text.WrapAtWordBoundaryOrAnywhere
            minimumPixelSize: 1

            font.pixelSize: Math.min(notificationEngineImage.width,notificationEngineImage.height)*0.7
            text                   : view.valueNumberOfNotificationsEngine
            color: StyleConfigurator.theme.textAccentCollor
        }
        }


        Text {
            id: temperOutsideText

            height                 : row.height*0.5

            anchors.right: levelLinkImage.left
            anchors.rightMargin: row.width*0.01
            anchors.bottom: row.bottom
            anchors.bottomMargin: row.height*0.35

            wrapMode : Text.WrapAtWordBoundaryOrAnywhere
            minimumPixelSize: 1

            visible: enabledTemperOutside

            font.pixelSize: Math.min(row.width*0.08,row.height)*0.6

            property bool   isValueTemperOutsideExists : !( view.valueTemperOutside == undefined ||
                                                 view.valueTemperOutside == null      ||
                                                 view.valueTemperOutside == ""         )

            text                   : (isValueTemperOutsideExists ? view.valueTemperOutside : "--") + qsTr(UnitsMeasurement.celsius.name)

            color: StyleConfigurator.theme.textAccentCollor
        }


        Image {
            id: levelLinkImage

            width:  Math.min(row.width*0.05,row.height)*0.6
            height: width
            anchors.right: numberOfSatellitesImage.left
            anchors.rightMargin: row.width*0.01
            anchors.verticalCenter: row.verticalCenter

            source                 : view.iconLevelLink

            ColorOverlay {
                anchors.fill: levelLinkImage
                source: levelLinkImage
                color: StyleConfigurator.theme.iconGeneralCollor
            }
        }
        Image {
            id: numberOfSatellitesImage

            width:  Math.min(row.width*0.05,row.height)*0.6
            height: width
            anchors.right: row.right
            anchors.rightMargin: row.width*0.01
            anchors.verticalCenter: row.verticalCenter

            source                 : view.iconNumberOfSatellities

            ColorOverlay {
                anchors.fill: numberOfSatellitesImage
                source: numberOfSatellitesImage
                color: view.valueNumberOfSatellities > 0 ?
                           StyleConfigurator.theme.iconGeneralCollor :
                           StyleConfigurator.theme.iconGeneralDisabledCollor
            }

            Text {
                id: valueNumberOfSatellitiesText

                height                 : row.height*0.5

                anchors.right: numberOfSatellitesImage.right
                anchors.rightMargin: -numberOfSatellitesImage.width*0.2
                anchors.top: numberOfSatellitesImage.top
                anchors.topMargin: -numberOfSatellitesImage.height*0.35

                wrapMode : Text.WrapAtWordBoundaryOrAnywhere
                minimumPixelSize: 1

                visible: view.valueNumberOfSatellities > 0

                font.pixelSize: Math.min(numberOfSatellitesImage.width,numberOfSatellitesImage.height)*0.6
                text                   : view.valueNumberOfSatellities
                color: StyleConfigurator.theme.textAccentCollor
            }
        }
    }
}
