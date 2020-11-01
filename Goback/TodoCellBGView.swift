//
//  TodoCellBGView.swift
//  Goback
//
//  Created by Zeqiel Golomb on 10/31/20.
//  Copyright © 2020 Zeqe Golomb. All rights reserved.
//

import UIKit

class TodoCellBGView: UIView {

    override func awakeFromNib() {
       
        layer.cornerRadius = 20.0
        layer.masksToBounds = true
        
    }

}
