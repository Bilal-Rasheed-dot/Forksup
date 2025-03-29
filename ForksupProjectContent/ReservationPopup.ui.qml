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
    id: popupContainer
    width: 824
    height: 500
    color: "transparent"

    // Signals
    signal closeReservation()
    signal confirmReservation(string guests, string date, string time)

    // Property to store restaurant info
    property string restaurantId: ""
    property string restaurantName: "Restaurant Name"
    property string restaurantImage: "../../../restaurant1.png"

    // Semi-transparent background overlay
    Rectangle {
        anchors.fill: parent
        color: "#000000"
        opacity: 0.5

        MouseArea {
            anchors.fill: parent
            // Prevent clicks passing through
        }
    }

    // Popup Card
    Rectangle {
        id: reservationCard
        width: 660
        height: 430
        anchors.centerIn: parent
        radius: 8
        color: "#ffffff"

        // Header section with restaurant info
        Rectangle {
            id: headerSection
            width: parent.width
            height: 100
            color: "#222222"
            radius: 8

            // Only round top corners
            Rectangle {
                width: parent.width
                height: parent.height / 2
                anchors.bottom: parent.bottom
                color: parent.color
            }

            BorderImage {
                id: borderImage
                x: 29
                y: 16
                width: 70
                height: 68
                source: "qrc:/qtquickplugin/images/template_image.png"
            }

            // Restaurant name
            Text {
                id: restaurantName
                x: 120
                y: 20
                text: "Restaurant Name"
                color: "#FFFFFF"
                font.family: "Mazin DEMO"
                font.pixelSize: 24
                font.bold: true
            }

            // Restaurant details (placeholder gray bars)
            TextEdit {
                id: textEdit
                x: 120
                y: 57
                width: 170
                height: 20
                text: qsTr("Location, Cuisine")
                font.pixelSize: 12
                color: "white"
            }

            // Close button
            Rectangle {
                width: 30
                height: 30
                x: parent.width - width - 10
                y: 10
                color: "transparent"

                Text {
                    anchors.centerIn: parent
                    text: "✕"
                    color: "#ffffff"
                    font.pixelSize: 16
                }

                MouseArea {
                    anchors.fill: parent
                }
            }
        }

        // Reservation Parameters Section
        Rectangle {
            id: paramsSection
            x: 0
            y: headerSection.height
            width: parent.width
            height: 90
            color: "#e0e0e0"

            Row {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 20

                // Guests Selection
                Column {
                    width: (parent.width - 40) / 3
                    spacing: 5

                    Text {
                        text: "Guests"
                        font.family: "Mazin DEMO"
                        font.pixelSize: 14
                    }

                    ComboBox {
                        id: guestsCombo
                        width: parent.width
                        height: 36
                        model: ["1 Person", "2 People", "3 People", "4 People", "5 People", "6+ People"]

                        // Style the ComboBox for Qt Design Studio
                        background: Rectangle {
                            radius: 4
                            border.color: "#d0d0d0"
                            border.width: 1
                            color: "#ffffff"
                        }
                    }
                }

                // Time Selection
                Column {
                    width: (parent.width - 40) / 3
                    spacing: 5

                    Text {
                        text: "Time"
                        font.family: "Mazin DEMO"
                        font.pixelSize: 14
                    }

                    ComboBox {
                        id: timeCombo
                        width: parent.width
                        height: 36
                        model: ["Breakfast", "Lunch", "Dinner"]

                        // Style the ComboBox for Qt Design Studio
                        background: Rectangle {
                            radius: 4
                            border.color: "#d0d0d0"
                            border.width: 1
                            color: "#ffffff"
                        }
                    }
                }

                // Date Selection
                Column {
                    width: (parent.width - 40) / 3
                    spacing: 5

                    Text {
                        text: "Date"
                        font.family: "Mazin DEMO"
                        font.pixelSize: 14
                    }

                    ComboBox {
                        id: dateCombo
                        width: parent.width
                        height: 36
                        model: ["Today", "Tomorrow", "In 2 days", "In 3 days", "Next week"]

                        // Style the ComboBox for Qt Design Studio
                        background: Rectangle {
                            radius: 4
                            border.color: "#d0d0d0"
                            border.width: 1
                            color: "#ffffff"
                        }
                    }
                }
            }
        }

        // Time Slots Section
        Item {
            id: timeSlotsSection
            x: 30
            y: paramsSection.y + paramsSection.height + 20
            width: parent.width - 60
            height: 160

            // First Row of Time Slots
            Row {
                id: timeRow1
                width: parent.width
                height: 50
                spacing: 10

                // 1:00 PM
                Rectangle {
                    id: time1
                    width: (parent.width - 40) / 5
                    height: parent.height
                    border.color: "#d0d0d0"
                    border.width: 1
                    radius: 4

                    Text {
                        anchors.centerIn: parent
                        text: "1:00 PM"
                        font.family: "Mazin DEMO"
                        font.pixelSize: 14
                    }

                    MouseArea {
                        anchors.fill: parent
                    }
                }

                // 1:30 PM
                Rectangle {
                    id: time2
                    width: (parent.width - 40) / 5
                    height: parent.height
                    border.color: "#d0d0d0"
                    border.width: 1
                    radius: 4

                    Text {
                        anchors.centerIn: parent
                        text: "1:30 PM"
                        font.family: "Mazin DEMO"
                        font.pixelSize: 14
                    }

                    MouseArea {
                        anchors.fill: parent
                    }
                }

                // 2:00 PM
                Rectangle {
                    id: time3
                    width: (parent.width - 40) / 5
                    height: parent.height
                    border.color: "#d0d0d0"
                    border.width: 1
                    radius: 4

                    Text {
                        anchors.centerIn: parent
                        text: "2:00 PM"
                        font.family: "Mazin DEMO"
                        font.pixelSize: 14
                    }

                    MouseArea {
                        anchors.fill: parent
                    }
                }

                // 2:30 PM
                Rectangle {
                    id: time4
                    width: (parent.width - 40) / 5
                    height: parent.height
                    border.color: "#d0d0d0"
                    border.width: 1
                    radius: 4

                    Text {
                        anchors.centerIn: parent
                        text: "2:30 PM"
                        font.family: "Mazin DEMO"
                        font.pixelSize: 14
                    }

                    MouseArea {
                        anchors.fill: parent
                    }
                }

                // 3:00 PM
                Rectangle {
                    id: time5
                    width: (parent.width - 40) / 5
                    height: parent.height
                    border.color: "#d0d0d0"
                    border.width: 1
                    radius: 4

                    Text {
                        anchors.centerIn: parent
                        text: "3:00 PM"
                        font.family: "Mazin DEMO"
                        font.pixelSize: 14
                    }

                    MouseArea {
                        anchors.fill: parent
                    }
                }
            }

            // Second Row of Time Slots
            Row {
                id: timeRow2
                y: timeRow1.height + 20
                width: parent.width
                height: 50
                spacing: 10

                // 3:30 PM
                Rectangle {
                    id: time6
                    width: (parent.width - 40) / 5
                    height: parent.height
                    border.color: "#d0d0d0"
                    border.width: 1
                    radius: 4

                    Text {
                        anchors.centerIn: parent
                        text: "3:30 PM"
                        font.family: "Mazin DEMO"
                        font.pixelSize: 14
                    }

                    MouseArea {
                        anchors.fill: parent
                    }
                }

                // 4:00 PM
                Rectangle {
                    id: time7
                    width: (parent.width - 40) / 5
                    height: parent.height
                    border.color: "#d0d0d0"
                    border.width: 1
                    radius: 4

                    Text {
                        anchors.centerIn: parent
                        text: "4:00 PM"
                        font.family: "Mazin DEMO"
                        font.pixelSize: 14
                    }

                    MouseArea {
                        anchors.fill: parent
                    }
                }

                // 4:30 PM
                Rectangle {
                    id: time8
                    width: (parent.width - 40) / 5
                    height: parent.height
                    border.color: "#d0d0d0"
                    border.width: 1
                    radius: 4

                    Text {
                        anchors.centerIn: parent
                        text: "4:30 PM"
                        font.family: "Mazin DEMO"
                        font.pixelSize: 14
                    }

                    MouseArea {
                        anchors.fill: parent
                    }
                }
            }
        }

        // Confirm Button
        Rectangle {
            id: confirmButton
            width: 50
            height: 50
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: 20
            radius: 8
            color: "#222222"

            Text {
                anchors.centerIn: parent
                text: "→"
                color: "#ffffff"
                font.pixelSize: 24
            }

            MouseArea {
                anchors.fill: parent
            }
        }
    }
}
