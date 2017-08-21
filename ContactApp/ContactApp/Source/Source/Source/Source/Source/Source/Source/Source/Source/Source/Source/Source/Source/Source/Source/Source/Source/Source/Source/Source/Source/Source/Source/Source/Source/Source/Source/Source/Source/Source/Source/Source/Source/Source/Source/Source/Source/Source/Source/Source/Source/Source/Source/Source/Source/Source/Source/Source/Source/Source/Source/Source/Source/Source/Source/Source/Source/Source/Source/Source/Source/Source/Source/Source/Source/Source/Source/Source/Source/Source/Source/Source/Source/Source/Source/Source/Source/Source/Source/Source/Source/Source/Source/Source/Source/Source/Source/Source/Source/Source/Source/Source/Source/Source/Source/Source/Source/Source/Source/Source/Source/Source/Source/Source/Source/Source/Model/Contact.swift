//
//  Contact.swift
//  ContactApp
//
//  Created by RAHUL CK on 8/18/17.
//  Copyright © 2017 Farabi. All rights reserved.
//

import UIKit
import RealmSwift

class Contact: BaseModel {
   
    dynamic var firstName:String?
    dynamic var lastName:String?
    dynamic var email:String?
    dynamic var mobile:String?
    dynamic var photo:String?
    
    // MARK: - Primary Key for Contact
    override static func primaryKey() -> String? {
        return "identifier"
    }
    override var description: String {
        return "\(self.firstName) \(self.lastName) \n Mob:\(self.mobile)"
    }



}
