/*
 * Copyright (c) 2014 ekke (Ekkehard Gentz) Rosenheim Germany
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import bb.cascades 1.2

TabbedPane {
    id: rootPane
    showTabsOnActionBar: true
    keyListeners: [
        KeyListener {
            id: homeKey
            onKeyReleased: {
            	// F1
                if(event.key == 190 ){
                    activeTab = homeTab
                }
            }
        }
    ]
    Tab {
        id: homeTab
        title: "Home"
        imageSource: "asset:///images/home.png"
        HomePane {
            id: homePane
        }
        shortcuts: [
            Shortcut {
                key: 'h'
                onTriggered: {
                    activeTab = homeTab
                }
            }
        ]
    }
    Tab {
        id: touchTab
        title: "Touch me"
        imageSource: "asset:///images/touch.png"
        TouchPane {
            id: touchPane
        }
    }
    Tab {
        id: keyTab
        title: "Keyboard"
        imageSource: "asset:///images/keyboard.png"
        KeyPane {
            id: keyPane
        }
    }
    Tab {
        id: utiltab
        title: "Utility"
        imageSource: "asset:///images/util.png"
        UtilPane {
            id: utilPane
        }
    }
    
    onActiveTabChanged: {
        if(activeTab == homeTab){
            showTabsOnActionBar = true
        } else {
            showTabsOnActionBar = false
        }
        if(activeTab == touchTab || activeTab == keyTab){
            activeTab.content.initData()
        }
    }
    
    onCreationCompleted: {
        //
    }
}
