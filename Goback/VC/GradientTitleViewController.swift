//
//  GradientTitleViewController.swift
//  Goback
//
//  Created by Zeqiel Golomb on 11/1/20.
//  Copyright © 2020 Zeqe Golomb. All rights reserved.
//

import UIKit
import SwiftUI

class GradientTitleViewController: UIHostingController<GradientTitleBar> {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: GradientTitleBar())
    }

}
