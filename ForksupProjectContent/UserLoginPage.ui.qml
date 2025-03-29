import QtQuick
import QtQuick.Controls
import ForksupProject

Rectangle {
    id: rectangle
    width: Constants.width
    height: Constants.height

    // No JavaScript blocks or signal definitions here
    // Only UI elements and properties

    color: Constants.backgroundColor

    Image {
        id: image
        x: 0
        y: 0
        width: 1334
        height: 750
        source: "../Pngs/Artboard 1.png"
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

                // No connections here, just the MouseArea

                Text {
                    id: text3
                    x: 0
                    y: 0
                    width: 278
                    height: 16
                    text: qsTr("Are you a business?")
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
                    color: "#2a2a2a" // Button color
                    radius: 16       // Rounded edges
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
}
