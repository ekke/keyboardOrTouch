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
                text: "Please connect your external device via Bluetooth or USB, then try the keys to get values for your KeyListeners"
                multiline: true
            }
            Divider {
            }
            Label {
                text: "You pressed this Key:"
            }
            Container {
                leftPadding: 60
                Label {
                    id: keyLabel
                    text: "....."
                    textStyle.base: SystemDefaults.TextStyles.BigText
                    textStyle.color: Color.Magenta
                }
            }
            Label {
                text: "You pressed this KeyCap:"
            }
            Container {
                leftPadding: 60
                Label {
                    id: keyCapLabel
                    text: "....."
                    textStyle.base: SystemDefaults.TextStyles.BigText
                    textStyle.color: Color.Magenta
                }
            }
        }
    }
    
    onPopTransitionEnded: {
        page.destroy()
    }
}
