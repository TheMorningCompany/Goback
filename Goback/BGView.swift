//
//  BGView.swift
//  DatePicker
//
//  Created by Zeqiel Golomb on 2/22/21.
//

import UIKit

class BGView: UIView {

    override func awakeFromNib() {
        layer.cornerCurve = .continuous
        layer.cornerRadius = 20
        clipsToBounds = true
    }

}
