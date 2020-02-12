//
//  NotesAddViewController.swift
//  Goback
//
//  Created by Zeqiel Golomb on 2/10/20.
//  Copyright © 2020 Zeqe Golomb. All rights reserved.
//

import UIKit

class NotesAddViewController: UIViewController {

    @IBOutlet weak var notesTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func createNotesButtonPressed(_ sender: UIButton) {
        if ((notesTextView.text != nil) && (notesTextView.text != "")) {
            let textToSave = notesTextView.text
            
            NotesTableViewController().save(contents: textToSave!)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
