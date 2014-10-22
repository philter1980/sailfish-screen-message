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
TARGET = screen-message

CONFIG += sailfishapp

SOURCES += src/screen-message.cpp

OTHER_FILES += qml/screen-message.qml \
    rpm/screen-message.changes.in \
    rpm/screen-message.spec \
    rpm/screen-message.yaml \
    translations/*.ts \
    screen-message.desktop \
    qml/js/settings.js

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/screen-message-de.ts

