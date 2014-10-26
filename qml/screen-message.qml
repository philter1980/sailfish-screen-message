/*
  Copyright (C) 2014 Joachim Breitner
  Contact: Joachim Breitner <mail@joachim-breitner.de>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import "js/settings.js" as S
import "common"

ApplicationWindow
{
    id: app
    initialPage: firstpage
    cover: cover

    Component.onCompleted: {
        thetext = S.readSetting("text", "")
        smText.cursorPosition = thetext.length
        pageStack.pushAttached(secondpage)
        state = S.readSetting("state", "BOW")
    }

    property string thetext;
    property string bgcolor;
    property string fgcolor;


    states: [
        State {
            name: "BOW"
            PropertyChanges { target: app; fgcolor: "black"}
            PropertyChanges { target: app; bgcolor: "white"}
            PropertyChanges { target: menuitem; text: qsTr("Switch to White on Black")}

        },
        State {
            name: "WOB"
            PropertyChanges { target: app; fgcolor: "white"}
            PropertyChanges { target: app; bgcolor: "black"}
            PropertyChanges { target: menuitem; text: qsTr("Switch to Black on White")}
        }
    ]

    onStateChanged: S.storeSetting("state", state)
    onThetextChanged: S.storeSetting("text", thetext);

    Page {
        id: firstpage
        allowedOrientations: Orientation.All


        // To enable PullDownMenu, place our content in a SilicaFlickable
        SilicaFlickable {
            anchors.fill: parent

            PullDownMenu {
                MenuItem {
                    id: menuitem
                    onClicked: {
                        if (app.state == "BOW")
                            app.state = "WOB"
                        else
                            app.state = "BOW"
                    }
                }
                MenuItem {
                    text: qsTr("Clear")
                    onClicked: smText.text = ""
                }
            }

            // Tell SilicaFlickable the height of its content.
            contentHeight: smText.height

            TextArea {
                id: smText

                y: Theme.paddingLarge
                width: parent.width
                height: Math.max(parent.parent.height - Theme.paddingLarge, implicitHeight)

                font.pointSize: Theme.fontSizeMedium
                font.family: Theme.fontFamily

                focus: true

                placeholderText: qsTr("Type your message here...")
                text: thetext;
                onTextChanged: thetext = text

                horizontalAlignment: TextEdit.AlignHCenter
                verticalAlignment: TextEdit.AlignVCenter
            }

            VerticalScrollDecorator {}
        }

        ScreenMessageHint{}
    }


    Page {
        id: secondpage
        allowedOrientations: Orientation.All

        Rectangle {
            anchors.fill: parent
            color: app.bgcolor
            opacity: 1
        }

        Label {
            anchors.centerIn: parent
            text: thetext
            color: app.fgcolor
            font.pointSize: Theme.fontSizeExtraLarge
            horizontalAlignment: Text.AlignHCenter
            // transformOrigin: Item.TopLeft
            scale: if (width > 0 && height > 0)
                   { Math.min(parent.width / width, parent.height / height) }
                   else 1
        }

    }

    CoverBackground {
        id: cover

        Rectangle {
            anchors.fill: parent
            color: app.bgcolor
            opacity: 1
        }

        Label {
            anchors.centerIn: parent
            text: thetext
            color: app.fgcolor
            font.pointSize: Theme.fontSizeExtraLarge
            horizontalAlignment: Text.AlignHCenter
            // transformOrigin: Item.TopLeft
            scale: if (width > 0 && height > 0)
                   { Math.min(parent.width / width, parent.height / height) }
                   else 1
        }
    }
}


