//
//  Constants.swift
//  ContactApp
//
//  Created by RAHUL CK on 8/19/17.
//  Copyright © 2017 Farabi. All rights reserved.
//

import UIKit

let api_base_url = "http://www.solutions4mobility.com/AABToyota/ipdp/ipdpb.ashx?CFG=OPTIMAL&p=Common.Announcements&Handler=News&MODULE_ID=501&TemplateName=News.htm&APPLICATION_NAME=TOYOTA&F=J"

/// to hold static UI strings that may require localization
struct LocalizeStringConstants {
    static let contactListingTitle = "Contact"
    static let cancel = "Cancel"
    static let back = "Back"
    static let Ok = "Ok"

    static let annoucement = "Announcements"


}
/// to hold storyboard names
struct StoryboardConstants {
    static let main = "Main"
    
}
/// to hold message constants
struct MessageConstants {
    static let sometingWentWrong = "Something went wrong.Please try again"

    
}
let lightBlueColor = UIColor(colorLiteralRed: 28/255, green: 87/255, blue: 138/255, alpha: 1)

