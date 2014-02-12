import bb.cascades 1.2

NavigationPane {
    id: navigationPane
    
    
    Page {
        titleBar: TitleBar {
            title: "Homepage (Keyboard or Touch)"
        }
        ScrollView {
            id: scrollView
            Container {
                id: mainContainer
                topPadding: 60
                leftPadding: 40
                rightPadding: 40
                Container {
                    id: headerContainer
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight                    
                    }
                    ImageView {
                        imageSource: "asset:///images/ekke_cascades.png"
                        minWidth: 114
                        maxWidth: 114
                        minHeight: 114
                        maxHeight: 114
                    }
                    Label {
                        text: "This is only a sample app with focus on Touch vs Keyboard."
                        multiline: true
                    }
                } // end headerContainer
                Label {
                    text: "There's a corresponding article in (german) Web & Mobile Developer Magazin 4/2014\n"
                    multiline: true
                }
                Label {
                    text: "This app ignores all the golden rules HowTo create a optimal app with dynamic created content, translation of strings, great UI ...\n"
                    multiline: true
                }
                Label {
                    text: "This app works only in Portrait to make it simple and easy.\n"
                    multiline: true
                }
                Label {
                    text: "You should read the article from Web & Mobile Developer Magazin to understand what I'm demonstrating here.\n"
                    multiline: true
                }
                Label {
                    text: "Have FUN.\nekke (BlackBerry Elite) @ekkescorner"
                    multiline: true
                }
            } // end mainContainer
        } // end scrollView
        
        
    }
    
    
    
    onPopTransitionEnded: {
        page.destroy()
    }
}
