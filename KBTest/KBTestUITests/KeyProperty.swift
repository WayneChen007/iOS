//
//  KeyProperty.swift
//  SimejiUITests
//
//  Created by Wayne on 2018/6/5.
//  Copyright © 2018年 Wayne. All rights reserved.
//

class KeyProperty{
    var proprety: Dictionary<String, Any> = [:]
    
    func setProperty(proprety: Dictionary<String, Any>){
        self.proprety = proprety
    }
    
    func getProperty() -> Dictionary<String, Any>{
        return proprety
    }

    func getKey() -> String{
        return proprety["key"] as! String
    }
    
    func getClass() -> Int{
        return proprety["class"] as! Int
    }
    
    func getType() -> Int{
        return proprety["type"] as! Int
    }
}
