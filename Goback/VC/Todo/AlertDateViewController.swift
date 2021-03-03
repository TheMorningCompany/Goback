//
//  AlertDateViewController.swift
//  DatePicker
//
//  Created by Zeqiel Golomb on 2/24/21.
//

import UIKit

class AlertDateViewController: UITableViewController {

    @IBOutlet weak var dayAmPmToggle: UIButton!
    @IBOutlet weak var longBeforeAmPmToggle: UIButton!
    
    @IBOutlet weak var dayOfSwitch: UISwitch!
    @IBOutlet weak var longBeforeSwitch: UISwitch!
    @IBOutlet weak var atTimeSwitch: UISwitch!
    
    @IBOutlet weak var dayOfCell: UITableViewCell!
    @IBOutlet weak var longBeforeCell: UITableViewCell!
    
    @IBOutlet weak var descLabel: UILabel!
    
    var heavyClick = UIImpactFeedbackGenerator(style: .heavy)
    var lightClick = UIImpactFeedbackGenerator(style: .light)
    
    var longBefore = false
    var atTime = true
    var dayOf = false
    
    var selectedDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func toggleAmPmDay(_ sender: Any) {
        if dayAmPmToggle.titleLabel?.text == "am" {
            DayAmPmSizeChange()
            dayAmPmToggle.setTitle("pm", for: .normal)
        } else {
            DayAmPmSizeChange()
            dayAmPmToggle.setTitle("am", for: .normal)
        }
    }
    
    func DayAmPmSizeChange() {
        lightClick.impactOccurred()
        UIView.animate(withDuration: 0.2, animations: {
            self.dayAmPmToggle.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        }) { (finished) in
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 50, options: .curveEaseInOut, animations: {
            self.dayAmPmToggle.transform = CGAffineTransform.identity
        })
            self.heavyClick.impactOccurred()
        }
        
    }
    
    @IBAction func toggleAmPmLongBefore(_ sender: Any) {
        if dayAmPmToggle.titleLabel?.text == "am" {
            BeforeAmPmSizeChange()
            longBeforeAmPmToggle.setTitle("pm", for: .normal)
        } else {
            BeforeAmPmSizeChange()
            longBeforeAmPmToggle.setTitle("am", for: .normal)
        }
    }
    
    func BeforeAmPmSizeChange() {
        lightClick.impactOccurred()
        UIView.animate(withDuration: 0.2, animations: {
            self.longBeforeAmPmToggle.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        }) { (finished) in
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 50, options: .curveEaseInOut, animations: {
            self.longBeforeAmPmToggle.transform = CGAffineTransform.identity
        })
            self.heavyClick.impactOccurred()
        }
        
    }

    
    @IBAction func dayOfSwitchChange(_ sender: Any) {
        if dayOfSwitch.isOn {
            dayOf = true
        } else {
            dayOf = false
        }
        
        animateDescLabel()
    }

    
    @IBAction func longBeforeSwitchChange(_ sender: Any) {
        if longBeforeSwitch.isOn {
            longBefore = true
        } else {
            longBefore = false
        }
        
        animateDescLabel()
    }
    
    @IBAction func atTimeSwitchChange(_ sender: Any) {
        if atTimeSwitch.isOn {
            atTime = true
        } else {
            atTime = false
        }
        
        animateDescLabel()
    }
    
    //change these to use actual time values maybe
    func setDescLabel() {
        if atTime == true && longBefore == true && dayOf == true {
            descLabel.text = "alert me at set time, earlier in the day, and long before."
        }
        if atTime == true && longBefore == true && dayOf == false {
            descLabel.text = "alert me at set time and long before."
        }
        if atTime == false && longBefore == true && dayOf == true {
            descLabel.text = "alert me earlier in the day and long before."
        }
        if atTime == true && longBefore == false && dayOf == true {
            descLabel.text = "alert me at set time and earlier in the day"
        }
        if atTime == false && longBefore == false && dayOf == true {
            descLabel.text = "alert me earlier in the day"
        }
        if atTime == true && longBefore == false && dayOf == false {
            descLabel.text = "alert me at set time"
        }
        if atTime == false && longBefore == true && dayOf == false {
            descLabel.text = "alert me long before"
        }
        if atTime == false && longBefore == false && dayOf == false {
            descLabel.text = "don't alert me ever"
        }
    }
    
    func animateDescLabel() {
        UIView.animate(withDuration: 0.25, animations: {
            self.descLabel.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
        }) { (finished) in
            self.descLabel.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width * -1, y: 0)
            self.setDescLabel()
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 15, options: .curveEaseInOut, animations: {
                self.descLabel.transform = CGAffineTransform.identity
        })
            
        }
        
    }
    
    @IBAction func save(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: DAYCHANGE_NOTIFICATION, object: self.selectedDate)
    }
    
    
    
    
    
}
