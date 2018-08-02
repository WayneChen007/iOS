//
//  Mail.swift
//  KBTest
//
//  Created by Wayne on 2018/6/28.
//  Copyright © 2018年 Wayne. All rights reserved.
//

import Foundation
import skpsmtpmessage

class Mail: SKPSMTPMessageDelegate {
    func sendMail(str: String){
        let testSend = SKPSMTPMessage()
        testSend.fromEmail = "***@***.com"
        testSend.toEmail = "***@***.com"
        testSend.relayHost = "example.email.com";
        testSend.requiresAuth = true;
        testSend.login = "account"
        testSend.pass = "password"
        testSend.subject = "语料自动化测试结果"
        testSend.wantsSecure = true;
        testSend.delegate = self;
        let dic = [kSKPSMTPPartContentTypeKey: "text/plain", kSKPSMTPPartMessageKey: str, kSKPSMTPPartContentTransferEncodingKey:"8bit"]
        testSend.parts = [dic]
        testSend.send()
    }
    
    func messageSent(_ message: SKPSMTPMessage!) {
        print("success")
    }
    
    func messageFailed(_ message: SKPSMTPMessage!, error: Error!) {
        print("error: \(error)")
    }
}
