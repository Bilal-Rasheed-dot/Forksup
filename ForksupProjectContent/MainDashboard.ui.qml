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
    id: dashboardRoot
    width: Constants.width
    height: Constants.height
    color: "#ffffff"

    // Signals for navigation and interactions
    signal orderRestaurant(string restaurantId)
    signal reserveRestaurant(string restaurantId)

    // Background image
    Image {
        id: image
        x: 0
        y: 0
        width: 1334
        height: 750
        source: "../../mian dashboard.png"
        fillMode: Image.PreserveAspectFit

        Image {
            id: image1
            x: -95
            y: 648
            width: 437
            height: 114
            source: "../../../1741278137918.png"
            fillMode: Image.PreserveAspectFit
        }
    }

    Rectangle {
        id: headerSection
        x: 0
        width: parent.width
        height: 100
        color: "transparent"
        anchors.top: parent.top
        anchors.topMargin: 37

        Text {
            id: searchLabel
            text: "Search for your favorite restaurant here!"
            color: "white"
            font.family: "Mazin DEMO"
            font.pixelSize: 16
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.leftMargin: 30
        }

        // Search bar
        Rectangle {
            id: searchBar
            width: parent.width - 60
            height: 40
            radius: 20
            color: "#E0E0E0"
            anchors.top: searchLabel.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter

            TextInput {
                id: searchInput
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.right: filterButton.left
                anchors.rightMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                font.family: "Mazin DEMO"
                font.pixelSize: 14
                clip: true

                Text {
                    text: "Search restaurants..."
                    font.family: "Mazin DEMO"
                    font.pixelSize: 14
                    color: "#888888"
                    visible: !searchInput.text
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            // Filter button
            Rectangle {
                id: filterButton
                width: 40
                height: 40
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                color: "transparent"

                Image {
                    id: filterIcon
                    source: "../../../filter.png"
                    anchors.centerIn: parent
                    width: 20
                    height: 20
                    fillMode: Image.PreserveAspectFit
                }

                MouseArea {
                    id: filterArea
                    anchors.fill: parent
                    onClicked: filterPopup.visible = !filterPopup.visible
                }
            }
        }

        // Filter popup
        Rectangle {
            id: filterPopup
            width: 200
            height: 180
            color: "white"
            radius: 10
            anchors.top: searchBar.bottom
            anchors.right: searchBar.right
            anchors.topMargin: 5
            visible: false
            z: 10

            Column {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 10

                Text {
                    text: "Cuisine Types"
                    font.family: "Mazin DEMO"
                    font.bold: true
                    font.pixelSize: 14
                }

                CheckBox {
                    text: "Italian"
                    font.family: "Mazin DEMO"
                }

                CheckBox {
                    text: "Chinese"
                    font.family: "Mazin DEMO"
                }

                CheckBox {
                    text: "Indian"
                    font.family: "Mazin DEMO"
                }

                CheckBox {
                    text: "American"
                    font.family: "Mazin DEMO"
                }
            }
        }
    }

    // Restaurant grid
    GridView {
        id: restaurantGrid
        anchors.top: headerSection.bottom
        anchors.topMargin: 30
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: 86
        anchors.rightMargin: 86
        anchors.bottomMargin: 58
        cellWidth: width / 3
        cellHeight: 240
        clip: true
        model: 6 // Number of restaurants

        delegate: Rectangle {
            id: restaurantCard
            width: restaurantGrid.cellWidth - 10
            height: restaurantGrid.cellHeight - 10
            radius: 10
            border.color: "#E0E0E0"
            border.width: 1

            // Restaurant ID for demonstration
            property string restaurantId: "restaurant_" + index

            // Status text (OPEN or CLOSED)
            property bool isOpen: index !== 1 && index !== 4 // Example: restaurants 1 and 4 are closed

            Column {
                anchors.fill: parent
                spacing: 0

                // Restaurant image
                Rectangle {
                    width: parent.width
                    height: parent.height * 0.5
                    color: "#F0F0F5"
                    radius: 10

                    Image {
                        anchors.centerIn: parent
                        width: 24
                        height: 24
                        source: "../../../images/image_placeholder.png"
                    }

                    // Status indicator
                    Rectangle {
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.margins: 10
                        width: statusText.width + 20
                        height: statusText.height + 10
                        color: "#FFFFFF"
                        radius: 5

                        Text {
                            id: statusText
                            anchors.centerIn: parent
                            text: isOpen ? "OPEN" : "CLOSED"
                            font.family: "Mazin DEMO"
                            font.pixelSize: 12
                            color: "#000000"
                            font.bold: true
                        }
                    }
                }

                // Restaurant details
                Rectangle {
                    width: parent.width
                    height: parent.height * 0.5
                    color: "#FFFFFF"
                    radius: 10 // Match top radius

                    Column {
                        anchors.fill: parent
                        anchors.margins: 10
                        spacing: 5

                        // Restaurant name
                        Rectangle {
                            Text {
                                anchors.left: parent.left
                                anchors.leftMargin: 5
                                text: "Restaurant " + (index + 1)
                                font.family: "Mazin DEMO"
                                font.pixelSize: 14
                                color: "#000000"
                            }
                        }

                        // Buttons row
                        Row {
                            width: parent.width
                            height: 30
                            spacing: 10
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 5

                            // Order button
                            Button {
                                id: orderButton
                                width: (parent.width - 10) * 0.5
                                height: 30
                                text: "Order"
                                font.family: "Mazin DEMO"
                                font.pixelSize: 12
                                enabled: isOpen // Disable for closed restaurants

                                background: Rectangle {
                                    color: orderButton.enabled ?
                                          (orderButton.pressed ? "#1A1A1A" : "#2A2A2A") :
                                          "#AAAAAA"
                                    radius: 5
                                }

                                contentItem: Text {
                                    text: orderButton.text
                                    font: orderButton.font
                                    color: "#FFFFFF"
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                            }

                            // Reserve button
                            Button {
                                id: reserveButton
                                width: (parent.width - 10) * 0.5
                                height: 30
                                text: "Reserve"
                                font.family: "Mazin DEMO"
                                font.pixelSize: 12
                                enabled: isOpen // Disable for closed restaurants

                                background: Rectangle {
                                    color: reserveButton.enabled ?
                                          (reserveButton.pressed ? "#1A1A1A" : "#2A2A2A") :
                                          "#AAAAAA"
                                    radius: 5
                                }

                                contentItem: Text {
                                    text: reserveButton.text
                                    font: reserveButton.font
                                    color: "#FFFFFF"
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                            }
                        }
                    }
                }
            }
        }

        Text {
            id: text1
            x: 18
            y: 154
            width: 280
            height: 16
            text: qsTr("Location ")
            font.pixelSize: 13
        }

        Text {
            id: text2
            x: 404
            y: 154
            width: 280
            height: 16
            text: qsTr("Location ")
            font.pixelSize: 13
        }

        Text {
            id: text3
            x: 793
            y: 154
            width: 280
            height: 16
            text: qsTr("Location ")
            font.pixelSize: 13
        }

        Text {
            id: text4
            x: 18
            y: 398
            width: 280
            height: 16
            text: qsTr("Location ")
            font.pixelSize: 13
        }

        Text {
            id: text5
            x: 404
            y: 398
            width: 280
            height: 16
            text: qsTr("Location ")
            font.pixelSize: 13
        }

        Text {
            id: text6
            x: 793
            y: 398
            width: 280
            height: 16
            text: qsTr("Location ")
            font.pixelSize: 13
        }
    }
}
