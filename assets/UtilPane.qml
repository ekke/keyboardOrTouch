import bb.cascades 1.2

NavigationPane {
    id: navigationPane
    
    
    Page {
        id: keyListenerTestPage
        titleBar: TitleBar {
            title: "Test Keys"
        }
        keyListeners: [
            KeyListener {
                id: test
                onKeyReleased: {
                    console.debug("event KEY: "+event.key)
                    console.debug("event KEYCAP: "+event.keycap)
                    keyLabel.text = event.key
                    keyCapLabel.text = event.keycap
                }
            }
        ]
        Container {
            topPadding: 60
            leftPadding: 40
            rightPadding: 40
            Label {
                text: "You pressed this Key:"
            }
            Label {
                id: keyLabel
                text: "??"
            }
            Label {
                text: "You pressed this KeyCap:"
            }
            Label {
                id: keyCapLabel
                text: "??"
            }
        }
    }
    
    onPopTransitionEnded: {
        page.destroy()
    }
}
