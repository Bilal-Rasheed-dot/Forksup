/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/

import QtQuick
import QtQuick.Controls
import ForksupProject

Rectangle {
    id: rectangle
    width: Constants.width
    height: Constants.height

    color: Constants.backgroundColor

    // Remove signal definition from UI file

    Image {
        id: image
        x: 0
        y: 0
        width: 1334
        height: 750
        source: "../Pngs/business page.png"
        fillMode: Image.PreserveAspectFit

        Rectangle {
            id: rectangle1
            x: 471
            y: 219
            width: 393
            height: 359
            color: "#ffffff"
            radius: 34

            Enter_box_heading {
                id: text1
                font.bold: true
                font.family: "Mazin DEMO"
                font.styleName: "SemiBold"
                x: 43
                y: 152
                text: "Password"
            }

            Enter_box_heading {
                id: text2
                x: 43
                y: 58
                text: "Username"
                font.styleName: "SemiBold"
                font.family: "Mazin DEMO"
                font.bold: true
            }

            Rectangle {
                id: rectangle2
                x: 43
                y: 88
                width: 303
                height: 43
                color: "#e8e0e0"
                radius: 5

                TextInput {
                    id: textInput
                    x: 8
                    y: 7
                    width: 267
                    height: 29
                    text: qsTr("Enter text here")
                    font.pixelSize: 13
                    verticalAlignment: Text.AlignVCenter
                    font.styleName: "Light"
                    font.family: "Mazin DEMO"
                }
            }

            MouseArea {
                id: mouseArea
                x: 44
                y: 246
                width: 122
                height: 16

                // Remove Connections block

                Text {
                    id: text3
                    x: 0
                    y: 0
                    width: 278
                    height: 16
                    text: qsTr("Do you want to Eat?")
                    font.pixelSize: 13
                    font.underline: true
                    font.family: "Mazin DEMO"
                }
            }

            Rectangle {
                id: rectangle3
                x: 43
                y: 182
                width: 303
                height: 43
                color: "#e8e0e0"
                radius: 5

                TextInput {
                    id: textInput1
                    x: 8
                    y: 8
                    width: 267
                    height: 29
                    text: qsTr("Enter text here")
                    font.pixelSize: 13
                    verticalAlignment: Text.AlignVCenter
                    maximumLength: 8
                    echoMode: TextInput.Password
                    font.styleName: "Light"
                    font.family: "Mazin DEMO"
                }
            }

            Button {
                id: button
                x: 275
                y: 284
                width: 71
                height: 33
                flat: false
                highlighted: true

                icon.source: "../Dependencies/Components/examples/TransitionItem/images/svg/arrow-right.svg"
                icon.height: 21
                icon.width: 19
                icon.color: "#ffffff"

                // Custom background to allow rounded corners
                background: Rectangle {
                    color: "#2a2a2a" // Button color (change as needed)
                    radius: 16       // Rounded edges (half of height makes it pill-shaped)
                }
            }
        }

        Image {
            id: image1
            x: 479
            y: 92
            width: 377
            height: 117
            source: "../Pngs/1741278137918.png"
            fillMode: Image.PreserveAspectFit
        }
    }

    states: [
        State {
            name: "clicked"
        }
    ]
}

