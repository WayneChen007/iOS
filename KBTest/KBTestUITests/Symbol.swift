//
//  Symbol.swift
//  SimejiUITests
//
//  Created by Wayne on 2018/6/6.
//  Copyright © 2018年 Wayne. All rights reserved.
//

class NOS{
    
    static let SYMBOL: Int = 2
    static let NUMBER: Int = 3
    static let PUNCTUATION: Int = 4
    
    static func isNOS(fromString string: String) -> Bool{
        return (isNumbers(fromString: string) || isSymbol(fromString: string))
    }
    
    static func isNumbers(fromString string: String) -> Bool{
        return numbers[string] != nil ? true: false
    }
    
    static func isSymbol(fromString string: String) -> Bool{
        return symbol[string] != nil ? true: false
    }
    
    static let numbers = ["1": ["key": "1", "class": SYMBOL, "type": NUMBER],
                          "2": ["key": "2", "class": SYMBOL, "type": NUMBER],
                          "3": ["key": "3", "class": SYMBOL, "type": NUMBER],
                          "4": ["key": "4", "class": SYMBOL, "type": NUMBER],
                          "5": ["key": "2", "class": SYMBOL, "type": NUMBER],
                          "6": ["key": "2", "class": SYMBOL, "type": NUMBER],
                          "7": ["key": "2", "class": SYMBOL, "type": NUMBER],
                          "8": ["key": "2", "class": SYMBOL, "type": NUMBER],
                          "9": ["key": "2", "class": SYMBOL, "type": NUMBER],
                          "0": ["key": "2", "class": SYMBOL, "type": NUMBER]]
    
    static let symbol = ["-": ["key": "-", "class": SYMBOL, "type": NUMBER],
                         "/": ["key": "/", "class": SYMBOL, "type": NUMBER],
                         ":": ["key": ":", "class": SYMBOL, "type": NUMBER],
                         "@": ["key": "@", "class": SYMBOL, "type": NUMBER],
                         "(": ["key": "(", "class": SYMBOL, "type": NUMBER],
                         ")": ["key": ")", "class": SYMBOL, "type": NUMBER],
                         "「": ["key": "「", "class": SYMBOL, "type": NUMBER],
                         "」": ["key": "」", "class": SYMBOL, "type": NUMBER],
                         "¥": ["key": "¥", "class": SYMBOL, "type": NUMBER],
                         "&": ["key": "&", "class": SYMBOL, "type": NUMBER],
                         ".": ["key": ".", "class": SYMBOL, "type": NUMBER],
                         ",": ["key": ",", "class": SYMBOL, "type": NUMBER],
                         "。": ["key": "。", "class": SYMBOL, "type": NUMBER],
                         "、": ["key": "、", "class": SYMBOL, "type": NUMBER],
                         "?": ["key": "?", "class": SYMBOL, "type": NUMBER],
                         "!": ["key": "!", "class": SYMBOL, "type": NUMBER],
                         "[": ["key": "[", "class": SYMBOL, "type": PUNCTUATION],
                         "]": ["key": "]", "class": SYMBOL, "type": PUNCTUATION],
                         "{": ["key": "{", "class": SYMBOL, "type": PUNCTUATION],
                         "}": ["key": "}", "class": SYMBOL, "type": PUNCTUATION],
                         "#": ["key": "#", "class": SYMBOL, "type": PUNCTUATION],
                         "%": ["key": "%", "class": SYMBOL, "type": PUNCTUATION],
                         "^": ["key": "^", "class": SYMBOL, "type": PUNCTUATION],
                         "*": ["key": "*", "class": SYMBOL, "type": PUNCTUATION],
                         "+": ["key": "+", "class": SYMBOL, "type": PUNCTUATION],
                         "=": ["key": "=", "class": SYMBOL, "type": PUNCTUATION],
                         "_": ["key": "_", "class": SYMBOL, "type": PUNCTUATION],
                         "\\": ["key": "\\", "class": SYMBOL, "type": PUNCTUATION],
                         ";": ["key": ";", "class": SYMBOL, "type": PUNCTUATION],
                         "|": ["key": "|", "class": SYMBOL, "type": PUNCTUATION],
                         "<": ["key": "<", "class": SYMBOL, "type": PUNCTUATION],
                         ">": ["key": ">", "class": SYMBOL, "type": PUNCTUATION],
                         "\"": ["key": "\"", "class": SYMBOL, "type": PUNCTUATION],
                         "'": ["key": "'", "class": SYMBOL, "type": PUNCTUATION],
                         "$": ["key": "$", "class": SYMBOL, "type": PUNCTUATION],
                         "€": ["key": "€", "class": SYMBOL, "type": PUNCTUATION],
                         "・": ["key": "・", "class": SYMBOL, "type": PUNCTUATION]]
}
