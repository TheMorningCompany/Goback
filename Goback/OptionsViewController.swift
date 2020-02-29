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
        UIApplication.shared.setAlternateIconName(nil)
    }
    @IBAction func didTapDarkIcon(_ sender: UIButton) {
        doHaptic()
        UIApplication.shared.setAlternateIconName("darkicon")
    }
    @IBAction func didTapGreenIcon(_ sender: UIButton) {
        doHaptic()
        UIApplication.shared.setAlternateIconName("greenicon")
    }
    @IBAction func didTapShadowIcon(_ sender: UIButton) {
        doHaptic()
        UIApplication.shared.setAlternateIconName("shadowicon")
    }
    @IBAction func didTapGlyphIcon(_ sender: UIButton) {
        doHaptic()
        UIApplication.shared.setAlternateIconName("glyphicon")
    }
    @IBAction func didTapFadeIcon(_ sender: UIButton) {
        doHaptic()
        UIApplication.shared.setAlternateIconName("fadeicon")
    }

}
