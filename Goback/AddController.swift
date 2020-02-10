//
//  AddController.swift
//  Goback
//
//  Created by Zeqiel Golomb on 2/9/20.
//  Copyright © 2020 Zeqe Golomb. All rights reserved.
//

import UIKit

class AddController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func addButton(_ sender: UIButton) {
        if (textField.text != nil) && textField.text != "" {
            todoList?.append(textField.text!)
            textField.text = ""
            textField.placeholder = "add something"
        }
    
    
    
    }
    

}
