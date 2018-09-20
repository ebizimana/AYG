//
//  StartViewController.swift
//  First part
//
//  Created by MMS Chapel on 7/25/17.
//  Copyright © 2017 Sqad Family. All rights reserved.
//

import UIKit
import Foundation

class StartViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource
    
{
    @IBOutlet weak var fileNamePicker: UIPickerView!
    @IBOutlet weak var gradePicker: UIPickerView!

    
    let grades = ["A","B","C","D","F"]
    var nameFile: [String] = []
    var selectedGrade: String?
    var selectedCourse: String?
    
    override func viewDidLoad()
    {
        
        super.viewDidLoad()

        Note.loadNotes()
        nameFilePicker = self.fileNamePicker
        
        fileNamePicker.dataSource = self
        fileNamePicker.delegate = self
        
        gradePicker.dataSource = self
        gradePicker.delegate = self
        
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if pickerView == gradePicker
        {
            return grades.count
        }
        else
        {
            
           return allNotes.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if pickerView == gradePicker
        {
            return grades[row]
        }
        
        nameFile = [String]()
        for i:Int in 0 ..< allNotes.count
        {
            nameFile.append (allNotes[i].name)
        }

        return nameFile[row]

    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if pickerView == gradePicker
        {
            selectedGrade = grades[row]
        }
        else
        {
            if allNotes.count == 0
            {
                selectedCourse = " "
            }
            else
            {
                selectedCourse = nameFile[row]
            }
            
        }
        

    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "AssigVC"
        {
            
            let controller = (segue.destination as! UINavigationController).topViewController as! AssignmentViewController
            
            if selectedCourse == nil || selectedGrade == nil
            {
                pickerView(gradePicker, didSelectRow: 0, inComponent: 0)
                pickerView(fileNamePicker, didSelectRow: 0, inComponent: 0)
            }
            controller.letter = selectedGrade!
            controller.data = selectedCourse!
        }
        
    }
}

