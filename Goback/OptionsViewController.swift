//
//  OptionsViewController.swift
//  Goback
//
//  Created by Zeqiel Golomb on 2/28/20.
//  Copyright © 2020 Zeqe Golomb. All rights reserved.
//

import UIKit

class OptionsViewController: UIViewController {
    
    var impact = UIImpactFeedbackGenerator()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func doHaptic() {
        if (UserDefaults.standard.bool(forKey: "enable_haptics")) {
            impact.impactOccurred()
        }
    }


    @IBAction func didTapLightIcon(_ sender: UIButton) {
        doHaptic()
        UIApplication.shared.setAlternateIconName("green")
    }
    @IBAction func didTapDarkIcon(_ sender: UIButton) {
        doHaptic()
        UIApplication.shared.setAlternateIconName("dark")
    }
    @IBAction func didTapGreenIcon(_ sender: UIButton) {
        doHaptic()
        UIApplication.shared.setAlternateIconName(nil)
    }
    @IBAction func didTapShadowIcon(_ sender: UIButton) {
        doHaptic()
        UIApplication.shared.setAlternateIconName("shadow")
    }
    @IBAction func didTapGlyphIcon(_ sender: UIButton) {
        doHaptic()
        UIApplication.shared.setAlternateIconName("glyph")
    }
    @IBAction func didTapFadeIcon(_ sender: UIButton) {
        doHaptic()
        UIApplication.shared.setAlternateIconName("fade")
    }

}
