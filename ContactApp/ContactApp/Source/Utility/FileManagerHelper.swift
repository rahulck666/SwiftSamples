//
//  FileManagerHelper.swift
//  ContactApp
//
//  Created by RAHUL CK on 8/21/17.
//  Copyright © 2017 Farabi. All rights reserved.
//

import UIKit

struct FileManagerHelper {
    
    static func writeImage(_ image:UIImage,fileName:String) {
        
        let url = FileManager.urlForSavingProfileImage(fileName: fileName)
        do {
            try UIImageJPEGRepresentation(image, 1.0)?.write(to: url, options: .atomic)
        } catch {
            print(error)
            print("file cant not be save at path \(url.absoluteString), with error : \(error)");
        }
    }
    static func readImage(fileName:String) -> UIImage? {
        let url = FileManager.urlForSavingProfileImage(fileName: fileName)
        return UIImage(contentsOfFile: url.path)
    }
    
}
