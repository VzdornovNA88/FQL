import QtQuick 2.5

QtObject {
    id: object
    default property alias children: object.__childrenFix
    property list<HandleLevel> __childrenFix
}
