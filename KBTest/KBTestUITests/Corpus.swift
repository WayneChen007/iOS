//
//  FileUtil.swift
//  KBTestUITests
//
//  Created by Wayne on 2018/6/7.
//  Copyright © 2018年 Wayne. All rights reserved.
//
import UIKit

class Corpus{
    var line: String
    var times: Int
    var splitedLine: [Substring] = []
    var separator: [String] = ["\t", " "]
    
    init(fromLine line: String, intoSegments times: Int=3) {
        self.line = line
        self.times = times
        self.splitedLine = self.toSplitFromLine()!
    }
    
    private func toSplitFromLine() -> [Substring]?{
        var sl: [Substring] = []
        if self.line.contains("\t"){
            sl = self.line.split(separator: "\t")
        }else if line.contains(" "){
            sl = self.line.split(separator: " ")
        }else{
            debugPrint("DEBUG: no separator, cannot split line")
        }
        return sl.count == self.times ? sl: nil
    }
    
    func getInputText() -> Substring?{
        return self.splitedLine.count == self.times ? self.splitedLine[0]: nil
    }
    
    func getExpectText() -> Substring?{
        return self.splitedLine.count == self.times ? self.splitedLine[1]: nil
    }
    
    func getWeights() -> Substring?{
        return self.splitedLine.count == self.times ? self.splitedLine[2]: nil
    }
}
