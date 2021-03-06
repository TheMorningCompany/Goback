//
//  AddTodoViewController.swift
//  Goback
//
//  Created by Zeqiel Golomb on 2/27/20.
//  Copyright © 2020 Zeqe Golomb. All rights reserved.
//

import UIKit
import CoreData
import AVKit

class AddTodoViewController: UIViewController {

    
    //MARK: - Properties
    
    var managedContext: NSManagedObjectContext!
    var todo: Todo?
    
    var alertDate: Date!
    
    
    
    //MARK: Outlets
    
    @IBOutlet weak var colorBtn: UIButton!
    @IBOutlet weak var dateBtn: UIButton!
    @IBOutlet weak var textViewBG: UIView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var textView: UITextField!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var TodoTextColor = "Default"
    
    
    let notificationManager = LocalNotificationManager()
    var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector:
            #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        textView.becomeFirstResponder()
            
        if let todo = todo {
            textView.text = todo.title
            textView.text = todo.title
        }
        
        self.textViewBG.layer.cornerRadius = 20.0
        self.textViewBG.layer.cornerCurve = .continuous
        self.saveBtn.layer.cornerRadius = 20.0
        self.saveBtn.layer.cornerCurve = .continuous
        self.colorBtn.layer.cornerRadius = 20.0
        self.colorBtn.layer.cornerCurve = .continuous
        self.dateBtn.layer.cornerRadius = 20.0
        self.dateBtn.layer.cornerCurve = .continuous
        
        isModalInPresentation = true
        
        //Notification for when the color picker closes
        NotificationCenter.default.addObserver(forName: COLOR_NOTIFICATION, object: nil, queue: nil) { notification in
            self.textView.textColor = UIColor(named: notification.object as! String)
            self.TodoTextColor = notification.object as! String
        }
        
        //when the date picker closes
        NotificationCenter.default.addObserver(forName: DAYCHANGE_NOTIFICATION, object: nil, queue: nil) { notification in
            self.alertDate = notification.object as? Date
            print(self.alertDate!)
        }
        
        //color on open
        if todo?.color == "Blue"{
            self.textView.textColor = UIColor(named: "Blue")
            TodoTextColor = "Blue"
        }
        if todo?.color == "Default"{
            self.textView.textColor = UIColor(named: "Default")
            TodoTextColor = "Default"
        }
        if todo?.color == "DarkBlue"{
            self.textView.textColor = UIColor(named: "DarkBlue")
            TodoTextColor = "DarkBlue"
        }
        if todo?.color == "Orange"{
            self.textView.textColor = UIColor(named: "Orange")
            TodoTextColor = "DarkBlue"
        }
        if todo?.color == "Pink"{
            self.textView.textColor = UIColor(named: "Pink")
            TodoTextColor = "Pink"
        }
        if todo?.color == "Purple"{
            self.textView.textColor = UIColor(named: "Purple")
            TodoTextColor = "Purple"
        }
        if todo?.color == "Teal"{
            self.textView.textColor = UIColor(named: "Teal")
            TodoTextColor = "Teal"
        }
        if todo?.color == "Yellow"{
            self.textView.textColor = UIColor(named: "Yellow")
            TodoTextColor = "Yellow"
        }
        
    }
    
    
    
    //MARK: Actions
    
    @objc func keyboardWillShow(with notification: Notification) {
//        let key = "UIKeyboardFrameEndUserInfoKey"
//        guard let keyboardFrame = notification.userInfo?[key] as? NSValue else { return }
//        let keyboardHeight = keyboardFrame.cgRectValue.height
        
    }
    
    
    fileprivate func dismissAndResign() {
        dismiss(animated: true, completion: nil)
        textView.resignFirstResponder()
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismissAndResign()
    }
    
    @IBAction func done(_ sender: Any) {
        guard let title = textView.text, !title.isEmpty else {
            return
        }
        if let todo = self.todo {
            todo.title = title
            todo.color = TodoTextColor
        } else {
            let todo = Todo(context: managedContext)
            todo.title = title
            todo.date = Date()
            todo.color = TodoTextColor
        }
        do {
            try managedContext.save()
            dismissAndResign()
        } catch {
            print("error saving todo\(error)")
        }
        
        todo?.alertDate = alertDate
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey:
                    "item done", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "your item has finished", arguments: nil)
        content.categoryIdentifier = "Your notification category"
        content.sound = UNNotificationSound.default
        content.badge = 1
        
        let dateComponents = Calendar.current.dateComponents(Set(arrayLiteral: Calendar.Component.year, Calendar.Component.month, Calendar.Component.day), from: alertDate)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: "Your notification identifier", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
                if let error = error {
                    print(error)
                } else {
                   print("succeed")
                }
            }
        )
    }

    @IBAction func dismissKeyboard(_ sender: Any) {
        if textView.isFirstResponder{
            textView.resignFirstResponder()
            dismissKeyboard(self)
        }
        
    }
    
}
extension AddTodoViewController: UITextViewDelegate {
    func textViewDidChangeSelection(_ textView: UITextView) {
        if doneBtn.isEnabled == false {
            textView.text.removeAll()
            doneBtn.isEnabled = true
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
}
