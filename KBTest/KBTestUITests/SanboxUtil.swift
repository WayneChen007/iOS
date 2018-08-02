//
//  SanboxUtil.swift
//  KBTestUITests
//
//  Created by Wayne on 2018/6/22.
//  Copyright © 2018年 Wayne. All rights reserved.
//

import Foundation

class Sandbox{
    
    let utf8 = String.Encoding.utf8
    let fileManager = FileManager.default
    let home = NSHomeDirectory() as NSString
    let doc = (NSHomeDirectory() + "/Documents") as NSString
    let library = (NSHomeDirectory() + "/Library") as NSString
    
    func fileExists(dir: NSString, fileName: String) -> Bool{
        return fileManager.fileExists(atPath: dir.appendingPathComponent(fileName))
    }
    
    func creatFile(to dir: NSString, fileName: String){
        fileManager.createFile(atPath: dir.appendingPathComponent(fileName), contents: nil, attributes: nil)
    }
    
    func removeFile(fromDir dir: NSString, fileName: String) -> Bool{
        do {
            try fileManager.removeItem(atPath: dir.appendingPathComponent(fileName))
        } catch {
            return false
        }
        return true
    }
    
    func clearFile(fromDir dir: NSString, fileName: String){
        if let fileHandle = FileHandle(forWritingAtPath: dir.appendingPathComponent(fileName)){
            fileHandle.write("".data(using: utf8)!)
        }
    }
    
    func readFile(fromDir dir: NSString, fileName: String) -> String?{
        if let fileHandle = FileHandle(forReadingAtPath: dir.appendingPathComponent(fileName)){
            defer { fileHandle.closeFile() }
            return String(data: fileHandle.readDataToEndOfFile(), encoding: utf8)
        }else{
            return nil
        }
    }
 
    func fileAppend(fromText text: String, toDir dir: NSString, fileName: String){
        if let fileHandle = FileHandle(forWritingAtPath: dir.appendingPathComponent(fileName)) {
            fileHandle.seekToEndOfFile()
            fileHandle.write(text.data(using: utf8)!)
            fileHandle.closeFile()
        }else {
            print("Can't open fileHandle")
        }
    }
}
