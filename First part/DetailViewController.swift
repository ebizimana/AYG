//
//  DetailViewController.swift
//  AYG Test 2
//
//  Created by MMS Chapel on 7/18/17.
//  Copyright © 2017 Sqad Family. All rights reserved.
//

import UIKit
import Foundation

class DetailViewController: UIViewController {
    
    @IBOutlet weak var tview: UITextView!
    @IBOutlet weak var className: UITextField!
     @IBOutlet weak var assiNum: UITextField!
    
    func configureView() {
       
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = tview {
                label.text = detail.description
            }
        }
    }
    
    
    var detailItem: Note? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if tview.text == "" {
            allNotes.remove(at: currentNoteindex)
        }
        else {
            
            allNotes[currentNoteindex].name = className.text!
            allNotes[currentNoteindex].num = assiNum.text!
            allNotes[currentNoteindex].note = tview.text
        }
        Note.saveNotes()
        noteTable?.reloadData()
        nameFilePicker?.reloadAllComponents()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        className.text = allNotes[currentNoteindex].name
        tview.text = allNotes[currentNoteindex].note
        assiNum.text = allNotes[currentNoteindex].num
        className.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

