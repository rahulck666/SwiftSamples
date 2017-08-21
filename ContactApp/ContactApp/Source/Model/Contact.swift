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
    dynamic var birthDate:Date?
    dynamic var address:String?
    private var _profilePic:UIImage?
    public internal(set) var profilePic: UIImage? {
        get {
            if self._profilePic == nil {
              return FileManagerHelper.readImage(fileName:String(identifier))
            }
            return self._profilePic
        }
        set {
            self._profilePic = newValue
        }
    }

    var fullName:String? {
        get {
            return "\(firstName ?? "") \(lastName ?? "") "
        }
    }
    
    // MARK: - Primary Key for Contact
    override static func primaryKey() -> String? {
        return "identifier"
    }
    override static func ignoredProperties() -> [String] {
        return ["_profilePic","profilePic"]
    }

}
