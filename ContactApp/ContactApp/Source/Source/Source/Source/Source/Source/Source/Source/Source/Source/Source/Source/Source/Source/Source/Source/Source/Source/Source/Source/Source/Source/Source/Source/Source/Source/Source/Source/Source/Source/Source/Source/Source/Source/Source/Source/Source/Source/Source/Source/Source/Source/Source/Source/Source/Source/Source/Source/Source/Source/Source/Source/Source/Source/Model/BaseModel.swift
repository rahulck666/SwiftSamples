//
//  BaseModel.swift
//  ContactApp
//
//  Created by RAHUL CK on 8/18/17.
//  Copyright © 2017 Farabi. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class BaseModel: Object {
   
    dynamic var identifier: Int = 0
    
    // MARK: - Object (Realm) init
    required init() {
        super.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    
}
