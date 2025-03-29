/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/

import QtQuick
import QtQuick.Controls

Item {
    id: root
    width: 1334
    height: 750

    Image {
        id: image
        x: 0
        y: 0
        width: 1334
        height: 750
        horizontalAlignment: Image.AlignHCenter
        verticalAlignment: Image.AlignVCenter
        source: "../Pngs/confirmations.jpg"
        fillMode: Image.PreserveAspectFit
    }

    Rectangle {
        id: rectangle1
        x: 411
        y: 81
        width: 513
        height: 589
        color: "#ffffff"
        radius: 34

        Enter_box_heading {
            id: text2
            x: 60
            y: 211
            text: "First Name"
            font.styleName: "SemiBold"
            font.family: "Mazin DEMO"
            font.bold: true
        }

        Rectangle {
            id: rectangle2
            x: 60
            y: 244
            width: 375
            height: 43
            color: "#e8e0e0"
            radius: 5

            TextInput {
                id: textInput
                x: 16
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

        Button {
            id: button
            x: 414
            y: 528
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

        Text {
            id: text4
            x: 60
            y: 50
            text: "Your Details"
            font.styleName: "SemiBold"
            font.pointSize: 20
            font.family: "Mazin DEMO"
        }

        Text {
            id: text5
            x: 60
            y: 104
            text: "Reservation Date : --------"
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignTop
            font.styleName: "Regular"
            font.pointSize: 10
            font.family: "Mazin DEMO"
        }

        Text {
            id: text6
            x: 60
            y: 124
            text: "Total Seats : ---"
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignTop
            font.styleName: "Regular"
            font.pointSize: 10
            font.family: "Mazin DEMO"
        }

        Text {
            id: text7
            x: 60
            y: 143
            text: "Total Price : ---"
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignTop
            font.styleName: "Regular"
            font.pointSize: 10
            font.family: "Mazin DEMO"
        }

        Rectangle {
            id: rectangle
            x: 50
            y: 187
            width: 431
            height: 2
            color: "#ffffff"
            border.width: 6
        }

        Enter_box_heading {
            id: text8
            x: 60
            y: 307
            text: "Last Name"
            font.styleName: "SemiBold"
            font.family: "Mazin DEMO"
            font.bold: true
        }

        Rectangle {
            id: rectangle4
            x: 60
            y: 340
            width: 375
            height: 43
            color: "#e8e0e0"
            radius: 5
            TextInput {
                id: textInput2
                x: 16
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

        Enter_box_heading {
            id: text9
            x: 60
            y: 408
            text: "Phone Number"
            font.styleName: "SemiBold"
            font.family: "Mazin DEMO"
            font.bold: true
        }

        Rectangle {
            id: rectangle5
            x: 60
            y: 441
            width: 375
            height: 43
            color: "#e8e0e0"
            radius: 5
            TextInput {
                id: textInput3
                x: 16
                y: 7
                width: 267
                height: 29
                text: qsTr("+92 123 4567891")
                font.pixelSize: 13
                verticalAlignment: Text.AlignVCenter
                font.styleName: "Light"
                font.family: "Mazin DEMO"
            }
        }
    }
}
