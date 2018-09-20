//
//  Note.swift
//  First part
//
//  Created by MMS Chapel on 7/24/17.
//  Copyright © 2017 Sqad Family. All rights reserved.
//

import UIKit
import Foundation

var allNotes: [Note] = []
var currentNoteindex: Int = 0
var noteTable: UITableView?
var nameFilePicker: UIPickerView?
let kAllNotes:String = "notes"

class Note: NSObject
{
    var date:String
    var note:String
    var name:String
    var num: String
    
    override init()
    {
        date = NSDate().description
        name = ""
        note = ""
        num  = ""
    }
    
    func dictionary() -> NSDictionary
    {
        return ["note": note, "date": date, "name": name, "num":num]
    }
    
   
    class func saveNotes()
    {
        var aDictionaries: [NSDictionary] = []
        for i:Int in 0 ..< allNotes.count
        {
            aDictionaries.append (allNotes[i].dictionary())
        }
        UserDefaults.standard.set(aDictionaries, forKey: kAllNotes)
    }
    
    class func loadNotes()
    {
        allNotes = [Note]()
        let defaults:UserDefaults = UserDefaults.standard
        let saveData: [NSDictionary]? = defaults.object(forKey: kAllNotes) as? [NSDictionary]
        
        
        if let data:[NSDictionary] = saveData
        {
            for i:Int in 0 ..< data.count
            {
                let n:Note = Note()
                n.setValuesForKeys(data[i] as! [String : Any])
                allNotes.append(n)
            }
        }
    }
}
