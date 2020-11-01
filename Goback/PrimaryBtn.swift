//
//  PrimaryBtn.swift
//  Goback
//
//  Created by Zeqiel Golomb on 11/1/20.
//  Copyright © 2020 Zeqe Golomb. All rights reserved.
//

import UIKit

class PrimaryBtn: UIButton {

    override open var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor(named: "Green") : UIColor(named: "GreenHighlight")
        }
    }
    override open var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled ? UIColor(named: "Green") : UIColor(named: "GreenDisable")
        }
    }

}
