//
//  AddTodoViewController.swift
//  Goback
//
//  Created by Zeqiel Golomb on 2/27/20.
//  Copyright © 2020 Zeqe Golomb. All rights reserved.
//

import UIKit
import CoreData

class AddTodoViewController: UIViewController {

    
    //MARK: - Properties
    
    var managedContext: NSManagedObjectContext!
    var todo: Todo?
    var TextColor = "Default"
    
    //MARK: Outlets
    
    @IBOutlet weak var iconBtn: UIButton!
    @IBOutlet weak var colorBtn: UIButton!
    @IBOutlet weak var textViewBG: UIView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var textView: UITextField!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    
    
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
        self.iconBtn.layer.cornerRadius = 20.0
        self.iconBtn.layer.cornerCurve = .continuous
        self.colorBtn.layer.cornerRadius = 20.0
        self.colorBtn.layer.cornerCurve = .continuous
        
        isModalInPresentation = true
        
        NotificationCenter.default.addObserver(forName: COLORFORFIELD_NOTIFICATION, object: nil, queue: nil) { notification in
            print("color recieved")
            
            let colorObject = notification.object as? String
            print("color object is \(String(describing: colorObject))")
            
            if ((colorObject?.contains("Orange")) != nil) {
                self.textView.textColor = UIColor(named: "Orange")
            }
            if ((colorObject?.contains("Yellow")) != nil) {
                self.textView.textColor = UIColor(named: "Yellow")
            }
            if ((colorObject?.contains("Blue")) != nil) {
                self.textView.textColor = UIColor(named: "Blue")
            }
            if ((colorObject?.contains("DarkBlue")) != nil) {
                self.textView.textColor = UIColor(named: "DarkBlue")
            }
            if ((colorObject?.contains("Default")) != nil) {
                self.textView.textColor = UIColor(named: "Default")
            }
            if ((colorObject?.contains("Pink")) != nil) {
                self.textView.textColor = UIColor(named: "Pink")
            }
            if ((colorObject?.contains("Purple")) != nil) {
                self.textView.textColor = UIColor(named: "Purple")
            }
            if ((colorObject?.contains("Green")) != nil) {
                self.textView.textColor = UIColor(named: "Green")
            }
        }
        
        
//        NotificationCenter.default.addObserver(forName: COLOR_NOTIFICATION, object: nil, queue: nil) { notification in
//            print("color recieved")
//            self.TextColor = notification.object as! String
//            self.textView.textColor = UIColor(named: "\(notification.object as! String)")
//        }
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
            todo.color = TextColor
        } else {
            let todo = Todo(context: managedContext)
            todo.title = title
            todo.date = Date()
            todo.color = TextColor
        }
        do {
            try managedContext.save()
            dismissAndResign()
        } catch {
            print("error saving todo\(error)")
        }
        
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
