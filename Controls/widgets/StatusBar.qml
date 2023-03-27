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

import "../"
import "../../Controls" as FQL
import "../../Resources/Colors"
import "../../Core"
import "../../Core/ColorHelpers.js" as ColorHelpers

ContentItem {
    id: view

    clickable   : true
    checkable   : false
    activatable : false
    borderFocus : false
    contentUnder: false
    color: MaterialColors.transparent

    property var          iconAccount      : ""
    property var          colorText        : MaterialColors.grey700
    property string       machineName      : "RSM F 2x50"
    property var          iconNotificationMachine : ""
    property var          iconNotificationEngine : ""
    property var          iconLevelLink    : ""
    property var          iconNumberOfSatellities    : ""
    property int          valueNumberOfSatellities : 3
    property var          colorSpaceNotificationMachine : MaterialColors.amber600
    property var          colorSpaceNotificationEngine : MaterialColors.red600
    property var          valueTemperOutside : -17
    property string       date : ""
    property string       time : ""
    property int          valueNumberOfNotificationsMachine : 7
    property int          valueNumberOfNotificationsEngine : 25


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
            color: view.colorText
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
            color: view.colorText
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
            text                   : view.machineName
            color: view.colorText
        }


        Item {
            id: recNotificationMachineImageParent

            width:  Math.min(row.width*0.05,row.height)
            height: width

            anchors.right: recNotificationEngineImageParent.left
            anchors.rightMargin: row.width*0.015
            anchors.verticalCenter: row.verticalCenter

        Rectangle {
            id: recNotificationMachineImage

            width:  recNotificationMachineImageParent.width*0.85
            height: width

            anchors.centerIn: recNotificationMachineImageParent

            radius: width/2
            clip: view.colorSpaceNotificationMachine

            color : view.colorSpaceNotificationMachine

        Image {
            id: notificationMachineImage

            width:  recNotificationMachineImage.width*0.7
            height: width

            anchors.centerIn: recNotificationMachineImage

            source                 : view.iconNotificationMachine
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
            color: view.colorText
        }
        }

        Item {
            id: recNotificationEngineImageParent

            width:  Math.min(row.width*0.05,row.height)
            height: width

            anchors.right: temperOutsideText.left
            anchors.rightMargin: row.width*0.035
            anchors.verticalCenter: row.verticalCenter

        Rectangle {
            id: recNotificationEngineImage

            width:  recNotificationEngineImageParent.width*0.85
            height: width

            anchors.centerIn: recNotificationEngineImageParent

            radius: width/2
            clip: view.colorSpaceNotificationEngine

            color: view.colorSpaceNotificationEngine

        Image {
            id: notificationEngineImage

            width:  recNotificationMachineImage.width*0.7
            height: width

            anchors.centerIn: recNotificationEngineImage

            source                 : view.iconNotificationEngine
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
            color: view.colorText
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

            font.pixelSize: Math.min(row.width*0.08,row.height)*0.6
            text                   : view.valueTemperOutside + qsTr(UnitsMeasurement.celsius.name)
            color: view.colorText
        }


        Image {
            id: levelLinkImage

            width:  Math.min(row.width*0.05,row.height)*0.6
            height: width
            anchors.right: numberOfSatellitesImage.left
            anchors.rightMargin: row.width*0.01
            anchors.verticalCenter: row.verticalCenter

            source                 : view.iconLevelLink
        }
        Image {
            id: numberOfSatellitesImage

            width:  Math.min(row.width*0.05,row.height)*0.6
            height: width
            anchors.right: row.right
            anchors.rightMargin: row.width*0.01
            anchors.verticalCenter: row.verticalCenter

            source                 : view.iconNumberOfSatellities


            Text {
                id: valueNumberOfSatellitiesText

                height                 : row.height*0.5

                anchors.right: numberOfSatellitesImage.right
                anchors.rightMargin: -numberOfSatellitesImage.width*0.2
                anchors.top: numberOfSatellitesImage.top
                anchors.topMargin: -numberOfSatellitesImage.height*0.35

                wrapMode : Text.WrapAtWordBoundaryOrAnywhere
                minimumPixelSize: 1

                font.pixelSize: Math.min(numberOfSatellitesImage.width,numberOfSatellitesImage.height)*0.6
                text                   : view.valueNumberOfSatellities
                color: view.colorText
            }
        }
    }
}
