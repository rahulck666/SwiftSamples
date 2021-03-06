//
//  Util.swift
//  ContactApp
//
//  Created by RAHUL CK on 8/21/17.
//  Copyright © 2017 Farabi. All rights reserved.
//

import Foundation
struct Utility {
    
    static func isValid(emailAddress: String?) -> Bool {
        
        guard let emailAddressString = emailAddress else {
            return false
        }
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    
    static func  isValid(phoneNumber: String?) -> Bool {
        guard let phoneNumber = phoneNumber else {
            return false
        }
        let charcterSet  = NSCharacterSet(charactersIn: "+0123456789").inverted
        let inputString = phoneNumber.components(separatedBy: charcterSet)
        let filtered = inputString.joined(separator: "")
        return  phoneNumber == filtered
    }
}
