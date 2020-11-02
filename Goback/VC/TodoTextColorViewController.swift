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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Round Header BG
        self.titleBG.layer.cornerRadius = 20.0
        self.titleBG.layer.cornerCurve = .continuous
        titleBG.layer.masksToBounds = true
    }


}
