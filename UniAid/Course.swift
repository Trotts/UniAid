//
//  Course.swift
//  UniAid
//
//  Created by igor epshtein on 2016-03-22.
//  Copyright © 2016 igor epshtein. All rights reserved.
//

import Foundation

class Course
{
    var Course:String = ""
    var CourseNumber:String="";
    var Prof:String = ""
    var ProfEmail:String = ""
    var BuildingName:String = ""
    var scheduale: String = ""
    
    
    init (course: String,courseNum:String, prof: String, profEmail: String,buildingName: String,scheduale:String) {
        self.Course = course
        self.CourseNumber = courseNum
        self.Prof = prof
        self.ProfEmail = profEmail
        self.BuildingName = buildingName
        self.scheduale = scheduale
        
    }
}