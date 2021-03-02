//
//  Timer.swift
//  Timemark
//
//  Created by Zeqiel Golomb on 2/8/20.
//  Copyright © 2020 Zeqe Golomb. All rights reserved.
//

import AVFoundation
import UIKit

class DateChooser: UITableViewController, UITextFieldDelegate {
   
    let notification = UINotificationFeedbackGenerator()
    var time = Timer()
    var selectedDate = Date()
    
    @IBOutlet weak var fieldh: UITextField!
    @IBOutlet weak var fieldm: UITextField!
    @IBOutlet weak var amPmToggle: UIButton!
    @IBOutlet weak var ampmW: NSLayoutConstraint!
    @IBOutlet weak var ampmH: NSLayoutConstraint!
    @IBOutlet weak var blBtn: UIButton!
    @IBOutlet weak var brBtn: UIButton!
    @IBOutlet weak var tlBtn: UIButton!
    @IBOutlet weak var trBtn: UIButton!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    
    var heavyClick = UIImpactFeedbackGenerator(style: .heavy)
    var lightClick = UIImpactFeedbackGenerator(style: .light)
    
    var fieldText = "0015"
    var secs = 15
    var mins = 0
    
    var date = Date()
    var calendar = Calendar.current
    var hour = 12
    var minutes = 35
    
    var minsCountdown = 0
    var totalCountdown = 15
    
//    var initialTime:Int = 5
//    var currentTime:Int = 0
    var startTime:Date = Date()
    var endTime:Date = Date()
    var timerStopped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Picker
        fieldh.delegate = self
        fieldm.delegate = self
        
        fieldh.clearsOnBeginEditing = true
        fieldm.clearsOnBeginEditing = true
        
        fieldh.clearsOnInsertion = true
        fieldm.clearsOnInsertion = true
        
        fieldh.addTarget(self, action: #selector(editingChanged(sender:)), for: .editingChanged)
        fieldm.addTarget(self, action: #selector(editingChanged(sender:)), for: .editingChanged)
        
        date = Date()
        calendar = Calendar.current
        hour = calendar.component(.hour, from: date)
        minutes = calendar.component(.minute, from: date)
        if hour > 12 {
            amPmToggle.setTitle("pm", for: .normal)
        } else {
            amPmToggle.setTitle("am", for: .normal)
        }
        
        fieldh.text = String(hour)
        
        if String(minutes).count == 2 {
            fieldm.text = String(minutes)
        } else {
            fieldm.text = "0\(String(minutes))"
        }
        print(hour)
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
            return false
        }
        return true
    }
    
    @objc private func editingChanged(sender: UITextField) {

        if let text = sender.text, text.count >= 3 {
            sender.text = String(text.dropLast(text.count - 2))
            return
        }
        if fieldh.text!.count >= 2 {
            
            mins = Int(fieldh.text!)!
            minsCountdown = mins * 60
            
            secs = Int(fieldm.text!)!
            totalCountdown = mins + minsCountdown
            
            fieldh.resignFirstResponder()
            fieldm.becomeFirstResponder()
            let colon = ":"
            
            let userVisible = String(mins)+colon+String(secs)
            
            UserDefaults.standard.set(userVisible, forKey: "timer1")
        }
        if fieldm.text!.count >= 2 {
            fieldm.resignFirstResponder()
            
            mins = Int(fieldh.text!)!
            minsCountdown = mins * 60
            
            secs = Int(fieldm.text!)!
            totalCountdown = secs + minsCountdown
            let colon = ":"
            
            let userVisible = String(mins)+colon+String(secs)
            
            UserDefaults.standard.set(userVisible, forKey: "timer1")
        }
        
        if fieldm.text!.count <= 2 || fieldh.text!.count <= 2 {
            mins = Int(fieldh.text!) ?? 0
            minsCountdown = mins * 60
            
            secs = Int(fieldm.text!) ?? 0
            totalCountdown = secs + minsCountdown
            let colon = ":"
            
            let userVisible = String(mins)+colon+String(secs)
            
            UserDefaults.standard.set(userVisible, forKey: "timer1")
        }
    }
    
    @IBAction func toggleAmPm(_ sender: Any) {
        if amPmToggle.titleLabel?.text == "am" {
            amPmSizeChange()
            
            amPmToggle.setTitle("pm", for: .normal)
        } else {
            amPmSizeChange()
            
            amPmToggle.setTitle("am", for: .normal)
        }
    }
    
    func amPmSizeChange() {
        lightClick.impactOccurred()
        UIView.animate(withDuration: 0.2, animations: {
            self.amPmToggle.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        }) { (finished) in
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 50, options: .curveEaseInOut, animations: {
            self.amPmToggle.transform = CGAffineTransform.identity
        })
            self.heavyClick.impactOccurred()
        }
        
    }
    
    @IBAction func topLeftSize(_ sender: Any) {
        lightClick.impactOccurred()
        UIView.animate(withDuration: 0.2, animations: {
            self.tlBtn.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        }) { (finished) in
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 50, options: .curveEaseInOut, animations: {
            self.tlBtn.transform = CGAffineTransform.identity
        })
            self.heavyClick.impactOccurred()
        }
    }
    @IBAction func bottomLeftSize(_ sender: Any) {
        lightClick.impactOccurred()
        UIView.animate(withDuration: 0.2, animations: {
            self.blBtn.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        }) { (finished) in
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 50, options: .curveEaseInOut, animations: {
            self.blBtn.transform = CGAffineTransform.identity
        })
            self.heavyClick.impactOccurred()
        }
    }
    @IBAction  func topRightSize(_ sender: Any) {
        lightClick.impactOccurred()
        UIView.animate(withDuration: 0.2, animations: {
            self.trBtn.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        }) { (finished) in
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 50, options: .curveEaseInOut, animations: {
            self.trBtn.transform = CGAffineTransform.identity
        })
            self.heavyClick.impactOccurred()
        }
    }
    @IBAction  func bottomRightSize(_ sender: Any) {
        lightClick.impactOccurred()
        UIView.animate(withDuration: 0.2, animations: {
            self.brBtn.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        }) { (finished) in
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 50, options: .curveEaseInOut, animations: {
            self.brBtn.transform = CGAffineTransform.identity
        })
            self.heavyClick.impactOccurred()
        }
    }
    
    
    //Month Change
    func monthBack() {
        UIView.animate(withDuration: 0.25, animations: {
            self.monthLabel.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
        }) { (finished) in
            self.monthLabel.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width * -1, y: 0)
            UIView.animate(withDuration: 0.4, animations: {
                self.setMonthLabel()
            self.monthLabel.transform = CGAffineTransform.identity
        })
            
        }
        
    }
    func monthForward() {
        UIView.animate(withDuration: 0.25, animations: {
            self.monthLabel.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width * -1, y: 0)
        }) { (finished) in
            self.monthLabel.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
            UIView.animate(withDuration: 0.4, animations: {
                self.setMonthLabel()
            self.monthLabel.transform = CGAffineTransform.identity
        })
            
        }
        
    }
    func setMonthLabel() {
        monthLabel.text = CalHelper().monthString(date: selectedDate).lowercased()
            + " " + CalHelper().yearString(date: selectedDate).lowercased()
    }
    
    @IBAction func prevMonth(_ sender: Any) {
        selectedDate = CalHelper().minusMonth(date: selectedDate)
        monthBack()
    }
    @IBAction func nextMonth(_ sender: Any) {
        selectedDate = CalHelper().plusMonth(date: selectedDate)
        monthForward()
    }
    
    
    
    //Day change
    
    func setDayLabel() {
        dayLabel.text = CalHelper().dayString(date: selectedDate)
    }
    
    
    func dayBack() {
        UIView.animate(withDuration: 0.25, animations: {
            self.dayLabel.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
        }) { (finished) in
            self.dayLabel.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width * -1, y: 0)
            UIView.animate(withDuration: 0.4, animations: {
                self.setDayLabel()
                self.dayLabel.transform = CGAffineTransform.identity
        })
        }
    }
    func dayForward() {
        UIView.animate(withDuration: 0.25, animations: {
            self.dayLabel.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width * -1, y: 0)
        }) { (finished) in
            self.dayLabel.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
            UIView.animate(withDuration: 0.4, animations: {
                self.setDayLabel()
                self.dayLabel.transform = CGAffineTransform.identity
        })
        }
    }
    @IBAction func prevDay(_ sender: Any) {
        selectedDate = CalHelper().minusDay(date: selectedDate)
        dayBack()
       
    }
    @IBAction func nextDay(_ sender: Any) {
        selectedDate = CalHelper().plusDay(date: selectedDate)
        dayForward()
        
    }
    
    
}

extension UITableViewController {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
