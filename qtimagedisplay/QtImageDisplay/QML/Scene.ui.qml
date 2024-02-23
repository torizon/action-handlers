import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: item1
    width: 640
    height: 320

    Rectangle {
        anchors.fill: parent
        color: "white"
    }

    Image {
        id: image
        anchors.fill: parent
        anchors.margins: 20
        horizontalAlignment: Image.AlignHCenter
        verticalAlignment: Image.AlignVCenter
        property var counter: 0
        source: "file:///appdata/image.png?refresh=0"
        cache: false
        fillMode: Image.PreserveAspectFit

        function reloadImage() {
            console.log("reloaded")
            counter = counter + 1
            source = ""
            source = "file:///appdata/image.png?refresh=" + counter
        }
    }

    Timer {
        id: reloadImage
        interval: 1000; repeat: true; running: true
        onTriggered: {
            image.reloadImage()
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.66}
}
##^##*/
