# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-screen-message

CONFIG += sailfishapp

SOURCES += \
    src/harbour-screen-message.cpp

OTHER_FILES += \
    translations/*.ts \
    qml/js/settings.js \
    qml/common/ScreenMessageHint.qml \
    harbour-screen-message.desktop \
    rpm/harbour-screen-message.changes.in \
    rpm/harbour-screen-message.spec \
    rpm/harbour-screen-message.yaml \
    qml/harbour-screen-message.qml

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/harbour-screen-message-de.ts

