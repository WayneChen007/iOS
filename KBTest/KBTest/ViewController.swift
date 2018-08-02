//
//  ViewController.swift
//  Simeji
//
//  Created by Wayne on 2018/6/4.
//  Copyright © 2018年 Wayne. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func clear(_ sender: UIButton) {
        textField.text = ""
    }
    
    @IBAction func Copy(_ sender: UIButton) {
        UIPasteboard.general.string = textField.text
    }
    
    @IBAction func sendMail(_ sender: UIButton) {
        if let str = UIPasteboard.general.string{
            Mail().sendMail(str: str)
        }else{
            print("DEBUG: Pasteboard is nil")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
