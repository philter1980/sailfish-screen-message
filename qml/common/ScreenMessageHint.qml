import QtQuick 2.0
import Sailfish.Silica 1.0

Loader {
    anchors.fill: parent
    active: counter.active
    sourceComponent: Component {
        Item {
            property bool pageActive: firstpage.status == PageStatus.Active
            onPageActiveChanged: {
                if (pageActive) {
                    touchInteractionHint.restart()
                    pageActive = false
                    counter.increase()
                }
            }

            anchors.fill: parent
            InteractionHintLabel {
                text: qsTr("Flick to display text")
                anchors.bottom: parent.bottom
                opacity: touchInteractionHint.running ? 1.0 : 0.0
                Behavior on opacity { FadeAnimation { duration: 1000 } }
            }
            TouchInteractionHint {
                id: touchInteractionHint

                direction: TouchInteraction.Left
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
    FirstTimeUseCounter {
        id: counter
        limit: 3
        defaultValue: 1 // display hint twice for existing users
        key: "/nomeata/screen-message/swipe_hint_count"
    }
}
