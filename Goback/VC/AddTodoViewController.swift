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
    var color = "Default"
    
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
        
        color = "Default"
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
            todo.color = color
        } else {
            let todo = Todo(context: managedContext)
            todo.title = title
            todo.date = Date()
            todo.color = color
        }
        do {
            try managedContext.save()
            dismissAndResign()
        } catch {
            print("error saving todo\(error)")
        }
        
    }
    
    @IBAction func cellColorElevated(_ sender: Any) {
        color = "Default"
    }
    @IBAction func cellColorPink(_ sender: Any) {
        color = "Pink"
    }
    @IBAction func cellColorOrange(_ sender: Any) {
        color = "Orange"
    }
    @IBAction func cellColorYellow(_ sender: Any) {
        color = "Yellow"
    }
    @IBAction func cellColorGreen(_ sender: Any) {
        color = "Green"
    }
    @IBAction func cellColorBlue(_ sender: Any) {
        color = "Blue"
    }
    @IBAction func cellColorPurple(_ sender: Any) {
        color = "Purple"
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
