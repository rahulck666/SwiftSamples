//
//  WebserviceManager.swift
//  AnnouncementApp
//
//  Created by RAHUL CK on 8/21/17.
//  Copyright © 2017 Farabi. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

public enum WebServiceOperation
{
    case fetchAnnouncementList
    
}

public typealias WebserviceOperationResult = AnyObject

public protocol WebserviceManagerDelegate : NSObjectProtocol {
    func webserviceOperationCompleted(operation:WebServiceOperation,operationResult:WebserviceOperationResult)
    func webserviceOperationFailed(operation:WebServiceOperation, error:Error?)
    
}

class WebserviceManager: NSObject {
   
    open static let shared: WebserviceManager = {
        return WebserviceManager()
    }()
    
    func fechAnnouncements(operation:WebServiceOperation , delegate:WebserviceManagerDelegate?) {
        Alamofire.request(operation.operationURLSrting()!).responseArray { (response: DataResponse<[AnnounceMent]>) in
            if let annoucements = response.result.value {
                DispatchQueue.main.async {
                     delegate?.webserviceOperationCompleted(operation: operation, operationResult: annoucements as WebserviceOperationResult)
                }
            }
            else {
                DispatchQueue.main.async {
                    delegate?.webserviceOperationFailed(operation: operation, error:response.error)
                }
            }
        }
        
    }
}
public extension WebServiceOperation
{
    func operationURLSrting() -> String? {
        
        var urlSringForOperation : String?
        
        switch self {
            
        case .fetchAnnouncementList:
            urlSringForOperation = api_base_url
        }
        return urlSringForOperation
    }
    
    func operationURL() -> URL? {
        
        var operationURL : URL?
        
        if  let operationUrlString = operationURLSrting(){
            
            operationURL = URL(string: operationUrlString)
        }
        
        return operationURL
        
    }
}
