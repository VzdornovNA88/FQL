  /**
  ******************************************************************************
  * @file             Dark.qml
  * @brief            The set of constants of themes(name) 
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

import FQL.Resources.Colors 1.0
import FQL.Core.Meta 1.0
import FQL.Core.Base 1.0

QtObject {
    id: theme

    readonly
    property var transparent: MaterialColors.transparent

    readonly
    property var darker20Collor: ColorHelpers.addAlpha( 0.2,MaterialColors.grey900 )
    readonly
    property var darker50Collor: ColorHelpers.addAlpha( 0.5,MaterialColors.grey900 )
    readonly
    property var darker80Collor: ColorHelpers.addAlpha( 0.8,MaterialColors.grey900 )
    readonly
    property var darker40Collor: ColorHelpers.addAlpha( 0.4,MaterialColors.grey900 )
    readonly
    property var lighter20Collor: ColorHelpers.addAlpha( 0.2,MaterialColors.grey50 )
    readonly
    property var lighter50Collor: ColorHelpers.addAlpha( 0.5,MaterialColors.grey50 )

    readonly
    property var iconGeneralCollor: MaterialColors.grey100
    readonly
    property var iconGeneralDisabledCollor: lighter50Collor
    readonly
    property var iconAccentCollor: MaterialColors.grey50
    readonly
    property var iconAccent1Collor: MaterialColors.pink500
    readonly
    property var iconInvertCollor: MaterialColors.grey900

    readonly
    property var backgroundAccentCollor: MaterialColors.grey50
    readonly
    property var backgroundAccent1Collor: MaterialColors.grey200
    readonly
    property var backgroundGeneral1Collor: MaterialColors.grey400
    readonly
    property var backgroundGeneral2Collor: MaterialColors.grey500
    readonly
    property var backgroundGeneral3Collor: MaterialColors.grey600
    readonly
    property var backgroundGeneral4Collor: MaterialColors.grey900

    readonly
    property var backgroundSpecialLightCollor: MaterialColors.grey50
    readonly
    property var backgroundSpecialDarkCollor: MaterialColors.grey800
    readonly
    property var backgroundSpecialDark1Collor: MaterialColors.grey600
    readonly
    property var backgroundSpecialToolBarCollor: backgroundSpecialDarkCollor

    readonly
    property var borderAccentCollor: MaterialColors.grey50
    readonly
    property var borderAccent2Collor: MaterialColors.pink500
    readonly
    property var borderGeneralCollor: MaterialColors.grey200
    readonly
    property var borderGeneral2Collor: MaterialColors.grey400

    readonly
    property var textAccentCollor: MaterialColors.grey50
    readonly
    property var textGeneralCollor: MaterialColors.grey100
    readonly
    property var textGeneral2Collor: MaterialColors.grey400
    readonly
    property var textInvertCollor: MaterialColors.grey900
    readonly
    property var textSpecialLightCollor: MaterialColors.grey50
    readonly
    property var textSpecialDarkCollor: MaterialColors.grey900

    readonly
    property var valueAccentCollor: textAccentCollor
    readonly
    property var valueGeneralCollor: textGeneralCollor

    readonly
    property var unitMessureAccentCollor: textAccentCollor
    readonly
    property var unitMessureGeneralCollor: textGeneralCollor

    readonly
    property var buttonGeneralCollor: MaterialColors.grey100
    readonly
    property var buttonAccentCollor: MaterialColors.pink500
    readonly
    property var buttonActivatedCollor: MaterialColors.red200
    readonly
    property var buttonDisabledCollor: lighter50Collor
    readonly
    property var buttonPressedCollor: darker40Collor
    readonly
    property var buttonPressedInvertCollor: lighter20Collor

    readonly
    property var systemAccentActiveCollor: MaterialColors.blue700
    readonly
    property var systemGeneralActive1Collor: MaterialColors.blue500
    readonly
    property var systemGeneralActive2Collor: MaterialColors.blue300

    readonly
    property var systemAccnetSuccessActiveDarkCollor: MaterialColors.green900
    readonly
    property var systemAccnetSuccessActiveCollor: MaterialColors.green700
    readonly
    property var systemGeneralSuccessActive1Collor: MaterialColors.green500
    readonly
    property var systemGeneralSuccessActive2Collor: MaterialColors.green300

    readonly
    property var systemAccnetWornActiveCollor: MaterialColors.amber700
    readonly
    property var systemGeneralWornActive1Collor: MaterialColors.amber500
    readonly
    property var systemGeneralWornActive2Collor: MaterialColors.amber300

    readonly
    property var systemAccnetErrorActiveCollor: MaterialColors.red700
    readonly
    property var systemGeneralErrorActive1Collor: MaterialColors.red500
    readonly
    property var systemGeneralErrorActive2Collor: MaterialColors.red300

    readonly
    property var systemAccnetNotActiveCollor: MaterialColors.grey700
    readonly
    property var systemGeneralNotActive1Collor: MaterialColors.grey500
    readonly
    property var systemGeneralNotActive2Collor: MaterialColors.grey200

    readonly
    property var sliderAccentCollor: MaterialColors.pink500
    readonly
    property var sliderGeneralCollor: MaterialColors.green500

    readonly
    property var sliderHandleAccentCollor: MaterialColors.pink500
    readonly
    property var sliderHandleGeneralCollor: MaterialColors.grey900
}
