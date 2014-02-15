import bb.cascades 1.2

Page {
    id: dataEntryPage
    property string alphaValue: "FF"
    onAlphaValueChanged: {
        var argb = alphaValue + redValue + greenValue + blueValue
        alphaText.text = alphaValue
        colorbar.bgcolor = Color.create("#" + argb)
    }
    property string redValue: "FF"
    onRedValueChanged: {
        var argb = alphaValue + redValue + greenValue + blueValue
        rgbText.text = redValue + greenValue + blueValue
        colorbar.bgcolor = Color.create("#" + argb)
    }
    property string greenValue: "FF"
    onGreenValueChanged: {
        var argb = alphaValue + redValue + greenValue + blueValue
        rgbText.text = redValue + greenValue + blueValue
        colorbar.bgcolor = Color.create("#" + argb)
    }
    property string blueValue: "FF"
    onBlueValueChanged: {
        var argb = alphaValue + redValue + greenValue + blueValue
        rgbText.text = redValue + greenValue + blueValue
        colorbar.bgcolor = Color.create("#" + argb)
    }

    titleBar: TitleBar {
        title: "Data Entry"
    }
    actions: [
        ActionItem {
            title: "Magenta"
            imageSource: "asset:///images/my_color.png"
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: {
                colorPicker.select(0, 5)
            }
            shortcuts: [
                Shortcut {
                    key: 'm'
                }
            ]
        },
        DeleteActionItem {
            onTriggered: {
                initData()
            }
        }
    ]
    ScrollView {
        id: scrollView
        Container {
            id: outerContainer
            leftPadding: 40
            rightPadding: 40
            topPadding: 20
            layout: StackLayout {
                orientation: LayoutOrientation.TopToBottom
            }
            Container {
                id: labelContainer
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Label {
                    text: "Text"
                    verticalAlignment: VerticalAlignment.Center
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 0.6
                    }
                }
                TextField {
                    id: labelText
                    verticalAlignment: VerticalAlignment.Center
                    text: ""
                    hintText: qsTr("Some Text")
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 2.0
                    }
                    input {
                        submitKey: SubmitKey.Next
                        flags: TextInputFlag.SpellCheck | TextInputFlag.Prediction
                    }
                    onTextChanged: {
                        //
                    }
                }
            } // end labelContainer
            Container {
                id: valueUnitContainer
                topPadding: 10
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Label {
                    text: qsTr("Value")
                    multiline: true
                    verticalAlignment: VerticalAlignment.Center
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 0.6
                    }
                }
                TextField {
                    id: valueText
                    rightMargin: 0
                    verticalAlignment: VerticalAlignment.Center
                    text: ""
                    hintText: qsTr("Value: >= 0")
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 2.0
                    }
                    inputMode: TextFieldInputMode.Pin
                    input {
                        submitKey: SubmitKey.Next
                    }
                    onTextChanging: {
                        var x = text.replace("A", "")
                        x = x.replace("B", "")
                        x = x.replace("C", "")
                        x = x.replace("D", "")
                        x = x.replace("E", "")
                        x = x.replace("F", "")
                        valueText.text = x
                    }
                    onTextChanged: {
                        if (text.length == 0) {
                            valueText.text = 0
                        }
                    }
                    validator: Validator {
                        mode: ValidationMode.Immediate
                        errorMessage: "Value must be numeric"
                        onValidate: {
                            if (isValidNumber(valueText.text))
                                state = ValidationState.Valid;
                            else
                                state = ValidationState.Invalid;
                        }
                    }
                } // end valuetext
            } // end valueUnitContainer
            Divider {
            }
            Container {
                id: colorContainer
                topPadding: 10
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Label {
                    text: "Color"
                    verticalAlignment: VerticalAlignment.Center
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 0.6
                    }
                }
                Container {
                    id: innerColorContainer
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    verticalAlignment: VerticalAlignment.Center
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 2.0
                    }
                    Container {
                        id: leftPart
                        layout: StackLayout {
                            orientation: LayoutOrientation.LeftToRight
                        }
                        layoutProperties: StackLayoutProperties {
                            spaceQuota: 1.0
                        }
                        Label {
                            text: "ARGB #"
                            minWidth: 100
                            rightMargin: 0
                            verticalAlignment: VerticalAlignment.Center
                            layoutProperties: StackLayoutProperties {
                                spaceQuota: -1
                            }
                        }
                        TextField {
                            id: alphaText
                            leftMargin: 0
                            rightMargin: 0
                            verticalAlignment: VerticalAlignment.Center
                            layoutProperties: StackLayoutProperties {
                                spaceQuota: 3.6
                            }
                            text: "FF"
                            inputMode: TextFieldInputMode.Pin
                            input {
                                submitKey: SubmitKey.Next
                            }
                            hintText: "FF"
                            onTextChanged: {
                                if (text.length == 2) {
                                    setalpha(text)
                                } else {
                                    alphaText.text = dataEntryPage.alphaValue
                                }
                            }
                            validator: Validator {
                                mode: ValidationMode.Immediate
                                errorMessage: "Alpha Value must be 00 ... FF"
                                onValidate: {
                                    if (alphaText.text.length == 2 && isValidAlpha(alphaText.text))
                                        state = ValidationState.Valid;
                                    else
                                        state = ValidationState.Invalid;
                                }
                            }
                        }
                    }
                    TextField {
                        id: rgbText
                        leftMargin: 0
                        verticalAlignment: VerticalAlignment.Center
                        layoutProperties: StackLayoutProperties {
                            spaceQuota: 1.0
                        }
                        text: "FFFFFF"
                        inputMode: TextFieldInputMode.Pin
                        input {
                            submitKey: SubmitKey.Done
                            onSubmitted: {
                                flags:
                                TextInputFlag.VirtualKeyboardOff
                                colorbar.requestFocus()
                            }
                        }
                        hintText: "FFFFFF"
                        onTextChanged: {
                            if (text.length == 6) {
                                var newRed = text.slice(0, 2)
                                var newGreen = text.slice(2, 4)
                                var newBlue = text.slice(4, 6)
                                setargb(alphaValue, newRed, newGreen, newBlue)
                            } else {
                                rgbText.text = dataEntryPage.redValue + dataEntryPage.greenValue + dataEntryPage.blueValue
                            }
                        }
                        validator: Validator {
                            mode: ValidationMode.Immediate
                            errorMessage: "RGB Value must be 000000 ... FFFFFF"
                            onValidate: {
                                if (rgbText.text.length == 6 && isValidColor(rgbText.text))
                                    state = ValidationState.Valid;
                                else
                                    state = ValidationState.Invalid;
                            }
                        }
                    }
                } // end innerColorContainer
            } // end colorContainer
            Container {
                id: selectedColorContainer
                topPadding: 10
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Label {
                    // this could also be used as a TRICK
                    // to avoid Picker with predefined to be opened
                    focusPolicy: FocusPolicy.KeyAndTouch
                    text: ""
                    verticalAlignment: VerticalAlignment.Center
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 0.6
                    }
                    onFocusedChanged: {
                        if (focused) {
                            labelText.requestFocus()
                        }
                    }
                }
                Container {
                    id: colorbar
                    property variant bgcolor: Color.create("#FFFF0000")
                    onBgcolorChanged: {
                        background = bgcolor
                    }
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 2.0
                    }
                    minHeight: 60
                    maxHeight: 60
                    background: bgcolor
                    shortcuts: [
                        Shortcut {
                            key: 't'
                            onTriggered: {
                                labelText.requestFocus()
                            }
                        },
                        Shortcut {
                            key: 'p'
                            onTriggered: {
                                colorPicker.requestFocus()
                            }
                        },
                        Shortcut {
                            key: 'Enter'
                            onTriggered: {
                                labelText.requestFocus()
                            }
                        }
                    ]
                } // end colorbar
            } // end selectedColorContainer
            Divider {
            }
            Container {
                id: predefinedColorContainer
                topPadding: 20
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Label {
                    text: ""
                    verticalAlignment: VerticalAlignment.Center
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 0.6
                    }
                }
                Picker {
                    id: colorPicker
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 2.0
                    }
                    title: qsTr("Predefined Colors")
                    dataModel: XmlDataModel {
                        source: "asset:///datamodel/colors.xml"
                    }
                    pickerItemComponents: [
                        PickerItemComponent {
                            type: "itemcolor"
                            content: Container {
                                leftPadding: 40
                                layout: StackLayout {
                                    orientation: LayoutOrientation.LeftToRight
                                } // end of StackLayout
                                Label {
                                    text: pickerItemData.displayname
                                    verticalAlignment: VerticalAlignment.Center
                                    layoutProperties: StackLayoutProperties {
                                        spaceQuota: 1.0
                                    }
                                } // end of Label
                                ImageView {
                                    verticalAlignment: VerticalAlignment.Center
                                    imageSource: "asset:///images/" + pickerItemData.image + ".png"

                                    layoutProperties: StackLayoutProperties {
                                        spaceQuota: 1.0
                                    }
                                }
                            } // end of Container
                        } // end of PickerItemComponent
                    ] // end pickerItemComponents
                    onSelectedValueChanged: {
                        switch (selectedValue[0]) {
                            case 0:
                                // RED
                                setargb("FF", "FF", "00", "00")
                                break
                            case 1:
                                // YELLOW
                                setargb("FF", "FF", "FF", "00")
                                break
                            case 2:
                                // GREEN
                                setargb("FF", "00", "FF", "00")
                                break
                            case 3:
                                // CYAN
                                setargb("FF", "00", "FF", "FF")
                                break
                            case 4:
                                // BLUE
                                setargb("FF", "00", "00", "FF")
                                break
                            case 5:
                                // MAGENTA
                                setargb("FF", "FF", "00", "FF")
                                break
                            case 6:
                                // GRAY
                                setargb("FF", "A0", "A0", "A3")
                                break
                        }
                    }
                    shortcuts: [
                        Shortcut {
                            key: 'Space'
                            onTriggered: {
                                // this will give us the number of elements
                                var size = colorPicker.dataModel.childCount([0])
                                // max value for loop
                                var max = size-1
                                var row = colorPicker.selectedIndex(0)
                                if(row < max){
                                    row ++
                                } else {
                                    row = 0
                                }
                                colorPicker.select(0,row)
                            }
                        }
                    ]
                    keyListeners: [
                        KeyListener {
                            id: upAndDownKeys
                            onKeyReleased: {
                                if(event.keycap == 61522){
                                    // ARROW-UP
                                    var row = colorPicker.selectedIndex(0)
                                    if(row >0){
                                        row --
                                    } else {
                                        row = 6
                                    }
                                    colorPicker.select(0,row)
                                } else if (event.keycap == 61524){
                                    // ARROW-DOWN
                                    var row = colorPicker.selectedIndex(0)
                                    if(row < 6){
                                        row ++
                                    } else {
                                        row = 0
                                    }
                                    colorPicker.select(0,row)
                                }
                            }
                        }
                    ]
                } // end colorPicker
            } // predefinedColorContainer
        } // end outerContainer
    } // end scroll
    function setalpha(newAlpha) {
        alphaValue = newAlpha
    }
    function setrgb(newRed, newGreen, newBlue) {
        redValue = newRed
        greenValue = newGreen
        blueValue = newBlue
    }
    function setargb(newAlpha, newRed, newGreen, newBlue) {
        alphaValue = newAlpha
        redValue = newRed
        greenValue = newGreen
        blueValue = newBlue
    }
    function isValidNumber(str){
        return !isNaN(str) 
    }
    function isValidAlpha(str) {
        return str.match(/^[a-f0-9]{2}$/i) !== null
    }
    function isValidColor(str) {
        return str.match(/^[a-f0-9]{6}$/i) !== null
    }
    function initData() {
        colorPicker.select(0, 0)
        labelText.text = ""
        valueText.text = ""
        labelText.requestFocus()
    }
    onCreationCompleted: {

    }
}
