//
//  CourseTask.swift
//  Education
//
//  Created by William on 01/06/20.
//  Copyright © 2020 William. All rights reserved.
//

import Foundation
import SwiftyJSON

class CourseTask {
    
    var id: Int?
    var title: String?
    var note: String?
    
    init(json: JSON) {
        self.id = json["id"].int
        self.title = json["title"].string
        self.note = json["note"].string
    }
    
}
