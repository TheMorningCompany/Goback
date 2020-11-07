//
//  TodoTextColorViewController.swift
//  Goback
//
//  Created by Zeqiel Golomb on 11/2/20.
//  Copyright © 2020 Zeqe Golomb. All rights reserved.
//

import UIKit

class TodoTextColorViewController: UIViewController {
  
    @IBOutlet weak var titleBG: UIView!
    
    @IBOutlet weak var defaultView: TextColorBtn!
    @IBOutlet weak var pinkView: TextColorBtn!
    @IBOutlet weak var orangeView: TextColorBtn!
    @IBOutlet weak var yellowView: TextColorBtn!
    @IBOutlet weak var greenView: TextColorBtn!
    @IBOutlet weak var blueView: TextColorBtn!
    @IBOutlet weak var darkblueView: TextColorBtn!
    @IBOutlet weak var purpleView: TextColorBtn!
    
    var color = "Default"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Round Header BG
        self.titleBG.layer.cornerRadius = 20.0
        self.titleBG.layer.cornerCurve = .continuous
        titleBG.layer.masksToBounds = true
    
    }

    @IBAction func defaultColor(_ sender: Any) {
        color = "Default"
        dismiss(animated: true)
        NotificationCenter.default.post(name: COLOR_NOTIFICATION, object: color)
    }
    @IBAction func pinkColor(_ sender: Any) {
        color = "Pink"
        dismiss(animated: true)
        NotificationCenter.default.post(name: COLOR_NOTIFICATION, object: color)
    }
    @IBAction func orangeColor(_ sender: Any) {
        color = "Orange"
        dismiss(animated: true)
        NotificationCenter.default.post(name: COLOR_NOTIFICATION, object: color)
    }
    @IBAction func yellowColor(_ sender: Any) {
        color = "Yellow"
        dismiss(animated: true)
        NotificationCenter.default.post(name: COLOR_NOTIFICATION, object: color)
    }
    @IBAction func greenColor(_ sender: Any) {
        color = "Green"
        dismiss(animated: true)
        NotificationCenter.default.post(name: COLOR_NOTIFICATION, object: color)
    }
    @IBAction func blueColor(_ sender: Any) {
        color = "Blue"
        dismiss(animated: true)
        NotificationCenter.default.post(name: COLOR_NOTIFICATION, object: color)
    }
    @IBAction func darkblueColor(_ sender: Any) {
        color = "DarkBlue"
        dismiss(animated: true)
        NotificationCenter.default.post(name: COLOR_NOTIFICATION, object: color)
    }
    @IBAction func purpleColor(_ sender: Any) {
        color = "Purple"
        dismiss(animated: true)
        NotificationCenter.default.post(name: COLOR_NOTIFICATION, object: color)
    }
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true)
        
    }
    
}
