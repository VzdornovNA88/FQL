/**
******************************************************************************
* @file             MediaPlayerWidgetStyle.qml
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
import FQL.Controls.Base 1.0
import FQL.Controls.Private 1.0

Style {
    id: mediaPlayerWidgetStyle

    property var colorBackground              : StyleConfigurator.theme.backgroundAccentCollor
    property var colorText                    : suitableColorText__ ?
                                                    suitableColorText__.itemColor.color :
                                                    StyleConfigurator.theme.textGeneralCollor
    property var colorVolumeSlider            : StyleConfigurator.theme.buttonAccentCollor
    property var colorPosTrackSlider          : StyleConfigurator.theme.buttonAccentCollor
    property var colorTickMarkRadioStation    : StyleConfigurator.theme.buttonAccentCollor
    property var colorTrackPanel              : ColorHelpers.addAlpha( 0.2,StyleConfigurator.theme.backgroundGeneral3Collor  )
    property var colorDisabled                : StyleConfigurator.theme.lighter50Collor
    property var colorVolumePanel             : ColorHelpers.addAlpha( 0.7,StyleConfigurator.theme.backgroundGeneral2Collor )

    readonly property var suitableColorText__ : ColorHelpers.suitableFor(control.colorBackground ?
                                                                             control.colorBackground :
                                                                             colorBackground)
    .in([ StyleConfigurator.theme.textSpecialLightCollor,
          StyleConfigurator.theme.textSpecialDarkCollor])[0]


    property Component panel: Rectangle {
        id : bg

        width               : control.width
        height              : control.height

        readonly property int currentIndexOfTrack__  : tracks.currentIndex
        property double currentNumStation__ : control.targetNumStation
        // Init
        Component.onCompleted: {
            var slot_;
            control.onMaximizedModeChanged.connect(function(){
                if( !control.maximizedMode )
                    bg.extended = false;
            });
            slot_ = function(){
                if( !control.audioPlayerMode )
                    fmMode.checked = true;
                else
                    audioMode.checked = true;
            };
            control.onAudioPlayerModeChanged.connect(slot_);
            slot_();

            control.onTargetTrackChanged.connect(function(){
                tracks.currentIndex = control.targetTrack;
            });
            control.onTargetNumStationChanged.connect(function(){
                bg.currentNumStation__ = control.targetNumStation;
            });

            tracks.changeCurrentIndex.connect(function(direction){
                if( !tracks ) return;
                if( direction === 1 && tracks.currentIndex < ((control.tracks && control.tracks.length > 0)? (control.tracks.length - 1) : 0))
                    tracks.currentIndex++;
                else
                    if( direction === -1 && tracks.currentIndex > 0 )
                        tracks.currentIndex--;
                tracks.positionViewAtIndex(tracks.currentIndex,ListView.Center);
                console.log("changeCurrentIndex - ",control,control.currentTrack,tracks.currentIndex,tracks.currentItem,direction);
            });
        }

        property bool extended : false

        color: control.colorBackground ? control.colorBackground : mediaPlayerWidgetStyle.colorBackground

        Rectangle {
            id : expandedBg

            anchors.bottom: bg.top
            anchors.right: bg.right

            color: bg.color
            visible: control.maximizedMode

            states:
                State {
                when: control.maximizedMode
                PropertyChanges { target: expandedBg; width: control.expandedWidth }
                PropertyChanges { target: expandedBg; height: control.expandedHeight }
                onCompleted: bg.extended = true;
            }


            transitions:
                Transition {
                PropertyAnimation { properties: "width,height"; easing.type: Easing.InOutCubic;duration: 500 }
            }

            Item{
                id: topButtons

                anchors.top: expandedBg.top

                width: expandedBg.width
                height: expandedBg.height*0.13

                visible: bg.extended

                ExclusiveGroup {
                    id: topButtonsGroup

                    Button {
                        id : fmMode

                        anchors.left: topButtonsGroup.left
                        anchors.top: topButtonsGroup.top

                        width: topButtons.width*0.25
                        height: topButtons.height*0.9

                        borderFocus: false
                        color: StyleConfigurator.theme.transparent
                        iconSource: "qrc:/FQL/Resources/Icons/Ui/Radio.svg"
                        iconColor: ColorHelpers
                        .suitableFor(bg.color)
                        .in([ StyleConfigurator.theme.iconGeneralCollor,
                              StyleConfigurator.theme.iconGeneralDisabledCollor,
                              StyleConfigurator.theme.iconAccentCollor,
                              StyleConfigurator.theme.iconInvertCollor  ])[0].itemColor.color
//                        color_text: mediaPlayerWidgetStyle.colorText
//                        text: "FM"
                        textKoeffPointSize: 2.5

                        checkable: true

                        exclusiveGroup: topButtonsGroup

                        onClicked: control.audioPlayerMode = false;
                    }

                    Button {
                        id : audioMode

                        anchors.left: fmMode.right
                        anchors.top: topButtonsGroup.top

                        width: topButtons.width*0.25
                        height: topButtons.height*0.9

                        borderFocus: false
                        color: StyleConfigurator.theme.transparent
                        iconSource: "qrc:/FQL/Resources/Icons/Ui/Multimedia.svg"
                        iconColor: ColorHelpers
                        .suitableFor(bg.color)
                        .in([ StyleConfigurator.theme.iconGeneralCollor,
                              StyleConfigurator.theme.iconGeneralDisabledCollor,
                              StyleConfigurator.theme.iconAccentCollor,
                              StyleConfigurator.theme.iconInvertCollor  ])[0].itemColor.color
//                        color_text: mediaPlayerWidgetStyle.colorText
//                        text: "Player"
                        textKoeffPointSize: 2.5

                        checkable: true

                        exclusiveGroup: topButtonsGroup

                        onClicked: control.audioPlayerMode = true;
                    }
                }

                Button {
                    id : squeezer

                    anchors.right: topButtons.right
                    anchors.verticalCenter: topButtons.verticalCenter

                    width: topButtons.width*0.25
                    height: topButtons.height*0.6

                    borderFocus: false
                    color: StyleConfigurator.theme.transparent
                    iconSource: "qrc:/FQL/Resources/Icons/Ui/arrow_down_inverse.svg"
                    iconColor: ColorHelpers
                    .suitableFor(bg.color)
                    .in([ StyleConfigurator.theme.iconGeneralCollor,
                          StyleConfigurator.theme.iconGeneralDisabledCollor,
                          StyleConfigurator.theme.iconAccentCollor,
                          StyleConfigurator.theme.iconInvertCollor  ])[0].itemColor.color

                    onClicked: {
                        control.maximizedMode = false;
                        bg.extended = false;
                    }
                }


            }

            Item {
                id: fmItem

                anchors.top: topButtons.bottom

                width: expandedBg.width
                height: expandedBg.height*0.9

                visible : !control.audioPlayerMode && bg.extended

                Item{
                    id: chart

                    anchors.top: fmItem.top
                    anchors.topMargin: expandedBg.height*0.07

                    width: fmItem.width
                    height: fmItem.height*0.4

                    Image {
                        id: iconRadioSignal

                        anchors.fill: chart

                        source: "qrc:/FQL/Resources/Icons/Ui/radio_signal.svg"

                        ColorOverlay {
                            id                 : overlay
                            anchors.fill       : iconRadioSignal
                            source             : iconRadioSignal
                            color              : StyleConfigurator.theme.iconAccent1Collor
                        }
                    }
                }
                Item{
                    id: title

                    anchors.verticalCenter: chart.verticalCenter

                    width: fmItem.width
                    height: fmItem.height*0.4

                    Text {
                        id: textTitleStation

                        height                 : title.height*0.5

                        anchors.horizontalCenter: title.horizontalCenter
                        anchors.top: title.top

                        wrapMode : Text.WrapAtWordBoundaryOrAnywhere
                        minimumPixelSize: 1

                        font.pixelSize: Math.min(title.width*0.5,title.height)*0.45
                        text : control.appliedCurrentNumStation.toFixed(2).toString()
                        color: mediaPlayerWidgetStyle.colorText
                    }
                    Text {
                        id: unitMesOfTitle

                        height                 : title.height*0.5

                        anchors.horizontalCenter: title.horizontalCenter
                        anchors.top: textTitleStation.bottom

                        text: qsTr(UnitsMeasurement.megaHz.name)

                        wrapMode : Text.WrapAtWordBoundaryOrAnywhere
                        minimumPixelSize: 1
                        font.pixelSize: Math.min(title.width*0.5,title.height)*0.35

                        color: mediaPlayerWidgetStyle.colorText
                    }
                }
                Item{
                    id: settingWheel

                    anchors.top: title.bottom
                    anchors.topMargin: expandedBg.height*0.1

                    width: fmItem.width
                    height: fmItem.height*0.2

                    Image {
                        id: iconSettingWheel

                        anchors.fill: settingWheel

                        source: "qrc:/FQL/Resources/Icons/Ui/media_player_wheel.svg"

                        ColorOverlay {
                                anchors.fill: iconSettingWheel
                                source: iconSettingWheel
                                color: ColorHelpers
                                .suitableFor(bg.color)
                                .in([ StyleConfigurator.theme.iconGeneralCollor,
                                      StyleConfigurator.theme.iconGeneralDisabledCollor,
                                      StyleConfigurator.theme.iconAccentCollor,
                                      StyleConfigurator.theme.iconInvertCollor  ])[0].itemColor.color
                            }
                    }

                    SequentialAnimation on x {
                        id: scroolAnimation
                        PropertyAnimation { to: settingWheel.width*0.15 }
                        PropertyAnimation { to: 0 }
                    }

                    MouseArea {
                        id : scroolArea

                        anchors.fill: settingWheel

                        property double startPoint : 0
                        property double endPoint : 0

                        property double minVal : 0.01
                        property double maxVal : 10.0

                        function setCurrentStation (val) {

                            var direction = val < 0 ? -1 : 1;
                            if (Math.abs(val) < minVal) val = minVal*direction;
                            else
                                if (Math.abs(val) > maxVal) val = maxVal*direction;

                            bg.currentNumStation__ += val;

                            if( bg.currentNumStation__ < control.minNumberOfRadioStation ) bg.currentNumStation__ = control.minNumberOfRadioStation;
                            else
                                if( bg.currentNumStation__> control.maxNumberOfRadioStation ) bg.currentNumStation__ = control.maxNumberOfRadioStation;
                        }

                        onPositionChanged: scroolAnimation.running = true;
                        onPressed: startPoint = mouseX;
                        onReleased: {

                            endPoint = mouseX;

                            setCurrentStation((startPoint - endPoint)/settingWheel.width);

                            startPoint = 0;
                            endPoint = 0;

                            scroolAnimation.running = false;
                        }
                    }
                }

                Rectangle {
                    id: tickMarkRadioStation

                    width: settingWheel.width*0.01
                    height: settingWheel.height

                    anchors.top: title.bottom
                    anchors.horizontalCenter: title.horizontalCenter
                    anchors.topMargin: expandedBg.height*0.1

                    color: mediaPlayerWidgetStyle.colorTickMarkRadioStation
                }

                Item{
                    id: bottomButtons

                    anchors.top: settingWheel.bottom
                    anchors.topMargin: -expandedBg.height*0.18

                    width: fmItem.width
                    height: fmItem.height*0.2

                    Text {
                        id: lastStationText

                        height                 : bottomButtons.height

                        anchors.left: bottomButtons.left
                        anchors.leftMargin: bottomButtons.width*0.07
                        anchors.top: bottomButtons.bottom

                        property double lastStation : /*((bg.currentNumStation__ - 3) >= */control.minNumberOfRadioStation /*? (bg.currentNumStation__ - 3) : control.minNumberOfRadioStation)*/
                        text: lastStation.toFixed(2).toString()

                        wrapMode : Text.WrapAtWordBoundaryOrAnywhere
                        minimumPixelSize: 1
                        font.pixelSize: Math.min(bottomButtons.width*0.2,bottomButtons.height)*0.3

                        color: mediaPlayerWidgetStyle.colorText
                    }

                    Button {
                        id : currentStationText

                        anchors.horizontalCenter: bottomButtons.horizontalCenter
                        anchors.verticalCenter: lastStationText.verticalCenter
                        anchors.verticalCenterOffset: -bottomButtons.height*0.15

                        width: bottomButtons.width*0.38
                        height: bottomButtons.height*0.85

                        borderFocus: false
                        color: StyleConfigurator.theme.backgroundAccent1Collor
                        color_text: mediaPlayerWidgetStyle.colorText

                        text: bg.currentNumStation__.toFixed(2).toString()
                        textKoeffPointSize: 2.0

                        onClicked: control.appliedCurrentNumStation = bg.currentNumStation__;
                    }

                    Text {
                        id: nextStationText

                        height                 : bottomButtons.height

                        anchors.right: bottomButtons.right
                        anchors.rightMargin: bottomButtons.width*0.07
                        anchors.top: bottomButtons.bottom

                        property double nextStation : /*((bg.currentNumStation__ + 3) <= */control.maxNumberOfRadioStation /*? (bg.currentNumStation__ + 3) : control.maxNumberOfRadioStation)*/
                        text: nextStation.toFixed(2).toString()

                        wrapMode : Text.WrapAtWordBoundaryOrAnywhere
                        minimumPixelSize: 1
                        font.pixelSize: Math.min(bottomButtons.width*0.2,bottomButtons.height)*0.3

                        color: mediaPlayerWidgetStyle.colorText
                    }
                }
            }

            Item {
                id: audioItem

                anchors.top: topButtons.bottom

                width: expandedBg.width
                height: expandedBg.height*0.9

                visible : control.audioPlayerMode && bg.extended

                ListView {
                    id : tracks

                    anchors.top: audioItem.top
                    anchors.horizontalCenter: audioItem.horizontalCenter

                    width: audioItem.width*0.8
                    height: audioItem.height*0.7

                    orientation: ListView.Horizontal
//                    snapMode: ListView.SnapOneItem
                    spacing: 10

                    model: control.tracks ? control.tracks : []

                    signal changeCurrentIndex( int direction );
                    property double contentX_ : 0

                    currentIndex: control.targetTrack

                    onDragStarted: {
                        contentX_ = contentX;
                    }

                    onDragEnded:  {

                        var diff = Math.abs(contentX - contentX_) > tracks.width*0.1 ? 1 : 0;
                        changeCurrentIndex(( contentX < contentX_ ? -1 : 1) * diff);
                    }

                    delegate: Rectangle {
                        id: delegateTrack

                        width: tracks.width
                        height: tracks.height

                        radius: 10

                        color: mediaPlayerWidgetStyle.colorTrackPanel

                        Image {
                            id: iconTrack

                            width: delegateTrack.width
                            height: delegateTrack.height*0.68
                            sourceSize.width: delegateTrack.width
                            sourceSize.height: delegateTrack.height*0.68

                            source: modelData.icon ? modelData.icon :
                                                     "qrc:/FQL/Resources/Icons/Ui/audio_file.svg"

                            ColorOverlay {
                                    anchors.fill: iconTrack
                                    source: iconTrack
                                    color: StyleConfigurator.theme.iconInvertCollor
                                }
                        }

                        Text {
                            id: titleText

                            width: delegateTrack.width*0.9
                            height                 : delegateTrack.height*0.15

                            anchors.horizontalCenter: delegateTrack.horizontalCenter
                            anchors.top: iconTrack.bottom
                            anchors.bottom: delegateTrack.bottom

                            wrapMode : Text.WrapAtWordBoundaryOrAnywhere
                            minimumPixelSize: 1

                            font.pixelSize: Math.min(delegateTrack.width*0.7,delegateTrack.height)*0.13
                            text                   : modelData.title
                            color: mediaPlayerWidgetStyle.colorText
                        }
                    }
                }

                Slider {
                    id: positionInTrackSlider

                    anchors.top: tracks.bottom
                    anchors.topMargin: audioItem.height*0.1
                    anchors.horizontalCenter: audioItem.horizontalCenter

                    width: audioItem.width*0.8
                    height: audioItem.height*0.07

                    stepSize: 0.01
                    minimumValue: 0
                    maximumValue: (control.tracks && control.tracks.length > 0) ? ((( control.currentTrack <= control.tracks.length - 1 || control.currentTrack >= 0 ) ?
                                       control.tracks[control.currentTrack].duration : 0)) : 0

                    onMaximumValueChanged: {
                        if( control.positionInTrack > positionInTrackSlider.maximumValue ) {
                            control.positionInTrack = positionInTrackSlider.maximumValue;
                        }
                    }

                    color: mediaPlayerWidgetStyle.colorVolumeSlider

                    handle: Rectangle {
                        id: backHandle
                        width:  height
                        height: positionInTrackSlider.height

                        radius: width/2

                        color: StyleConfigurator.theme.transparent
                        border.width: 0

                        Rectangle {
                            id: handle
                            width: backHandle.width - 6
                            height: backHandle.height - 6
                            anchors.verticalCenter: backHandle.verticalCenter
                            anchors.horizontalCenter: backHandle.horizontalCenter

                            radius: width/2
                            color: mediaPlayerWidgetStyle.colorVolumeSlider

                        }

                        Rectangle {
                            id: disablerHandle

                            anchors.centerIn: handle

                            width: handle.width
                            height: handle.height

                            radius: width/2

                            color : positionInTrackSlider.enabled ?
                                        StyleConfigurator.theme.transparent :
                                        mediaPlayerWidgetStyle.colorDisabled
                        }
                    }

                    value: control.positionInTrack
                    onValueSetPointChanged: control.positionInTrack = valueSetPoint;
                }

                Item {
                    id : itemTrackDurationTexts

                    width: positionInTrackSlider.width
                    height: audioItem.height*0.2

                    anchors.top: positionInTrackSlider.bottom
                    anchors.topMargin: audioItem.height*0.01
                    anchors.horizontalCenter: audioItem.horizontalCenter
                    anchors.horizontalCenterOffset: -itemTrackDurationTexts.width*0.03

                    Text {
                        id: startPointTime

                        height                 : itemTrackDurationTexts.height

                        anchors.left: itemTrackDurationTexts.left
                        anchors.top: itemTrackDurationTexts.top

                        wrapMode : Text.WrapAtWordBoundaryOrAnywhere
                        minimumPixelSize: 1

                        font.pixelSize: Math.min(itemTrackDurationTexts.width,itemTrackDurationTexts.height)*0.27
                        text                   : control.positionInTrack.toFixed(2).toString()
                        color: mediaPlayerWidgetStyle.colorText
                    }

                    Text {
                        id: endPointTime

                        height                 : itemTrackDurationTexts.height

                        anchors.horizontalCenter: itemTrackDurationTexts.right
                        anchors.top: itemTrackDurationTexts.top

                        wrapMode : Text.WrapAtWordBoundaryOrAnywhere
                        minimumPixelSize: 1

                        font.pixelSize: Math.min(itemTrackDurationTexts.width,itemTrackDurationTexts.height)*0.27
                        text                   : (control.tracks && control.tracks.length > 0) ? ((( control.currentTrack <= control.tracks.length - 1 || control.currentTrack >= 0 ) ?
                                                      control.tracks[control.currentTrack].duration : 0).toFixed(2).toString()) : 0
                        color: mediaPlayerWidgetStyle.colorText
                    }
                }


            }


        }

        Item {
            id: itemBg

            width : bg.width
            height: bg.height

            anchors.right: bg.right

            //            Row {
            //                id: rowBg
            ////                spacing: itemBg.width*0.05

            Button {
                id : last

                width: itemBg.width*0.225
                height: itemBg.height

                anchors.verticalCenter: itemBg.verticalCenter
                anchors.right: play.left
                anchors.rightMargin: itemBg.width*0.03

                borderFocus: false
                color: StyleConfigurator.theme.transparent
                iconSource: "qrc:/FQL/Resources/Icons/Ui/left_inverse.svg"
                iconColor: ColorHelpers
                .suitableFor(bg.color)
                .in([ StyleConfigurator.theme.iconGeneralCollor,
                      StyleConfigurator.theme.iconGeneralDisabledCollor,
                      StyleConfigurator.theme.iconAccentCollor,
                      StyleConfigurator.theme.iconInvertCollor  ])[0].itemColor.color

                onClicked: {
                    control.last();
                    if( control.audioPlayerMode )
                        tracks.changeCurrentIndex(-1);
                }
            }

            Button {
                id : play

                width: itemBg.width*0.225
                height: itemBg.height

                anchors.verticalCenter: itemBg.verticalCenter
                anchors.right: next.left
                anchors.rightMargin: itemBg.width*0.03

                borderFocus: false
                color: StyleConfigurator.theme.transparent
                iconSource: checked ? "qrc:/FQL/Resources/Icons/Ui/pause.svg" : "qrc:/FQL/Resources/Icons/Ui/play.svg"
                iconColor: StyleConfigurator.theme.iconAccent1Collor

                checkable: true
                checked: control.playing

                onCheckedChanged: {
                    control.playing = checked;
                    control.play( control.playing );
                }
            }

            Button {
                id : next

                width: itemBg.width*0.225
                height: itemBg.height

                anchors.verticalCenter: itemBg.verticalCenter
                anchors.right: volumeBtn.left
                anchors.rightMargin: itemBg.width*0.03

                borderFocus: false
                color: StyleConfigurator.theme.transparent
                iconSource: "qrc:/FQL/Resources/Icons/Ui/right_inverse.svg"
                iconColor: ColorHelpers
                .suitableFor(bg.color)
                .in([ StyleConfigurator.theme.iconGeneralCollor,
                      StyleConfigurator.theme.iconGeneralDisabledCollor,
                      StyleConfigurator.theme.iconAccentCollor,
                      StyleConfigurator.theme.iconInvertCollor  ])[0].itemColor.color

                onClicked: {

                    control.next();
                    if( control.audioPlayerMode )
                        tracks.changeCurrentIndex(1);
                }
            }

            Button {
                id : volumeBtn

                width: itemBg.width*0.225
                height: itemBg.height

                anchors.verticalCenter: itemBg.verticalCenter
                anchors.right: itemBg.right
                anchors.rightMargin: itemBg.width*0.03

                borderFocus: false
                color: StyleConfigurator.theme.transparent
                iconSource: "qrc:/FQL/Resources/Icons/Ui/volume_inverse.svg"
                iconColor: ColorHelpers
                .suitableFor(bg.color)
                .in([ StyleConfigurator.theme.iconGeneralCollor,
                      StyleConfigurator.theme.iconGeneralDisabledCollor,
                      StyleConfigurator.theme.iconAccentCollor,
                      StyleConfigurator.theme.iconInvertCollor  ])[0].itemColor.color

                checkable: true

                Rectangle {
                    id: volumePanel

                    width: volumeBtn.width*1
                    height: control.expandedHeight*0.8
                    radius: 5

                    anchors.bottom: volumeBtn.top
                    anchors.bottomMargin: volumeBtn.height*0.9
                    anchors.horizontalCenter: volumeBtn.horizontalCenter

                    color: mediaPlayerWidgetStyle.colorVolumePanel

                    visible: volumeBtn.checked

                    Slider {
                        id: volumeSlider

                        anchors.horizontalCenter: volumePanel.horizontalCenter
                        anchors.bottom: volumeDisable.top
                        anchors.bottomMargin: volumePanel.height*0.05

                        width: volumePanel.width*0.45
                        height: volumePanel.height*0.7

                        color: mediaPlayerWidgetStyle.colorVolumeSlider
                        backgroundColor: StyleConfigurator.theme.transparent
                        borderWidth:2

                        maximumValue: 100
                        stepSize: 1
                        enabled: control.volumeEnabled

                        value: control.volume

                        onValueSetPointChanged: control.volume = valueSetPoint

                        orientation: Qt.Vertical

                        handle: Rectangle {
                            id: backHandle1
                            width:  height
                            height: volumeSlider.width*0.8
                            y: volumeSlider.width*0.1

                            radius: width/2

                            color: StyleConfigurator.theme.transparent
                            border.width: volumeSlider.borderWidth

                            Rectangle {
                                id: handle1
                                width: backHandle1.width - 2
                                height: backHandle1.height - 2
                                anchors.verticalCenter: backHandle1.verticalCenter
                                anchors.horizontalCenter: backHandle1.horizontalCenter

                                radius: width/2
                                color: mediaPlayerWidgetStyle.colorPosTrackSlider

                            }

                            Rectangle {
                                id: disablerHandle1

                                anchors.centerIn: handle1

                                width: handle1.width
                                height: handle1.height

                                radius: width/2

                                color : volumeSlider.enabled ?
                                            StyleConfigurator.theme.transparent :
                                            mediaPlayerWidgetStyle.colorDisabled
                            }
                        }
                    }

                    Button {
                        id : volumeDisable

                        width: Math.min( volumePanel.height,volumePanel.width )
                        height: width

                        anchors.bottom: volumePanel.bottom
                        anchors.bottomMargin: volumePanel.height*0.025
                        anchors.horizontalCenter: volumePanel.horizontalCenter

                        borderFocus: false
                        color: StyleConfigurator.theme.transparent
                        iconSource: !checked ? "qrc:/FQL/Resources/Icons/Ui/volume-2.svg" :
                                               "qrc:/FQL/Resources/Icons/Ui/volume off.svg"

                        checkable: true

                        checked: !control.volumeEnabled

                        onCheckedChanged: control.volumeEnabled = !checked
                    }

                }
            }
            //            }
        }

        Button {
            id : expanderMediaPlayer

            width: control.expandedWidth*0.25
            height: control.expandedHeight*0.13*0.6

            anchors.bottom: itemBg.top
            anchors.right: itemBg.right

            borderFocus: false
            color: control.expanderButtonColor ? control.expanderButtonColor : bg.color
            iconSource: /*!control.maximizedMode ? */"qrc:/FQL/Resources/Icons/Ui/up_inverse.svg" /*:*/
                                                 /*"qrc:/FQL/Resources/Icons/Ui/arrow_down_inverse.svg"*/
            iconColor: ColorHelpers
            .suitableFor(bg.color)
            .in([ StyleConfigurator.theme.iconGeneralCollor,
                  StyleConfigurator.theme.iconGeneralDisabledCollor,
                  StyleConfigurator.theme.iconAccentCollor,
                  StyleConfigurator.theme.iconInvertCollor  ])[0].itemColor.color

            visible: !bg.extended

            onClicked: {
                control.maximizedMode = true/*!control.maximizedMode*/;
//                if( !control.maximizedMode )
//                    bg.extended = false;
            }
        }
    }
}
