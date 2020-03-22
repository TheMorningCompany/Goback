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
    
    @IBOutlet weak var textView: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.backgroundColor = UIColor(named: "BG")
        NotificationCenter.default.addObserver(self, selector:
            #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        textView.becomeFirstResponder()
        segmentedControl.layer.backgroundColor = CGColor(srgbRed: 240, green: 238, blue: 240, alpha: 1)
        if let todo = todo {
            textView.text = todo.title
            textView.text = todo.title
            segmentedControl.selectedSegmentIndex = Int(todo.priority)
        }
    }
    
    
    
    //MARK: Actions
    
    @objc func keyboardWillShow(with notification: Notification) {
        let key = "UIKeyboardFrameEndUserInfoKey"
        guard let keyboardFrame = notification.userInfo?[key] as? NSValue else { return }
        let keyboardHeight = keyboardFrame.cgRectValue.height
        bottomConstraint.constant = keyboardHeight
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
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
            todo.priority = Int16(segmentedControl.selectedSegmentIndex)
        } else {
            let todo = Todo(context: managedContext)
            todo.title = title
            todo.priority = Int16(segmentedControl.selectedSegmentIndex)
            todo.date = Date()
        }
        do {
            try managedContext.save()
            dismissAndResign()
        } catch {
            print("error saving todo\(error)")
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
