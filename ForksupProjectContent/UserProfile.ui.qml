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

    Rectangle {
        id: rectangle
        x: 0
        y: 0
        width: 1334
        height: 750
        color: "#3a3a3a"

        Image {
            id: image1
            x: 0
            y: 0
            width: 1334
            height: 750
            source: "../Pngs/admin profile.png"
            fillMode: Image.PreserveAspectFit
        }

        Rectangle {
            id: rectangle1
            x: 0
            y: 219
            width: 1334
            height: 3
            opacity: 0.597
            color: "#ffffff"
            border.color: "#ffffff"
            border.width: 0
        }

        Rectangle {
            id: rectangle2
            x: 56
            y: 316
            width: 1223
            height: 391
            opacity: 0.71
            color: "#00ffffff"
            radius: 7
            border.color: "#cfcfcf"
            border.width: 2


            Text {
                id: text1
                x: 40
                y: 21
                color: "#ffffff"
                text: qsTr("Last 5 Orders")
                font.pixelSize: 18
                font.styleName: "Medium"
                font.family: "Mazin DEMO"
            }

            Rectangle {
                id: rectangle3
                x: 40
                y: 61
                width: 1145
                height: 50
                color: "#ffffff"
                radius: 10
                border.width: 1

                Text {
                    id: text2
                    x: 20
                    y: 15
                    width: 289
                    height: 21
                    text: qsTr("#296 - Restaurant Name (Rs. 2040 pkr)")
                    font.pixelSize: 16
                }

                CheckBox {
                    id: checkBox
                    x: 1026
                    y: 5
                    text: qsTr("In Progress")
                    checkState: Qt.PartiallyChecked
                }

                Text {
                    id: text3
                    x: 927
                    y: 16
                    text: qsTr("27/03/2025")
                    font.pixelSize: 14
                }
            }

            Rectangle {
                id: rectangle4
                x: 39
                y: 123
                width: 1145
                height: 50
                color: "#ffffff"
                radius: 10
                border.width: 1
                Text {
                    id: text4
                    x: 20
                    y: 15
                    width: 285
                    height: 21
                    text: qsTr("#295 - Restaurant Name (Rs. 1800 pkr)")
                    font.pixelSize: 16
                }

                CheckBox {
                    id: checkBox1
                    x: 1026
                    y: 5
                    text: qsTr("Completed")
                    checkState: Qt.Checked
                }

                Text {
                    id: text5
                    x: 927
                    y: 16
                    text: qsTr("23/03/2025")
                    font.pixelSize: 14
                }
            }

            Rectangle {
                id: rectangle5
                x: 39
                y: 187
                width: 1145
                height: 50
                color: "#ffffff"
                radius: 10
                border.width: 1
                Text {
                    id: text6
                    x: 20
                    y: 15
                    width: 287
                    height: 21
                    text: qsTr("#294 - Restaurant Name (Rs. 700 pkr)")
                    font.pixelSize: 16
                }

                CheckBox {
                    id: checkBox2
                    x: 1026
                    y: 5
                    text: qsTr("Completed")
                    checkState: Qt.Checked
                }

                Text {
                    id: text7
                    x: 927
                    y: 16
                    text: qsTr("11/03/2025")
                    font.pixelSize: 14
                }
            }

            Rectangle {
                id: rectangle6
                x: 38
                y: 250
                width: 1145
                height: 50
                color: "#ffffff"
                radius: 10
                border.width: 1
                Text {
                    id: text8
                    x: 20
                    y: 15
                    width: 291
                    height: 21
                    text: qsTr("#293 - Restaurant Name (Rs. 12000 pkr)")
                    font.pixelSize: 16
                }

                CheckBox {
                    id: checkBox3
                    x: 1026
                    y: 5
                    text: qsTr("Completed")
                    checkState: Qt.Checked
                }

                Text {
                    id: text9
                    x: 927
                    y: 16
                    text: qsTr("27/02/2025")
                    font.pixelSize: 14
                }
            }

            Rectangle {
                id: rectangle7
                x: 40
                y: 313
                width: 1145
                height: 50
                color: "#ffffff"
                radius: 10
                border.width: 1
                Text {
                    id: text10
                    x: 20
                    y: 15
                    width: 284
                    height: 21
                    text: qsTr("#292 - Restaurant Name (Rs. 3000 pkr)")
                    font.pixelSize: 16
                }

                CheckBox {
                    id: checkBox4
                    x: 1026
                    y: 5
                    text: qsTr("Completed")
                    checkState: Qt.Checked
                }

                Text {
                    id: text11
                    x: 927
                    y: 16
                    text: qsTr("11/01/2025")
                    font.pixelSize: 14
                }
            }


        }

        Image {
            id: image
            x: 1139
            y: -40
            width: 193
            height: 193
            source: "../Pngs/1741278137918.png"
            fillMode: Image.PreserveAspectFit
        }

    }

    // Restaurant name
    Text {
        id: restaurantName
        x: 299
        y: 79
        text: "User Name"
        color: "#ffffff"
        font.family: "Mazin DEMO"
        font.pixelSize: 30
        font.bold: true
    }

    // Restaurant details (placeholder gray bars)
    TextEdit {
        id: textEdit
        x: 299
        y: 119
        width: 170
        height: 20
        text: qsTr("Total Orders : xxx")
        font.pixelSize: 13
        font.styleName: "Medium"
        font.family: "Mazin DEMO"
        color: "#ffffff"
    }

    Text {
        id: restaurantName1
        x: 58
        y: 258
        color: "#ffffff"
        text: "My Orders & Reservations"
        font.pixelSize: 30
        font.styleName: "Bold"
        font.family: "Mazin DEMO"
        font.bold: true
    }

    Rectangle {
        id: rectangle8
        x: 159
        y: 56
        width: 112
        height: 112
        color: "#00ffffff"
        radius: 7
        border.color: "#ffffff"
        border.width: 5
    }

}
