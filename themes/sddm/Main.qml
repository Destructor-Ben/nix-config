import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as QQC2
import QtQuick.Window 2.15
import Qt5Compat.GraphicalEffects 6.0 
import SddmComponents 2.0

import org.kde.breeze.components

Item {
    id: root
    width: Screen.width
    height: Screen.height
    focus: true

    // 1. STATE & CONFIG

    property bool authOpen: false
    property bool sessionOpen: false
    
    // 1.1 Status message from the system ("Authentication failure")
    property string statusMessage: ""

    property int currentSessionIndex: 0
    property var now: new Date()
    
    Timer {
        interval: 1000; running: true; repeat: true
        onTriggered: root.now = new Date()
    }

    readonly property real blurRadius: 60
    readonly property real sleepDim: 0
    readonly property real authDim:  0

    readonly property color cClock:            "#ffffff"
    readonly property color cDate:             "#e0e0e0"
    readonly property color cMuted:            "#909090"
    readonly property color cShadow:           "#40000000"
    readonly property color cBG:               "#131522"
    readonly property color cFG:               "#1b1e2e"
    readonly property color cAccent:           "#cf365a"
    readonly property color cText:             "#ffffff"
    readonly property color cError:            "#E67E80" // TODO: set

    // 2. CONNECTIONS 

    Connections {
        target: sddm
        
        function onLoginFailed() {
            passwordInput.text = ""
            passwordInput.forceActiveFocus()
            
            // 2.1 Trigger Visuals
            authCard.loginFailed = true 
            shakeAnimation.start()
            failResetTimer.restart()
            
            // 2.2 If PAM didn't send a specific text error, default to this:
            if (root.statusMessage === "") root.statusMessage = "Login Failed";
        }
        
        function onLoginSucceeded() {
            authCard.loginFailed = false
            root.statusMessage = "" 
        }

        // 2.3 Listeners.
        function onInformationMessage(message) { root.statusMessage = message }
        function onErrorMessage(message) { root.statusMessage = message }
    }

    Timer {
        id: failResetTimer
        interval: 900; repeat: false
        onTriggered: authCard.loginFailed = false
    }


    // 3. HELPERS

    QQC2.ComboBox {
        id: sessionSelector
        visible: false
        model: sessionModel
        textRole: "name"
        currentIndex: root.currentSessionIndex
    }

    QQC2.ComboBox {
        id: userSelector
        visible: false
        model: userModel
        textRole: "name"
        currentIndex: (userModel.lastIndex !== undefined && userModel.lastIndex >= 0) ? userModel.lastIndex : 0
    }

    function toFileUrl(p) {
        if (!p) return "";
        var s = String(p).trim();
        if (s.indexOf("file://") === 0) return s;
        if (s.indexOf("/") === 0) return "file://" + s;
        return s;
    }

    function username() { return userSelector.currentText || ""; }

    function avatarCandidate(i) {
        var u = username();
        if (i === 0) return toFileUrl("/usr/share/sddm/faces/" + u + ".face.icon");
        if (i === 1) return toFileUrl("/var/lib/AccountsService/icons/" + u);
        return "";
    }

    function wake() {
        if (!root.authOpen) {
            root.authOpen = true;
            root.sessionOpen = false;
            focusTimer.restart();
        }
    }

    function sleep() {
        root.authOpen = false;
        root.sessionOpen = false;
        passwordInput.text = "";
        root.statusMessage = ""; 
        wakeKeyCatcher.forceActiveFocus();
    }

    function attemptLogin() {
        if (passwordInput.text.length === 0) return;
        
        root.statusMessage = "" // Clear previous messages
        
        var sessionIdx = sessionSelector.currentIndex;
        if (sessionIdx < 0) sessionIdx = (root.currentSessionIndex >= 0) ? root.currentSessionIndex : 0;
        var uname = userSelector.currentText;
        
        sddm.login(uname, passwordInput.text, sessionIdx);
    }

    Component.onCompleted: {
        if (sessionModel.lastIndex !== undefined && sessionModel.lastIndex >= 0) {
            root.currentSessionIndex = sessionModel.lastIndex;
        }
        sleep();
    }


    // 4. EVENT HANDLERS
    TextInput {
        id: wakeKeyCatcher
        width: 1; height: 1; opacity: 0
        focus: !root.authOpen
        Keys.onPressed: function(e) { wake(); e.accepted = true; }
    }

    Timer {
        id: focusTimer
        interval: 100; running: false; repeat: false
        onTriggered: passwordInput.forceActiveFocus()
    }


    // 5.VISUALS

    Image {
        id: background
        anchors.fill: parent
        z: 0
        fillMode: Image.PreserveAspectCrop
        source: "../../img/Wallpaper.svg"
    }

    FastBlur {
        anchors.fill: parent
        radius: root.authOpen ? root.blurRadius : 0
        source: background
        z: 1
        opacity: root.authOpen ? 1.0 : 0.0
        visible: opacity > 0
        Behavior on opacity { NumberAnimation { duration: 300 } }
        Behavior on radius  { NumberAnimation { duration: 300 } }
    }

    Rectangle {
        anchors.fill: parent
        z: 2
        color: "black"
        opacity: root.authOpen ? root.authDim : root.sleepDim
        Behavior on opacity { NumberAnimation { duration: 300 } }
    }

    MouseArea {
        anchors.fill: parent
        z: 3
        enabled: !root.authOpen
        onClicked: wake()
    }

    // 6. CLOCK

    Text {
        z: 4
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -350
        text: Qt.formatDate(root.now, "dddd, MMMM d")
        color: root.cDate
        font.pixelSize: 48
        font.weight: Font.Medium
        font.family: "JetBrains Mono"
        opacity: root.authOpen ? 0.0 : 1.0
        Behavior on opacity { NumberAnimation { duration: 300 } }
    }

    Column {
        z: 4
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -50
        spacing: -87
        opacity: root.authOpen ? 0.0 : 1.0
        Behavior on opacity { NumberAnimation { duration: 300 } }

        layer.enabled: true
        layer.effect: DropShadow {
            transparentBorder: true; color: root.cShadow; radius: 45; samples: 20; verticalOffset: 10
        }

        Text {
            text: {
                var hourStr = Qt.formatTime(root.now, "hh AP");
                return hourStr.slice(0, -3).trim();
            }
            color: root.cClock
            font.family: "JetBrains Mono" 
            font.pixelSize: 220; font.weight: Font.Medium
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Text {
            text: Qt.formatTime(root.now, "mm")
            color: root.cClock
            font.family: "JetBrains Mono"
            font.pixelSize: 220; font.weight:Font.Medium
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }


    // 7. POWER MENU UI

    Rectangle {
        id: powerPill
        z: 20
        width: 72 * 3 + 10 * 4; height: 72 + 10 * 2; radius: height / 2
        color: root.cBG

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: root.authOpen ? (root.height / 2) - (authCard.height / 2) - height - 20 : -500
        opacity: root.authOpen ? 1.0 : 0.0

        Behavior on anchors.bottomMargin { NumberAnimation { duration: 500; easing.type: Easing.OutExpo } }
        Behavior on opacity { NumberAnimation { duration: 300 } }

        layer.enabled: true
        layer.effect: DropShadow {
            transparentBorder: true; color: root.cShadow; radius: 30; samples: 20; verticalOffset: 10
        }

        RowLayout {
            anchors.centerIn: parent
            spacing: 10

            Rectangle {
                width: 72
                height: 72
                radius: 36
                color: sleepButton.containsMouse ? root.cFG : root.cBG
                Behavior on color { ColorAnimation { duration: 200 } }

                MouseArea {
                    id: sleepButton
                    hoverEnabled: true; cursorShape: Qt.PointingHandCursor
                    onClicked: sddm.suspend()
                    anchors.fill: parent

                    Image {
                        anchors.centerIn: parent
                        source: "img/Sleep.svg"
                    }
                }
            }

            Rectangle {
                width: 72
                height: 72
                radius: 36
                color: rebootButton.containsMouse ? root.cFG : root.cBG
                Behavior on color { ColorAnimation { duration: 200 } }

                MouseArea {
                    id: rebootButton
                    hoverEnabled: true; cursorShape: Qt.PointingHandCursor
                    onClicked: sddm.reboot()
                    anchors.fill: parent

                    Image {
                        anchors.centerIn: parent
                        source: "img/Reboot.svg"
                    }
                }
            }

            Rectangle {
                width: 72
                height: 72
                radius: 36
                color: shutdownButton.containsMouse ? root.cFG : root.cBG
                Behavior on color { ColorAnimation { duration: 200 } }

                MouseArea {
                    id: shutdownButton
                    hoverEnabled: true; cursorShape: Qt.PointingHandCursor
                    onClicked: sddm.powerOff()
                    anchors.fill: parent

                    Image {
                        anchors.centerIn: parent
                        source: "img/Shutdown.svg"
                    }
                }
            }
        }
    }

    // 8. AUTH CARD

    Rectangle {
        id: authCard
        z: 15
        width: 400; height: 500
        radius: powerPill.radius
        color: root.cBG

        // --- 8.1 ERROR BORDER ---
        property bool loginFailed: false
        border.width: loginFailed ? 2 : 0
        border.color: loginFailed ? root.cError : "transparent"
        Behavior on border.width { NumberAnimation { duration: 150 } }
        Behavior on border.color { ColorAnimation { duration: 150 } }

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: root.authOpen ? (root.height / 2) - (height / 2) : -500
        opacity: root.authOpen ? 1.0 : 0.0

        Behavior on anchors.bottomMargin { NumberAnimation { duration: 500; easing.type: Easing.OutExpo } }
        Behavior on opacity { NumberAnimation { duration: 300 } }

        // --- 8.2 RATTLE ANIMATION ---
        SequentialAnimation {
            id: shakeAnimation
            NumberAnimation { target: authCard; property: "anchors.horizontalCenterOffset"; from: 0; to: -16; duration: 50; easing.type: Easing.InOutQuad }
            NumberAnimation { target: authCard; property: "anchors.horizontalCenterOffset"; from: -16; to: 16; duration: 50; easing.type: Easing.InOutQuad }
            NumberAnimation { target: authCard; property: "anchors.horizontalCenterOffset"; from: 16; to: -12; duration: 50; easing.type: Easing.InOutQuad }
            NumberAnimation { target: authCard; property: "anchors.horizontalCenterOffset"; from: -12; to: 12; duration: 50; easing.type: Easing.InOutQuad }
            NumberAnimation { target: authCard; property: "anchors.horizontalCenterOffset"; from: 12; to: 0; duration: 50; easing.type: Easing.InOutQuad }
        }

        layer.enabled: true
        layer.effect: DropShadow {
            transparentBorder: true; color: root.cShadow; radius: 30; samples: 20; verticalOffset: 10
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 40
            anchors.topMargin: 100
            spacing: 24

            Item {
                Layout.alignment: Qt.AlignHCenter
                width: 160; height: 160
                Rectangle {
                    id: avatarCircle
                    anchors.fill: parent
                    radius: 80; color: "transparent"
                    property int tryIndex: 0; property bool ok: false
                    Image {
                        anchors.fill: parent; fillMode: Image.PreserveAspectCrop
                        source: avatarCandidate(avatarCircle.tryIndex)
                        layer.enabled: true
                        layer.effect: OpacityMask { maskSource: Rectangle { width: 160; height: 160; radius: 80 } }
                        onStatusChanged: {
                            if (status === Image.Ready) avatarCircle.ok = true;
                            else if (status === Image.Error && avatarCircle.tryIndex < 2) {
                                avatarCircle.tryIndex += 1; source = avatarCandidate(avatarCircle.tryIndex);
                            }
                        }
                    }
                    Rectangle {
                        anchors.fill: parent; radius: 80; color: root.cFG; visible: !avatarCircle.ok
                        Text { anchors.centerIn: parent; text: (username().length ? username()[0].toUpperCase() : "?"); color: root.cText; font.pixelSize: 64 }
                    }
                }
            }

            Text { text: "Ben"; color: root.cText; font.pixelSize: 22; font.bold: true; Layout.alignment: Qt.AlignHCenter }

            ColumnLayout {
                Layout.alignment: Qt.AlignHCenter; spacing: 8
                // The "Ben" text was originally here
                
                /*Rectangle {
                    Layout.alignment: Qt.AlignHCenter; implicitWidth: sessionLabel.contentWidth + 24; implicitHeight: 26; radius: 8; color: root.cFG
                    Text { id: sessionLabel; anchors.centerIn: parent; text: sessionSelector.currentText; color: root.cMuted; font.pixelSize: 12 }
                    MouseArea {
                        anchors.fill: parent; cursorShape: Qt.PointingHandCursor
                        onClicked: { root.sessionOpen = !root.sessionOpen; if (root.sessionOpen) sessionList.forceActiveFocus() }
                    }
                }*/
            }

            // 8.3 PASSWORD INPUT AND STATUS MESSAGE
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 10

                // 8.3.1 INPUT BOX
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 56
                    radius: 28
                    color: root.cFG
                    clip: true

                    Item {
                        anchors.fill: parent; anchors.leftMargin: 20; anchors.rightMargin: 60
                        TextInput {
                            id: passwordInput
                            anchors.fill: parent
                            verticalAlignment: TextInput.AlignVCenter
                            color: root.cText
                            selectionColor: root.cAccent
                            selectedTextColor: root.cText
                            echoMode: TextInput.Password
                            font.pixelSize: 16
                            focus: true

                            cursorVisible: false
                            cursorDelegate: Rectangle {
                                visible: passwordInput.text.length !== 0
                                color: root.cText
                                width: 2
                                radius: 1
                                height: parent.height
                                anchors.verticalCenter: parent.verticalCenter

                                SequentialAnimation on opacity {
                                    loops: Animation.Infinite
                                    running: visible
                                    NumberAnimation { to: 1;   duration: 500 }
                                    NumberAnimation { to: 0.5; duration: 500 }
                                }
                            }
                            
                            onAccepted: attemptLogin()
                            Keys.onEscapePressed: root.sleep()
                            Keys.onPressed: { if (event.key === Qt.Key_Down && root.sessionOpen) sessionList.forceActiveFocus() }
                        }
                        Text {
                            anchors.centerIn: parent; text: "Enter Password"; color: root.cMuted
                            visible: passwordInput.text.length === 0; font.pixelSize: 16
                        }
                    }

                    Rectangle {
                        width: 48; height: 48; radius: 24
                        color: root.cAccent
                        
                        anchors.right: parent.right; anchors.rightMargin: 4
                        anchors.verticalCenter: parent.verticalCenter
                        Image {
                            anchors.centerIn: parent
                            source: "img/Arrow.svg"
                        }
                        MouseArea {
                            anchors.fill: parent; cursorShape: Qt.PointingHandCursor
                            onClicked: attemptLogin()
                        }
                    }
                }
                
                // 8.4 ERROR STATUS TEXT
                Text {
                    Layout.alignment: Qt.AlignHCenter
                    text: root.statusMessage
                    color: root.cError
                    font.pixelSize: 14
                    font.weight: Font.DemiBold
                    visible: root.statusMessage.length > 0
                    opacity: visible ? 1.0 : 0.0
                    Behavior on opacity { NumberAnimation { duration: 200 } }
                }
            }
        }

        // 9. SESSION SELECTOR LIST

        Rectangle {
            anchors.bottom: parent.bottom; anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width - 40; height: root.sessionOpen ? 220 : 0
            radius: 16; color: root.cFG; clip: true; visible: height > 0
            Behavior on height { NumberAnimation { duration: 300; easing.type: Easing.InOutExpo } }
            
            ListView {
                id: sessionList; anchors.fill: parent; anchors.margins: 10
                model: sessionModel; focus: false; keyNavigationEnabled: true
                
                highlight: Rectangle { 
                    color: Qt.rgba(1,1,1,0.1)
                    radius: 8 
                }
                highlightMoveDuration: 0

                delegate: Item {
                    width: parent.width; height: 40
                    Rectangle {
                        anchors.fill: parent; radius: 8
                        property bool isHovered: mouseArea.containsMouse; property bool isSelected: ListView.isCurrentItem
                        color: (isHovered || isSelected) ? Qt.rgba(1,1,1,0.05) : "transparent"
                        Text { anchors.centerIn: parent; text: name; color: root.cText; font.pixelSize: 14 }
                        MouseArea {
                            id: mouseArea; anchors.fill: parent; hoverEnabled: true
                            onClicked: { sessionList.currentIndex = index; root.currentSessionIndex = index; sessionSelector.currentIndex = index; root.sessionOpen = false; passwordInput.forceActiveFocus() }
                        }
                    }
                }
                Keys.onReturnPressed: { root.currentSessionIndex = currentIndex; sessionSelector.currentIndex = currentIndex; root.sessionOpen = false; passwordInput.forceActiveFocus() }
                Keys.onEscapePressed: { root.sessionOpen = false; passwordInput.forceActiveFocus() }
            }
        }
    }

    Text {
        z: 4; anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom; anchors.bottomMargin: 50
        text: "Press any key to unlock"; color: root.cMuted
        opacity: root.authOpen ? 0.0 : 1.0
        Behavior on opacity { NumberAnimation { duration: 300 } }
    }
}
