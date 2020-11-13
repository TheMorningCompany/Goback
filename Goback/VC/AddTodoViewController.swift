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
    
    //MARK: Outlets
    
    @IBOutlet weak var colorBtn: UIButton!
    @IBOutlet weak var textViewBG: UIView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var textView: UITextField!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var TodoTextColor = "Default"
    
    
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
        
        isModalInPresentation = true
        
        //Notification for when the color picker closes
        NotificationCenter.default.addObserver(forName: COLOR_NOTIFICATION, object: nil, queue: nil) { notification in
            print("color received")
            self.textView.textColor = UIColor(named: notification.object as! String)
            self.TodoTextColor = notification.object as! String
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
