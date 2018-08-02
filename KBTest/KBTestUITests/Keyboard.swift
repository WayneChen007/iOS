//
//  Keyboard.swift
//  KBTestUITests
//
//  Created by Wayne on 2018/6/6.
//  Copyright © 2018年 Wayne. All rights reserved.
//
import XCTest

class Keyboard{
    
    private var keyboardWindows: XCUIElement
    private var keyboard: XCUIElement
    private var candidatesScrollViews: XCUIElement

    var CURRENT_VIEW: Int = -1
    static let nineGridView: Int = 0
    static let fullKeyboradView: Int = 1
    static let fullKeyboardEnglishView: Int = 2
    static let numbersView: Int = 3
    static let punctuationView: Int = 4
    static let settingsView: Int = 5
    static let emojiView: Int = 6
    
    static let nextCandidate: String = "次候補"
    static let space: String = "空白"
    static let enter: String = "確定"
    static let numbers: String = "123"
    static let jpToEn: String = "あA"
    static let symbol: String = "記号"
    
    init(fromKeyboardWindows keyboardWindows: XCUIElement, textCase: Int=0) {
        self.keyboardWindows = keyboardWindows
        self.keyboard = keyboardWindows
            .otherElements.element(boundBy: 0)
            .otherElements.element(boundBy: 0)
            .otherElements.element(boundBy: 1)
            .otherElements.element(boundBy: 0)
            .otherElements.element(boundBy: 0)
            .otherElements.element(boundBy: 0)
            .otherElements.element(boundBy: 0)
            .otherElements.element(boundBy: 0)
        self.candidatesScrollViews = self.keyboard.scrollViews.element(boundBy: 1)
    }
    
    private func inputErea(mode: Int) -> XCUIElement{
        return self.keyboard.otherElements.element(boundBy: mode).otherElements.element(boundBy: 1)
    }
    
    func onTapKana(fromProperty proprety: KeyProperty, lowerCase: Bool = false){
        let key: String = lowerCase ? proprety.getKey(): proprety.getKey().uppercased()
        toKana()
        if proprety.getType() == Kana.HIRAGANA{
            tapTexts(fromKey: key)
        }else{
            tapTexts(fromKey: key)
            tapShift()
            tapNextCandidate()
            tapEnter()
        }
    }
    
    func onTapNOS(fromProperty proprety: KeyProperty){
        toNOS()
        switch proprety.getType() {
        case NOS.NUMBER:
            if self.CURRENT_VIEW == Keyboard.punctuationView{
                tapShift()
            }
            tapTexts(fromKey: proprety.getKey())
        case NOS.PUNCTUATION:
            if self.CURRENT_VIEW == Keyboard.numbersView{
                tapShift()
            }
            tapTexts(fromKey: proprety.getKey())
        default:
            break
        }
    } 
    
    func tapTexts(fromKey key: String){
        if key.count > 1{
            for c in key{
                tapCharacter(fromCharacter: String(c))
            }
        }else if key.count == 1{
            tapCharacter(fromCharacter: key)
        }else{
            debugPrint("DEBUG: Enpty text!")
        }
    }
    
    func tapCharacter(fromCharacter character: String){
        let mode: Int = inputErea(mode: 3).staticTexts[character].exists ? 3:6
        inputErea(mode: mode).staticTexts[character].tap()
    }
    
    func toKana(){
        switch self.CURRENT_VIEW {
        case Keyboard.fullKeyboardEnglishView:
            tapJpToEn()
            self.CURRENT_VIEW = Keyboard.fullKeyboradView
            break
        case Keyboard.numbersView, Keyboard.punctuationView:
            tapNumbers()
            self.CURRENT_VIEW = Keyboard.fullKeyboradView
            break
        default:
            break
        }
    }
    
    func toNOS(){
        if self.CURRENT_VIEW == Keyboard.fullKeyboradView || self.CURRENT_VIEW == Keyboard.fullKeyboradView{
            tapNumbers()
            self.CURRENT_VIEW = Keyboard.numbersView
        }
    }
    
    func tapShift(){
        switch CURRENT_VIEW {
        case Keyboard.fullKeyboradView:
            debugPrint("DEBUG: 颜文字？？")
            break
        case Keyboard.fullKeyboardEnglishView:
            debugPrint("DEBUG: 大写？？")
            break
        case Keyboard.numbersView:
            self.keyboard.images.element(boundBy: 2).tap()
            self.CURRENT_VIEW = Keyboard.punctuationView
        case Keyboard.punctuationView:
            self.keyboard.images.element(boundBy: 2).tap()
            self.CURRENT_VIEW = Keyboard.numbersView
        default:
            break
        }
    }
    
    func tapMushroom(){
        self.keyboard.buttons.element(boundBy: 0).tap()
        self.CURRENT_VIEW = Keyboard.settingsView
    }
    
    func tapDelete(){
        //element not visible in iOS 11
        if self.CURRENT_VIEW == Keyboard.numbersView{
            self.keyboard.images.element(boundBy: 4).tap()
        }else{
            self.keyboard.images.element(boundBy: 3).tap()
        }
    }
    
    func tapGlobe(){
        //element not visible in iOS 11
        if self.CURRENT_VIEW == Keyboard.numbersView{
            self.keyboard.images.element(boundBy: 5).tap()
        }else{
            self.keyboard.images.element(boundBy: 4).tap()
        }
    }
    
    func tapEmoji(){
        //element not visible in iOS 11
        if self.CURRENT_VIEW == Keyboard.numbersView{
            self.keyboard.images.element(boundBy: 6).tap()
        }else{
            self.keyboard.images.element(boundBy: 5).tap()
        }
    }
        
    func tapJpToEn(){
        self.keyboard.staticTexts[Keyboard.jpToEn].tap()
    }
    
    func tapNumbers(){
        self.keyboard.staticTexts[Keyboard.numbers].tap()
    }
    
    func tapNextCandidate(){
        self.keyboard.staticTexts[Keyboard.nextCandidate].tap()
    }
    
    func tapEnter(){
        self.keyboard.staticTexts[Keyboard.enter].tap()
    }
    
    func isNineGrid() -> Bool{
        return self.keyboard.staticTexts[Keyboard.symbol].exists
    }
    
    func isFullKeyboard() -> Bool{
        return self.keyboard.staticTexts["ー"].exists
    }
    
    func isFullKeyboardEnglishView() -> Bool{
        return self.keyboard.staticTexts["5"].exists && (self.keyboard.staticTexts["t"].exists || self.keyboard.staticTexts["T"].exists)
    }
    
    func isLowerCase() -> Bool{
        return (self.keyboard.staticTexts["q"].exists && self.keyboard.staticTexts["d"].exists && self.keyboard.staticTexts["c"].exists)
    }
    
    func isCandidatesShown() -> Bool{
        return self.keyboard.scrollViews.count > 0
    }
    
    func isNumberView() -> Bool{
        return (self.keyboard.staticTexts["1"].exists && self.keyboard.staticTexts[":"].exists)
    }
    
    func isPunctuationView() -> Bool {
        return (self.keyboard.staticTexts["["].exists && self.keyboard.staticTexts["|"].exists)
    }
    
    func checkCurrentView(){
        if isNineGrid(){
            self.CURRENT_VIEW = Keyboard.nineGridView
        }else if isFullKeyboard(){
            self.CURRENT_VIEW = Keyboard.fullKeyboradView
        }else if isFullKeyboardEnglishView(){
            self.CURRENT_VIEW = Keyboard.fullKeyboardEnglishView
        }else if isNumberView(){
            self.CURRENT_VIEW = Keyboard.numbersView
        }else if isPunctuationView(){
            self.CURRENT_VIEW = Keyboard.punctuationView
        }else{
            debugPrint("DEBUG: not support!")
            raise(1)
        }
    }
    
    func nineGridToFullKeyboard(){
        sleep(3)    //蘑菇动画
        tapMushroom()
        self.keyboard.staticTexts["键盘类型"].tap()
        self.keyboard.buttons.element(boundBy: self.keyboard.buttons.count - 3).tap()
        tapMushroom()
        self.CURRENT_VIEW = Keyboard.fullKeyboradView
    }

    func getCandidates() -> [String]{
        var candidates: [String] = []
        for i in 0...self.candidatesScrollViews.staticTexts.count - 1{
            let e = self.candidatesScrollViews.staticTexts.element(boundBy: i)
            if e.exists{
                candidates.append(e.label)
            }else{
                debugPrint("DEBUG: candidates not exists!!")
            }
        }
        return candidates
    }
}
