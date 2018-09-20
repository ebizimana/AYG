//
//  AssignmentViewController.swift
//  First part
//
//  Created by MMS Chapel on 7/28/17.
//  Copyright © 2017 Sqad Family. All rights reserved.
//

import UIKit
import Foundation

class AssignmentViewController: UIViewController
{
    @IBOutlet weak var name: UITextView!
    @IBOutlet weak var scren: UITextView!
    @IBOutlet weak var dets: UITextView!
    // Declaring variables
    var Maxgrade: Double    = 0.0              // the Sum of all assignments that have been graded
    var Maxtotal: Double   = 0.0              // The total points that can be attaneid in class
    var distrubutor: Double = 0.0            // The points being distibuted across
    var data: String = ""                   // The class Name
    var letter: String = ""                 // The letter Grade

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        nameFilePicker?.reloadAllComponents()
        
        // When you have not added any class
        if allNotes.count == 0
        {
            scren.text = "Please add a class"
        }
        // If you have lost many points to get the grade
        else if pointsLeft() < 0
        {
            name.text = data
            scren.text = "\n\n I am sorry. You lost too many points to achieve a(n). \(letter) \n"
        }
        
        // Running the app.
        else
        {
            name.text = "\(data)\n\n"
            average()
            dets.text.append("You Have \(round(getMaxGrade())) /  \(round(getMaxTotal())) \n")

            dets.text.append("Points left before you lose your grade : \(round(pointsLeft())) \n")
            
            if round(pointTogo()) <= 0
            {
                dets.text.append("Points left to get your grade: 0 \n")
            }
                
            else
            {
                dets.text.append("Points left to get your grade: \(round(pointTogo())) \n")
            }
            
            
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Converts String to Interger
    func getNumber(number: Any?) -> NSNumber {
        guard let statusNumber:NSNumber = number as? NSNumber else
        {
            guard let statString:String = number as? String else
            {
                return 0
            }
            if let myInteger = Int(statString)
            {
                return NSNumber(value:myInteger)
            }
            else{
                
                return 0
            }
        }
        return statusNumber
    }
    
    func RemoveWhiteSpace(aString:String) -> String
    {
        let replaced = aString.trimmingCharacters(in: NSCharacterSet.whitespaces)
        return replaced
    }

    func setMaxgrade(Grade: Double)
    {
        Maxgrade = Grade
    }
    
    func setMaxtotal(Total: Double)
    {
        Maxtotal = Total
    }
    
    func setDistr(Di: Double)
    {
        distrubutor = Di
    }
    
    func getMaxTotal() -> Double
    {
        return Maxtotal
    }
    
    func getMaxGrade() -> Double
    {
        return Maxgrade
    }
    
    func getdistr() -> Double
    {
        return distrubutor
    }
    
    // Calculating the Grade scale for the class
    func gradeScale(totalPoints: Double) -> Double
    {
        var gradeSc : Double = 0.0
        switch letter
        {
        case "A": gradeSc = totalPoints - 100; break
        case "B": gradeSc = totalPoints - 200; break
        case "C": gradeSc = totalPoints - 300; break
        case "D": gradeSc = totalPoints - 400; break
        case "F": gradeSc = totalPoints - 500; break
        default: scren.text.append("please input an appropriate letter \n")
            break
        }
        return gradeSc
    }
    
    // Calculating how many points remaing to get to achive your grade
    func pointTogo() -> Double
    {
        var togo: Double = 0.0
        togo = gradeScale(totalPoints: getMaxTotal()) - getMaxGrade()
        return togo
    }
    
    // Calculating the total points left untl you lose your grade
    func pointsLeft() -> Double
    {
        var left: Double = 0.0
        var total: Double            // maximum points per assignment
        var grade: Double           // Grade attained per assignment
        var sumleft: Double = 0.0
        var assingNumber: Int       // The total number of assignment
        
        for i:Int in 0 ..< allNotes.count
        {
            if data == allNotes[i].name           // To make sure we are in the right class
            {
                let file = allNotes[i].note       // to store all the assignments in the variable file
                let assingNumberString = allNotes[i].num    // it gets the total number of the assignments 
                
                let removeFileSpace = file.characters
                    .split { $0 == " " }
                    .map { String($0) }
                    .joined(separator: " ")
                
                let fileArr = removeFileSpace.components(separatedBy: "\n")
                
                assingNumber = Int(getNumber(number: assingNumberString))  // it change the string into an int 
                
                for j:Int in 0..<assingNumber
                {
                    var index = 0                    // Keep Track of lineArr
                    let line = fileArr[j]
                    
                    // Remove Spaces
                    let removeSpace = line.characters
                        .split { $0 == " " }
                        .map { String($0) }
                        .joined(separator: " ")
                    
                    let lineArr = removeSpace.components(separatedBy: .whitespaces)
                    index = index + 1
                    let gradeString = lineArr[index]
                    grade = Double(getNumber(number: gradeString))
                    index = index + 1
                    let totalString = lineArr[index]
                    total = Double(getNumber(number: totalString))
                    index = index + 1
                    
                    if gradeString != "-"
                    {
                        left = total - grade
                        sumleft = sumleft + left
                    }
                }
            }
        }
        
        // To check how many points left to lose a certain grade
        switch letter
        {
        case "A": sumleft = 100 - sumleft; break
        case "B": sumleft = 200 - sumleft; break
        case "C": sumleft = 300 - sumleft; break
        case "D": sumleft = 400 - sumleft; break
        case "F": sumleft = 500 - sumleft; break
        default: scren.text = "Please input an appropriate letter \n"
        break
        }
        
        return sumleft
    }
    
    // To get the estimated points per assignmemnt
    func average()
    {
       
        var assingNumber: Int = 0           // The total number of assignment in the class
        var name: String                 // The name of the assignment
        var grade: Double = 0.0          // Grade attained per assignment
        var total: Double = 0.0          // Maximum points per assignment
        var count: Int = 0               // The number of graded assignment
        var sum: Double = 0.0            // Total sum of graded assignment
        var totalPoints: Double = 0.0    // Maximum points of all available assignment
        var nongraded: Int = 0           // The number of nongraded assignment
        
        for i:Int in 0 ..< allNotes.count
        {
            // To make sure we are in the right class
            if data == allNotes[i].name
            {
                
                let file = allNotes[i].note
                let assingNumberString = allNotes[i].num
                
                let removeFileSpace = file.characters
                    .split { $0 == " " }
                    .map { String($0) }
                    .joined(separator: " ")
                
                let fileArr = removeFileSpace.components(separatedBy: "\n")
                
                assingNumber = Int(getNumber(number: assingNumberString))
                
                for j:Int in 0..<assingNumber
                {
                    var index = 0
                    let line = fileArr[j]
                    
                    //Remove Spaces
                    let removeSpace = line.characters
                        .split { $0 == " " }
                        .map { String($0) }
                        .joined(separator: " ")
                    
                    let lineArr = removeSpace.components(separatedBy: .whitespaces)
                    name = lineArr[index]
                    index = index + 1
                    let gradeString = lineArr[index]
                    grade = Double(getNumber(number: gradeString))
                    index = index + 1
                    let totalString = lineArr[index]
                    total = Double(getNumber(number: totalString))
                    index = index + 1
                    
                    if gradeString == "-"
                    {
                        totalPoints = totalPoints + total
                        setMaxtotal(Total: totalPoints)
                        nongraded = assingNumber - count
                        distrubutor = pointsLeft() / Double(nongraded)
                        setDistr(Di: distrubutor)
                        grade = total - distrubutor
                        
                        let size = name.characters.count
                        var i = 0
                        // Print Name...
                        if size >= 10 {
                            for char in name.characters {
                                if i < 10 {
                                    scren.text.append(char)
                                    i += 1
                                }
                            }
                            scren.text.append("...")
                        }
                        else {
                            for char in name.characters{
                                scren.text.append(char)
                                i += 1
                            }
                            while i < 14 {
                                scren.text.append(".")
                                i += 1
                            }
                            
                        }
                        
                        // Print Grade
                        if scren.frame.width > 10{
                            scren.text.append("   ")
                            scren.text.append("\(round(grade))")
                            
                        }
                        else {
                            for _ in 0...5 {
                                scren.text.append(" ")
                            }
                            scren.text.append("\(round(grade))")
                        }
                        
                        // Print Total
                        if round(grade) > 99.0{
                            scren.text.append("    ")
                            scren.text.append("\(round(grade))")
                            
                        }
                        else {
                            for _ in 0...5 {
                                scren.text.append(" ")
                            }
                            scren.text.append("\(round(grade))")
                        }
                        // Print Status
                        if round(grade) > 99.0{
                            scren.text.append("    ")
                            scren.text.append("*Estimated* \n")
                            
                        }
                        else {
                            scren.text.append("     ")
                            scren.text.append("*Estimated* \n")
                        }
                    }
                    
                   else
                    {
                        count = count + 1
                        sum = sum + grade
                        totalPoints = totalPoints + total
                        setMaxgrade(Grade: sum)
                        setMaxtotal(Total: totalPoints)
                        
                        let size = name.characters.count
                        var i = 0
                        // Print Name...
                        if size >= 10 {
                            for char in name.characters {
                                if i < 10 {
                                    scren.text.append(char)
                                    i += 1
                                }
                            }
                            scren.text.append("...")
                        }
                        else {
                            for char in name.characters{
                                scren.text.append(char)
                                i += 1
                            }
                            while i < 14 {
                                scren.text.append(".")
                                i += 1
                            }
                            
                        }
                        
                        // Print Grade
                        if round(grade) > 99.0{
                            scren.text.append("    ")
                            scren.text.append("\(round(grade))")
                            
                        }
                        else {
                            for _ in 0...5 {
                                scren.text.append(" ")
                            }
                            scren.text.append("\(round(grade))")
                        }
                        
                        // Print Total
                        if round(grade) > 99.0{
                            scren.text.append("    ")
                            scren.text.append("\(round(grade))")
                            
                        }
                        else {
                            for _ in 0...5 {
                                scren.text.append(" ")
                            }
                            scren.text.append("\(round(grade))")
                        }
                        // Print Status
                        if round(grade) > 99.0{
                            scren.text.append("     ")
                            scren.text.append("*Graded* \n")
                            
                        }
                        else {
                            for _ in 0...5 {
                                scren.text.append(" ")
                            }
                            scren.text.append("*Graded* \n")
                        }
                        
                    }
                }
            }
        }
    }
}
