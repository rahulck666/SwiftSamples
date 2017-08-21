//
//  AnnounceMentListingAPIResponse.swift
//  AnnouncementApp
//
//  Created by RAHUL CK on 8/21/17.
//  Copyright © 2017 Farabi. All rights reserved.
//

import UIKit
import ObjectMapper


class AnnounceMentListingAPIResponse: Mappable {
    var annoucements: [AnnounceMent]?
    required init?(map: Map){
    }
    func mapping(map: Map) {
    }


}
