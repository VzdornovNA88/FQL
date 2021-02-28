
import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0

/*!
    \qmltype ButtonStyle
    \inqmlmodule QtQuick.Controls.Styles
    \since 5.1
    \ingroup controlsstyling
    \brief Provides custom styling for Button.

    You can create a custom button by replacing the "background" delegate
    of the ButtonStyle with a custom design.

    Example:
    \qml
    Button {
        text: "A button"
        style: ButtonStyle {
            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 25
                border.width: control.activeFocus ? 2 : 1
                border.color: "#888"
                radius: 4
                gradient: Gradient {
                    GradientStop { position: 0 ; color: control.pressed ? "#ccc" : "#eee" }
                    GradientStop { position: 1 ; color: control.pressed ? "#aaa" : "#ccc" }
                }
            }
        }
    }
    \endqml
    If you need a custom label, you can replace the label item.
*/

Style {
    id: buttonstyle

    /*! The \l {QtQuick.Controls::}{Button} this style is attached to. */
    readonly property Button control: __control

    /*! The padding between the background and the label components. */
    padding {
        top: 4
        left: 4
        right: 4 + (control.menu !== null ? Math.round(TextSingleton.implicitHeight * 0.5) : 0)
        bottom: 4
    }

    /*! This defines the background of the button. */
    property Component background: Item {
        property bool down: control.pressed || (control.checkable && control.checked)
        implicitWidth: Math.round(TextSingleton.implicitHeight * 4.5)
        implicitHeight: Math.max(25, Math.round(TextSingleton.implicitHeight * 1.2))
        Rectangle {
            anchors.fill: parent
            anchors.bottomMargin: down ? 0 : -1
            color: "#10000000"
            radius: baserect.radius
        }
        Rectangle {
            id: baserect
            gradient: Gradient {
                GradientStop {color: down ? "#aaa" : "#fefefe" ; position: 0}
                GradientStop {color: down ? "#ccc" : "#e3e3e3" ; position: down ? 0.1: 1}
            }
            radius: TextSingleton.implicitHeight * 0.16
            anchors.fill: parent
            border.color: control.activeFocus ? "#47b" : "#999"
            Rectangle {
                anchors.fill: parent
                radius: parent.radius
                color: control.activeFocus ? "#47b" : "white"
                opacity: control.hovered || control.activeFocus ? 0.1 : 0
                Behavior on opacity {NumberAnimation{ duration: 100 }}
            }
        }
        Image {
            id: imageItem
            visible: control.menu !== null
//            source: "images/arrow-down.png"
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 4
            opacity: control.enabled ? 0.6 : 0.5
        }
    }

    /*! This defines the label of the button.  */
    property Component label: Rectangle {
        implicitWidth: row.implicitWidth
        implicitHeight: row.implicitHeight
        baselineOffset: row.y + text.y + text.baselineOffset
        color:"white"
        Row {
            id: row
            anchors.centerIn: parent
            spacing: 2
            Image {
                source: control.iconSource
                anchors.verticalCenter: parent.verticalCenter
            }
            Text {
                id: text
                renderType: Settings.isMobile ? Text.QtRendering : Text.NativeRendering
                anchors.verticalCenter: parent.verticalCenter
                text: StyleHelpers.stylizeMnemonics(control.text)
                color: "black"/*SystemPaletteSingleton.buttonText(control.enabled)*/
            }
        }
    }

    /*! \internal */
    property Component panel: Item {
        anchors.fill: parent
        implicitWidth: Math.max(labelLoader.implicitWidth + padding.left + padding.right, backgroundLoader.implicitWidth)
        implicitHeight: Math.max(labelLoader.implicitHeight + padding.top + padding.bottom, backgroundLoader.implicitHeight)
        baselineOffset: labelLoader.item ? padding.top + labelLoader.item.baselineOffset : 0

        Loader {
            id: backgroundLoader
            anchors.fill: parent
            sourceComponent: background
        }

        Loader {
            id: labelLoader
            sourceComponent: label
            anchors.fill: parent
            anchors.leftMargin: padding.left
            anchors.topMargin: padding.top
            anchors.rightMargin: padding.right
            anchors.bottomMargin: padding.bottom
        }
    }
}
