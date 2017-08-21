
//
//  UIDeviceExtension.swift
//  ContactApp
//
//  Created by RAHUL CK on 8/20/17.
//  Copyright © 2017 Farabi. All rights reserved.
//

import UIKit

extension UIDevice {
/// Returns true if iPad
class func isiPad() -> Bool {
    return (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
}
/// Returns true if iPhone
class func isiPhone() -> Bool {
    return (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone)
}
/// returns true if device orientation is portrait
class func isPortrait() -> Bool {
    return UIDeviceOrientationIsPortrait(UIDevice.current.orientation)
}
/// returns true if device orientation is landscape
class func isLandscape() -> Bool {
    return UIDeviceOrientationIsLandscape(UIDevice.current.orientation)
}
}
