//
//  NSObjectExtension.swift
//  ContactApp
//
//  Created by RAHUL CK on 8/19/17.
//  Copyright © 2017 Farabi. All rights reserved.
//


import UIKit

extension NSObject {
    
    /// Returns class name string
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
