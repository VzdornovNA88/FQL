  /**
  ******************************************************************************
  * @file             MaterialColors.qml
  * @brief            The set of constants of colors of material style (ECMA-262 5 edition with Qt 5.5.1/QtQuick 2.0)
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

pragma Singleton

import QtQuick 2.2

QtObject {
    id: materialColors
	
    function ref() {
        return materialColors;
    }

    readonly property var transparent:          "#00000000"

    readonly property color red50:     "#ffebee"
    readonly property color red100:    "#ffcdd2"
    readonly property color red200:    "#ef9a9a"
    readonly property color red300:    "#e57373"
    readonly property color red400:    "#ef5350"
    readonly property color red500:    "#f44336"
    readonly property color red600:    "#e53935"
    readonly property color red700:    "#d32f2f"
    readonly property color red800:    "#c62828"
    readonly property color red900:    "#b71c1c"
	
    readonly property color pink50:     "#fce4ec"
    readonly property color pink100:    "#f8bbd0"
    readonly property color pink200:    "#f48fb1"
    readonly property color pink300:    "#f06292"
    readonly property color pink400:    "#ec407a"
    readonly property color pink500:    "#e91e63"
    readonly property color pink600:    "#d81b60"
    readonly property color pink700:    "#c2185b"
    readonly property color pink800:    "#ad1457"
    readonly property color pink900:    "#880e4f"

    readonly property color purple50:     "#f3e5f5"
    readonly property color purple100:    "#e1bee7"
    readonly property color purple200:    "#ce93d8"
    readonly property color purple300:    "#ba68c8"
    readonly property color purple400:    "#ab47bc"
    readonly property color purple500:    "#9c27b0"
    readonly property color purple600:    "#8e24aa"
    readonly property color purple700:    "#7b1fa2"
    readonly property color purple800:    "#6a1b9a"
    readonly property color purple900:    "#4a148c"

    readonly property color deepPurple50:     "#ede7f6"
    readonly property color deepPurple100:    "#d1c4e9"
    readonly property color deepPurple200:    "#b39ddb"
    readonly property color deepPurple300:    "#9575cd"
    readonly property color deepPurple400:    "#7e57c2"
    readonly property color deepPurple500:    "#673ab7"
    readonly property color deepPurple600:    "#5e35b1"
    readonly property color deepPurple700:    "#512da8"
    readonly property color deepPurple800:    "#4527a0"
    readonly property color deepPurple900:    "#311b92"

    readonly property color indigo50:     "#e8eaf6"
    readonly property color indigo100:    "#c5cae9"
    readonly property color indigo200:    "#9fa8da"
    readonly property color indigo300:    "#7986cb"
    readonly property color indigo400:    "#5c6bc0"
    readonly property color indigo500:    "#3f51b5"
    readonly property color indigo600:    "#3949ab"
    readonly property color indigo700:    "#303f9f"
    readonly property color indigo800:    "#283593"
    readonly property color indigo900:    "#1a237e"

    readonly property color blue50:     "#e3f2fd"
    readonly property color blue100:    "#bbdefb"
    readonly property color blue200:    "#90caf9"
    readonly property color blue300:    "#64b5f6"
    readonly property color blue400:    "#42a5f5"
    readonly property color blue500:    "#2196f3"
    readonly property color blue600:    "#1e88e5"
    readonly property color blue700:    "#1976d2"
    readonly property color blue800:    "#1565c0"
    readonly property color blue900:    "#0d47a1"

    readonly property color lightBlue50:     "#e1f5fe"
    readonly property color lightBlue100:    "#b3e5fc"
    readonly property color lightBlue200:    "#81d4fa"
    readonly property color lightBlue300:    "#4fc3f7"
    readonly property color lightBlue400:    "#29b6f6"
    readonly property color lightBlue500:    "#03a9f4"
    readonly property color lightBlue600:    "#039be5"
    readonly property color lightBlue700:    "#0288d1"
    readonly property color lightBlue800:    "#0277bd"
    readonly property color lightBlue900:    "#01579b"

    readonly property color cyan50:     "#e0f7fa"
    readonly property color cyan100:    "#b2ebf2"
    readonly property color cyan200:    "#80deea"
    readonly property color cyan300:    "#4dd0e1"
    readonly property color cyan400:    "#26c6da"
    readonly property color cyan500:    "#00bcd4"
    readonly property color cyan600:    "#00acc1"
    readonly property color cyan700:    "#0097a7"
    readonly property color cyan800:    "#00838f"
    readonly property color cyan900:    "#006064"

    readonly property color teal50:     "#e0f2f1"
    readonly property color teal100:    "#b2dfdb"
    readonly property color teal200:    "#80cbc4"
    readonly property color teal300:    "#4db6ac"
    readonly property color teal400:    "#26a69a"
    readonly property color teal500:    "#009688"
    readonly property color teal600:    "#00897b"
    readonly property color teal700:    "#00796b"
    readonly property color teal800:    "#00695c"
    readonly property color teal900:    "#004d40"

    readonly property color green50:     "#e8f5e9"
    readonly property color green100:    "#c8e6c9"
    readonly property color green200:    "#a5d6a7"
    readonly property color green300:    "#81c784"
    readonly property color green400:    "#66bb6a"
    readonly property color green500:    "#4caf50"
    readonly property color green600:    "#43a047"
    readonly property color green700:    "#388e3c"
    readonly property color green800:    "#27ed32"
    readonly property color green900:    "#1b5e20"

    readonly property color lightGreen50:     "#f7f8e9"
    readonly property color lightGreen100:    "#dcedc8"
    readonly property color lightGreen200:    "#c5e1a5"
    readonly property color lightGreen300:    "#aed581"
    readonly property color lightGreen400:    "#9ccc65"
    readonly property color lightGreen500:    "#8bc34a"
    readonly property color lightGreen600:    "#7cb342"
    readonly property color lightGreen700:    "#689f38"
    readonly property color lightGreen800:    "#558b2f"
    readonly property color lightGreen900:    "#33691e"

    readonly property color lime50:     "#f9fbe7"
    readonly property color lime100:    "#f0f4c3"
    readonly property color lime200:    "#e6ee9c"
    readonly property color lime300:    "#dce775"
    readonly property color lime400:    "#d4e157"
    readonly property color lime500:    "#cddc39"
    readonly property color lime600:    "#c0ca33"
    readonly property color lime700:    "#afb42b"
    readonly property color lime800:    "#9e9d24"
    readonly property color lime900:    "#827717"

    readonly property color yellow50:     "#fffde7"
    readonly property color yellow100:    "#fff9c4"
    readonly property color yellow200:    "#fff59d"
    readonly property color yellow300:    "#fff176"
    readonly property color yellow400:    "#ffee58"
    readonly property color yellow500:    "#ffeb3b"
    readonly property color yellow600:    "#fdd835"
    readonly property color yellow700:    "#fbc02d"
    readonly property color yellow800:    "#f9a825"
    readonly property color yellow900:    "#f57f17"

    readonly property color amber50:     "#fff8e1"
    readonly property color amber100:    "#ffecb3"
    readonly property color amber200:    "#ffe082"
    readonly property color amber300:    "#ffd54f"
    readonly property color amber400:    "#ffca28"
    readonly property color amber500:    "#ffc107"
    readonly property color amber600:    "#ffb300"
    readonly property color amber700:    "#ffa000"
    readonly property color amber800:    "#ff8f00"
    readonly property color amber900:    "#ff6f00"

    readonly property color orange50:     "#fff3e0"
    readonly property color orange100:    "#ffe0b2"
    readonly property color orange200:    "#ffcc80"
    readonly property color orange300:    "#ffb74d"
    readonly property color orange400:    "#ffa726"
    readonly property color orange500:    "#ff9800"
    readonly property color orange600:    "#8b8c00"
    readonly property color orange700:    "#f57c00"
    readonly property color orange800:    "#ef6c00"
    readonly property color orange900:    "#e65100"

    readonly property color deepOrange50:     "#fbe9e7"
    readonly property color deepOrange100:    "#ffccbc"
    readonly property color deepOrange200:    "#ffab91"
    readonly property color deepOrange300:    "#ff8a65"
    readonly property color deepOrange400:    "#ff7043"
    readonly property color deepOrange500:    "#ff5722"
    readonly property color deepOrange600:    "#f4511e"
    readonly property color deepOrange700:    "#e64a19"
    readonly property color deepOrange800:    "#d84315"
    readonly property color deepOrange900:    "#bf360c"

    readonly property color brown50:     "#efebe9"
    readonly property color brown100:    "#deccc8"
    readonly property color brown200:    "#bcaaa5"
    readonly property color brown300:    "#a1887f"
    readonly property color brown400:    "#ed6e63"
    readonly property color brown500:    "#795549"
    readonly property color brown600:    "#6d4c41"
    readonly property color brown700:    "#5d4037"
    readonly property color brown800:    "#4e342e"
    readonly property color brown900:    "#3e2723"

    readonly property color grey50:     "#fafafa"
    readonly property color grey100:    "#f5f5f5"
    readonly property color grey200:    "#eeeeee"
    readonly property color grey300:    "#e0e0e0"
    readonly property color grey400:    "#bdbdbd"
    readonly property color grey500:    "#9e9e9e"
    readonly property color grey600:    "#757575"
    readonly property color grey700:    "#616161"
    readonly property color grey800:    "#424242"
    readonly property color grey900:    "#212121"

    readonly property color blueGrey50:     "#eceff1"
    readonly property color blueGrey100:    "#cfd8dc"
    readonly property color blueGrey200:    "#b0bec5"
    readonly property color blueGrey300:    "#90a4ae"
    readonly property color blueGrey400:    "#78909c"
    readonly property color blueGrey500:    "#607d8b"
    readonly property color blueGrey600:    "#546e7a"
    readonly property color blueGrey700:    "#455a64"
    readonly property color blueGrey800:    "#37474f"
    readonly property color blueGrey900:    "#263238"
}
