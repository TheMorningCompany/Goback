//
//  AddNoteViewController.swift
//  Goback
//
//  Created by Zeqiel Golomb on 3/1/20.
//  Copyright © 2020 Zeqe Golomb. All rights reserved.
//

import UIKit
import CoreData

class AddNoteViewController: UIViewController {
    
    // MARK: - Properties
    var managedContextNotes: NSManagedObjectContext!
    var note: Notes?
    
    // MARK: Outlets
    @IBOutlet weak var textFieldBG: UIView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var saveBtn: PrimaryBtn!
    
    
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteTextView.becomeFirstResponder()
        
        if let note = note {
            noteTextView.text = note.title
            noteTextView.text = note.title
        }
        
        NotificationCenter.default.addObserver(self,
        selector: #selector(keyboardWillShow(with:)),
        name: UIResponder.keyboardWillShowNotification,
        object: nil)
        
        self.textFieldBG.layer.cornerRadius = 20.0
        self.textFieldBG.layer.cornerCurve = .continuous
        self.saveBtn.layer.cornerRadius = 20.0
        self.saveBtn.layer.cornerCurve = .continuous
        
        isModalInPresentation = true
        
    }
    
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
        noteTextView.resignFirstResponder()
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismissAndResign()
    }
    
    
    @IBAction func save(_ sender: Any) {
        if noteTextView.text == "" {
            noteTextView.text = " "
        }
        
        guard let title = noteTextView.text, !title.isEmpty else {
            return
        }
        
        if let note = self.note {
            note.title = title
        } else {
            let note = Notes(context: managedContextNotes)
            note.title = title
            note.date = Date()
        }
        do {
            try managedContextNotes.save()
            dismissAndResign()
        } catch {
            print("error saving note: \(error)")
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
}

extension AddNoteViewController: UITextViewDelegate {
    func textViewDidChangeSelection(_ textView: UITextView) {
        if doneBtn.isEnabled == false {
            noteTextView.text.removeAll()
            doneBtn.isEnabled = true
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
}
