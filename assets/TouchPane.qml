import bb.cascades 1.2

NavigationPane {
    id: navigationPane
    
    
    DataEntryTouchPage {
        id: dataEntryPage
    }
    
    function initData(){
        dataEntryPage.initData()
    }
    
    onPopTransitionEnded: {
        page.destroy()
    }
}
