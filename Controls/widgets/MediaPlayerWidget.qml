/**
******************************************************************************
* @file             MediaPlayerWidget.qml
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

import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0

import "../"
import "../../Controls" as FQL
import "../../Resources/Colors"
import "../../Core"

Control {
    id: mediaPlayerWidget

    signal           last
    signal           play(bool state)
    signal           next

    property bool    maximizedMode              : false
    property bool    audioPlayerMode            : false
    property double  expandedWidth              : width
    property double  expandedHeight             : height*8
    property double  volume                     : 0
    property bool    volumeEnabled              : true
    property bool    playing                    : false


    property var     tracks                     : [
                                                    {title : "track1track1track1track1track1track1" , icon : "" ,duration : 1.52} ,
                                                    {title : "track2track2track2" , icon : "" ,duration : 3.52} ,
                                                    {title : "track3" , icon : "" ,duration : 4.52}
                                                  ]
    property int     currentTrack               : 0
    property double  positionInTrack            : 0

    property var     colorBackground

    property double  minNumberOfRadioStation    : 87.5
    property double  maxNumberOfRadioStation    : 108.0
    property double  radioSignal                : 0
    property double  currentNumStation          : minNumberOfRadioStation
    property double  appliedCurrentNumStation   : minNumberOfRadioStation

    style                                       : StyleConfigurator.getStyleCurrentByNameControl( "MediaPlayerWidget" )
}
