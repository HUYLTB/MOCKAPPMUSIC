QT += quick
QT += widgets
QT += multimedia
# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        Control/controlsong.cpp \
        Control/languagecontrol.cpp \
        Model/dirdialog.cpp \
        Model/listsong.cpp \
        main.cpp

RESOURCES += qml.qrc

TRANSLATIONS += \
        language_en.ts \
        language_vi.ts

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
DISTFILES +=
HEADERS += \
    Control/controlsong.h \
    Control/languagecontrol.h \
    Model/dirdialog.h \
    Model/listsong.h \


