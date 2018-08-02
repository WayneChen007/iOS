//
//  SimejiUITests.swift
//  SimejiUITests
//
//  Created by Wayne on 2018/6/4.
//  Copyright © 2018年 Wayne. All rights reserved.
//

import XCTest

class SimejiUITests: XCTestCase {
    
    let app: XCUIElement = XCUIApplication()
    var lowerCase: Bool = false
    let docResultFile = "result.txt"
    var keyPropertyList: [KeyProperty] = []
    let sandbox = Sandbox()

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
        if sandbox.fileExists(dir: sandbox.doc, fileName: docResultFile){
            print("DEBUG: 沙盒文件存在，是否邮件发送失败?!")
            return
        }else{
            sandbox.creatFile(to: sandbox.doc, fileName: docResultFile)
        }
    }
    
    override func tearDown() {
        super.tearDown()
    }
        
    func testExample() {
        doKeyboardPullUp()
        let path: String = Bundle(for: type(of: self)).path(forResource: "kana_freq", ofType: ".txt")!
        let s = StreamReader(file: path)
        sleep(5)
        let kb: Keyboard = Keyboard(fromKeyboardWindows: self.app.windows.element(boundBy: 3))
        kb.checkCurrentView()
        if kb.CURRENT_VIEW == Keyboard.nineGridView{
            kb.nineGridToFullKeyboard()
        }
        if kb.isLowerCase(){lowerCase = true}
        for index in 1...1500 {
            if let line = s?.nextLine() {
                let corpus: Corpus = Corpus(fromLine: line, intoSegments: 2)
                var notFullKeyboardInputType: Bool = false
                var kanaInText: Bool = false
                if let inputText = corpus.getInputText() {
                    keyPropertyList.removeAll()
                    for text in inputText{
                        if let p: KeyProperty = identifyProperty(fromString: String(text)){
                            if p.getClass() == Kana.KANA{
                                kanaInText = true
                                keyPropertyList.append(p)
                            }else{
                                if kanaInText{
                                    notFullKeyboardInputType = true
                                    debugPrint("DEBUG: 非全键盘语料，不作处理  \(line)")
                                }else{
                                    keyPropertyList.append(p)
                                }
                            }
                        }else{
                            debugPrint("DEBUG: 不识别的字符\(text)")
                        }
                    }
                    if !keyPropertyList.isEmpty && !notFullKeyboardInputType{
                        toTap(fromKeyPropertyList: keyPropertyList, using: kb)
                    }
                    if kb.isCandidatesShown() && !notFullKeyboardInputType{
                        let candidates = kb.getCandidates()
                        if let expectText = corpus.getExpectText(){
                            if !candidates.contains(String(expectText)){
                                sandbox.fileAppend(fromText: "\(index)\t\(inputText)\t\(expectText)\t\(candidates)\n",
                                    toDir: sandbox.doc, fileName: docResultFile)
                            }
                        }
                    }
                }else{
                    debugPrint("DEBUG: 语料错误\(line)")
                    continue
                }
                doClear()
            }
        }
        if let str: String = sandbox.readFile(fromDir: sandbox.doc, fileName: docResultFile){
            UIPasteboard.general.string = str
            doSend()
            sandbox.removeFile(fromDir: sandbox.doc, fileName: docResultFile)
        }else{
            debugPrint("DEBUG: 沙盒文件读取失败！")
        }
        sleep(5000)
    }
    
    func toTap(fromKeyPropertyList keyPropertyList: [KeyProperty], using keyboard: Keyboard){
        for keyProperty in keyPropertyList{
            if keyProperty.getClass() == Kana.KANA{
                keyboard.onTapKana(fromProperty: keyProperty, lowerCase: lowerCase)
            }else if keyProperty.getClass() == NOS.SYMBOL{
                if keyProperty.getType() == Kana.HIRAGANA{
                    if keyProperty.getKey() == "、"{
                        keyboard.tapGlobe()
                    }else if keyProperty.getKey() == "。"{
                        keyboard.tapEmoji()
                    }
                }else{
                    keyboard.onTapNOS(fromProperty: keyProperty)
                }
            }
        }
    }
    
    func identifyProperty(fromString string: String) -> KeyProperty?{
        let property: KeyProperty = KeyProperty()
        if Kana.isHiragana(fromText: string){
            property.setProperty(proprety: Kana.Hiragana[string]!)
        }else if Kana.isKatakana(fromText: string){
            property.setProperty(proprety: Kana.Katakana[string]!)
        }else if NOS.isNumbers(fromString: string){
            property.setProperty(proprety: NOS.numbers[string]!)
        }else if NOS.isSymbol(fromString: string){
            property.setProperty(proprety: NOS.symbol[string]!)
        }else{
            return nil
        }
        return property
    }
    
    func doKeyboardPullUp(){
        self.app.windows.element(boundBy: 0).textViews.element(boundBy: 0).tap()
    }
    
    func doClear(){
        self.app.windows.element(boundBy: 0).buttons.element(boundBy: 2).tap()
    }
    
    func doCopy(){
        self.app.windows.element(boundBy: 0).buttons.element(boundBy: 0).tap()
    }
    
    func doSend(){
        self.app.windows.element(boundBy: 0).buttons.element(boundBy: 1).tap()
    }
}
