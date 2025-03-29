import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Window {
    id: mainWindow
    visible: true
    width: 1334
    height: 750
    title: "Forksu Project"

    // Global properties
    property string currentView: "userLogin"
    property bool isLoggedIn: false
    property bool isBusinessUser: false

    // Main content loader
    Loader {
        id: mainContentLoader
        anchors.fill: parent
        source: getCurrentView()
        onLoaded: {
            // Connect signals from loaded components
            if (item.objectName === "userLoginPage") {
                item.switchToBusinessLogin.connect(switchToBusinessLogin)
                item.loginSuccessful.connect(userLoginSuccessful)
            } else if (item.objectName === "businessLoginPage") {
                item.switchToUserLogin.connect(switchToUserLogin)
                item.loginSuccessful.connect(businessLoginSuccessful)
            } else if (item.objectName === "mainDashboard") {
                item.showOrderPopup.connect(showOrderPopup)
                item.showReservationPopup.connect(showReservationPopup)
            }
        }
    }

    // Popup loaders
    Loader {
        id: orderPopupLoader
        anchors.centerIn: parent
        active: false
        source: "OrderPopup.ui.qml"
        onLoaded: {
            item.visible = true
            item.closePopup.connect(hideOrderPopup)
        }
    }

    Loader {
        id: reservationPopupLoader
        anchors.centerIn: parent
        active: false
        source: "ReservationPopup.ui.qml"
        onLoaded: {
            item.visible = true
            item.closePopup.connect(hideReservationPopup)
        }
    }

    // Function to determine which view to load
    function getCurrentView() {
        if (!isLoggedIn) {
            if (currentView === "businessLogin") {
                return "BusinessLoginPage.ui.qml"
            } else {
                return "UserLoginPage.ui.qml"
            }
        } else {
            if (isBusinessUser) {
                return "BusinessProfilePage.ui.qml"  // You mentioned you need to make this
            } else {
                return "MainDashboard.ui.qml"
            }
        }
    }

    // Login page switching functions
    function switchToBusinessLogin() {
        currentView = "businessLogin"
        isLoggedIn = false
        mainContentLoader.source = "BusinessLoginPage.ui.qml"
    }

    function switchToUserLogin() {
        currentView = "userLogin"
        isLoggedIn = false
        mainContentLoader.source = "UserLoginPage.ui.qml"
    }

    // Login success handlers
    function userLoginSuccessful() {
        isLoggedIn = true
        isBusinessUser = false
        currentView = "mainDashboard"
        mainContentLoader.source = "MainDashboard.ui.qml"
    }

    function businessLoginSuccessful() {
        isLoggedIn = true
        isBusinessUser = true
        currentView = "businessProfile"
        mainContentLoader.source = "BusinessProfilePage.ui.qml"  // Future page you'll make
    }

    // Logout function
    function logout() {
        isLoggedIn = false
        if (isBusinessUser) {
            switchToBusinessLogin()
        } else {
            switchToUserLogin()
        }
        isBusinessUser = false
    }

    // Popup management functions
    function showOrderPopup() {
        orderPopupLoader.active = true
    }

    function hideOrderPopup() {
        orderPopupLoader.active = false
    }

    function showReservationPopup() {
        reservationPopupLoader.active = true
    }

    function hideReservationPopup() {
        reservationPopupLoader.active = false
    }
}
