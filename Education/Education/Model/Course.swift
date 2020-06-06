//
//  Course.swift
//  Education
//
//  Created by William on 01/06/20.
//  Copyright © 2020 William. All rights reserved.
//

import Foundation
import SwiftyJSON

class Course {
    
    var id: Int?
    var name: String?
    var content: String?
    var picture: String?
    var price: Int?
    
    init(json: JSON) {
        self.id = json["id"].int
        self.name = json["name"].string
        self.content = json["content"].string
        self.picture = json["picture"].string
        self.price = json["price"].int
    }
    
}
