//
//  RSSSubscribeViewController.swift
//  Goback
//
//  Created by Zeqiel Golomb on 11/5/20.
//  Copyright © 2020 Zeqe Golomb. All rights reserved.
//

import UIKit

class RSSSubscribeViewController: UIViewController {

    @IBOutlet weak var titleBG: UIView!
    @IBOutlet weak var textBG: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Round Corners
        self.titleBG.layer.cornerRadius = 20.0
        self.titleBG.layer.cornerCurve = .continuous
        titleBG.layer.masksToBounds = true
        
        self.textBG.layer.cornerRadius = 20.0
        self.textBG.layer.cornerCurve = .continuous
        
        isModalInPresentation = true
    }
    
    @IBAction func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    

}
