//
//  FileManagerExtension.swift
//  ContactApp
//
//  Created by RAHUL CK on 8/21/17.
//  Copyright © 2017 Farabi. All rights reserved.
//

import UIKit

extension FileManager {
    
    class var documentDirectoryURL: URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    class func urlForSavingProfileImage(fileName:String) -> URL {
        return self.createDirectory("Profile_Images").appendingPathComponent(fileName)
    }
    
    class func createDirectory(_ directoryName: String) -> URL {
        let newDirectory = FileManager.documentDirectoryURL!.appendingPathComponent(directoryName)
        if !FileManager.default.fileExists(atPath: newDirectory.relativePath) {
            do {
                try FileManager.default.createDirectory(atPath: newDirectory.relativePath, withIntermediateDirectories: false, attributes: nil)
            } catch let error as NSError {
                print(error.localizedDescription);
            }
        }
        return newDirectory
    }
    
}
