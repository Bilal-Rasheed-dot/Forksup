

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick
import QtQuick.Controls
import QtQuick.Studio.Components 1.0

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
                    text: qsTr("#137 - Username (8 Seats - 4:30 PM)")
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

                Text {
                    id: text13
                    x: 747
                    y: 15
                    width: 111
                    height: 21
                    text: qsTr("Reservation")
                    font.pixelSize: 16
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
                    text: qsTr("#134 - Username (Rs. 1800 pkr)")
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

                CheckBox {
                    id: checkBox5
                    x: 1026
                    y: 5
                    text: qsTr("Completed")
                    checkState: Qt.Checked
                }

                Text {
                    id: text17
                    x: 749
                    y: 15
                    width: 120
                    height: 21
                    text: qsTr("Order")
                    font.pixelSize: 16
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
                    text: qsTr("#130 - Username (3 Seats - 1:00 AM)")
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

                Text {
                    id: text14
                    x: 748
                    y: 15
                    width: 96
                    height: 21
                    text: qsTr("Reservation")
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.top: text6.top
                    anchors.bottom: text6.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    font.pixelSize: 16
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
                    text: qsTr("#120 - Username (Rs. 12000 pkr)")
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

                Text {
                    id: text16
                    x: 750
                    y: 15
                    width: 135
                    height: 21
                    text: qsTr("Order")
                    font.pixelSize: 16
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
                    text: qsTr("#140 - Username (Rs. 3000 pkr)")
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

                Text {
                    id: text15
                    x: 747
                    y: 15
                    width: 106
                    height: 21
                    text: qsTr("Order")
                    font.pixelSize: 16
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
        text: "Restaurant Name"
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
        y: 259
        color: "#ffffff"
        text: "Orders & Reservations"
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

        Image {
            id: image2
            x: 5
            y: 5
            width: 102
            height: 102
            horizontalAlignment: Image.AlignHCenter
            verticalAlignment: Image.AlignVCenter
            source: "../Pngs/resLogo.jpg"
            fillMode: Image.PreserveAspectFit
        }
    }

    GroupItem {
        x: 1242
        y: 181

        RadioButton {
            id: radioButton
            x: 42
            y: -6
            width: 38
            height: 32
            text: qsTr("Radio Button")
            checked: true
        }

        Text {
            id: text12
            x: -7
            y: 0
            color: "#ffffff"
            text: qsTr("Status")
            font.pixelSize: 16
            font.family: "Mazin DEMO"
        }
    }
}
