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
    id: orderPopupRoot
    width: 824
    height: 500
    color: "#00000000"  // Transparent background

    // Signal to close popup
    signal closePopup()

    // Semi-transparent overlay
    Rectangle {
        id: overlay
        anchors.fill: parent
        color: "#80000000"  // Semi-transparent black
    }

    // Main popup window
    Rectangle {
        id: popupWindow
        width: 660
        height: 430
        anchors.centerIn: parent
        color: "#ffffff"
        radius: 8

        // Header bar
        Rectangle {
            id: headerBar
            width: parent.width
            height: 100
            color: "#222222"  // Dark blue/black as shown in wireframe
            radius: 8

            // Only apply radius to top corners
            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                height: parent.height / 2
                color: parent.color
            }

            // Restaurant logo
            BorderImage {
                id: borderImage
                x: 30
                y: 20
                width: 70
                height: 68
                source: "qrc:/qtquickplugin/images/template_image.png"
            }

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
                id: closeButton
                width: 24
                height: 24
                anchors.right: parent.right
                anchors.rightMargin: 15
                anchors.top: parent.top
                anchors.topMargin: 15
                color: "transparent"

                Text {
                    anchors.centerIn: parent
                    text: "×"  // Unicode X symbol
                    color: "#ffffff"
                    font.pixelSize: 24
                    font.family: "Mazin DEMO"
                }

                MouseArea {
                    anchors.fill: parent

                    Connections {
                        target: parent
                        function onClicked() { orderPopupRoot.closePopup() }
                    }
                }
            }
        }

        // Menu items container
        Row {
            id: menuItemsRow
            anchors.top: headerBar.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 20

            // Item 1
            Rectangle {
                id: item1Container
                width: 190
                height: 200
                border.width: 1
                border.color: "#dddddd"
                radius: 5

                // Image placeholder
                Rectangle {
                    id: item1Image
                    width: 160
                    height: 100
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    color: "#f0f0f0"

                    // Image placeholder "X"
                    Text {
                        anchors.centerIn: parent
                        text: "⊗"
                        font.pixelSize: 24
                        color: "#777777"
                    }
                }

                // Item name
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: item1Image.bottom
                    anchors.topMargin: 10
                    text: qsTr("Item 1")
                    font.family: "Mazin DEMO"
                    font.pixelSize: 14
                }

                // Quantity controls
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 10
                    spacing: 10

                    // Decrease button
                    Rectangle {
                        width: 24
                        height: 24
                        border.width: 1
                        border.color: "#aaaaaa"

                        Text {
                            anchors.centerIn: parent
                            text: "-"
                            font.pixelSize: 16
                            font.family: "Mazin DEMO"
                        }
                    }

                    // Quantity display
                    Rectangle {
                        width: 60
                        height: 24
                        color: "#f0f0f0"
                    }

                    // Increase button
                    Rectangle {
                        width: 24
                        height: 24
                        border.width: 1
                        border.color: "#aaaaaa"

                        Text {
                            anchors.centerIn: parent
                            text: "+"
                            font.pixelSize: 16
                            font.family: "Mazin DEMO"
                        }
                    }

                    // Add button
                    Rectangle {
                        width: 40
                        height: 24
                        color: "#000000"
                        radius: 3

                        Text {
                            anchors.centerIn: parent
                            text: qsTr("Add")
                            color: "#ffffff"
                            font.pixelSize: 10
                            font.family: "Mazin DEMO"
                        }
                    }
                }
            }

            // Item 2
            Rectangle {
                id: item2Container
                width: 190
                height: 200
                border.width: 1
                border.color: "#dddddd"
                radius: 5

                // Image placeholder
                Rectangle {
                    id: item2Image
                    width: 160
                    height: 100
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    color: "#f0f0f0"

                    // Image placeholder "X"
                    Text {
                        anchors.centerIn: parent
                        text: "⊗"
                        font.pixelSize: 24
                        color: "#777777"
                    }
                }

                // Item name
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: item2Image.bottom
                    anchors.topMargin: 10
                    text: qsTr("Item 2")
                    font.family: "Mazin DEMO"
                    font.pixelSize: 14
                }

                // Quantity controls
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 10
                    spacing: 10

                    // Decrease button
                    Rectangle {
                        width: 24
                        height: 24
                        border.width: 1
                        border.color: "#aaaaaa"

                        Text {
                            anchors.centerIn: parent
                            text: "-"
                            font.pixelSize: 16
                            font.family: "Mazin DEMO"
                        }
                    }

                    // Quantity display
                    Rectangle {
                        width: 60
                        height: 24
                        color: "#f0f0f0"
                    }

                    // Increase button
                    Rectangle {
                        width: 24
                        height: 24
                        border.width: 1
                        border.color: "#aaaaaa"

                        Text {
                            anchors.centerIn: parent
                            text: "+"
                            font.pixelSize: 16
                            font.family: "Mazin DEMO"
                        }
                    }

                    // Add button
                    Rectangle {
                        width: 40
                        height: 24
                        color: "#000000"
                        radius: 3

                        Text {
                            anchors.centerIn: parent
                            text: qsTr("Add")
                            color: "#ffffff"
                            font.pixelSize: 10
                            font.family: "Mazin DEMO"
                        }
                    }
                }
            }

            // Item 3
            Rectangle {
                id: item3Container
                width: 190
                height: 200
                border.width: 1
                border.color: "#dddddd"
                radius: 5

                // Image placeholder
                Rectangle {
                    id: item3Image
                    width: 160
                    height: 100
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    color: "#f0f0f0"

                    // Image placeholder "X"
                    Text {
                        anchors.centerIn: parent
                        text: "⊗"
                        font.pixelSize: 24
                        color: "#777777"
                    }
                }

                // Item name
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: item3Image.bottom
                    anchors.topMargin: 10
                    text: qsTr("Item 3")
                    font.family: "Mazin DEMO"
                    font.pixelSize: 14
                }

                // Quantity controls
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 10
                    spacing: 10

                    // Decrease button
                    Rectangle {
                        width: 24
                        height: 24
                        border.width: 1
                        border.color: "#aaaaaa"

                        Text {
                            anchors.centerIn: parent
                            text: "-"
                            font.pixelSize: 16
                            font.family: "Mazin DEMO"
                        }
                    }

                    // Quantity display
                    Rectangle {
                        width: 60
                        height: 24
                        color: "#f0f0f0"
                    }

                    // Increase button
                    Rectangle {
                        width: 24
                        height: 24
                        border.width: 1
                        border.color: "#aaaaaa"

                        Text {
                            anchors.centerIn: parent
                            text: "+"
                            font.pixelSize: 16
                            font.family: "Mazin DEMO"
                        }
                    }

                    // Add button
                    Rectangle {
                        width: 40
                        height: 24
                        color: "#000000"
                        radius: 3

                        Text {
                            anchors.centerIn: parent
                            text: qsTr("Add")
                            color: "#ffffff"
                            font.pixelSize: 10
                            font.family: "Mazin DEMO"
                        }
                    }
                }
            }
        }

        // Divider line
        Rectangle {
            id: divider
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 60
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width - 40
            height: 1
            color: "#dddddd"
        }

        // Cart button
        Rectangle {
            id: cartButton
            width: 40
            height: 40
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            color: "#222222"
            radius: 5

            Text {
                anchors.centerIn: parent
                text: "🛒"
                color: "#ffffff"
                font.pixelSize: 20
            }
        }
    }
}
