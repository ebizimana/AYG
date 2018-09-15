//
//  Assignment.swift
//  First part
//
//  Created by MMS Chapel on 7/27/17.
//  Copyright © 2017 Sqad Family. All rights reserved.
//

import UIKit

var Maxgrade: Double    = 0.0
var Maxxtotal: Double   = 0.0
var distrubutor: Double = 0.0

class Course
{
    
    class func average()
    {
        var assingNumber: String         // The total number of assignment in the class
        var total: Double = 0.0          // Maximum points per assignment
        var grade: Double = 0.0          // Grade attained per assignment
        var count: Int = 0               // The number of graded assignment
        var nongraded: Int = 0           // The number of nongraded assignment
        var sum: Double = 0.0            // Total sum of graded assignment
        var totalPoints: Double = 0.0    // Maximum points of all available assignment
        var name: String                 // The name of the assignment
        
        var data = mainInstance.selectedCourse!
        var letter = mainInstance.selectedGrade!
        
        for i:Int in 0 ..< allNotes.count
        {
            if data == allNotes[i].name
            {
                var file: [String] = []
                file = [allNotes[i].note]
                assingNumber = file[0]
                print(assingNumber)
                
                /*
                for i in 0 ..< assingNumber
                {
                    
                }*/
            }
        }
    }
}


