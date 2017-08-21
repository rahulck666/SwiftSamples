//
//  AnnounceMent.swift
//  AnnouncementApp
//
//  Created by RAHUL CK on 8/21/17.
//  Copyright © 2017 Farabi. All rights reserved.
//

import UIKit
import ObjectMapper

class AnnounceMent: Mappable {
    var title:String?
    var date:String?
    var html:String?
    
    required init?(map: Map){
    }
    func mapping(map: Map) {
        title <- map["ANNOUNCEMENT_TITLE"]
        date <- map["ANNOUNCEMENT_DATE"]
        html <- map["ANNOUNCEMENT_HTML"]
    }
}
