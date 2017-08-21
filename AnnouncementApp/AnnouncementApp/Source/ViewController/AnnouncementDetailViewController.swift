//
//  AnnouncementDetailViewController.swift
//  AnnouncementApp
//
//  Created by RAHUL CK on 8/21/17.
//  Copyright © 2017 Farabi. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class AnnouncementDetailViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var navigationBarView: NavigationBarView!
    @IBOutlet weak var activityIndicator: NVActivityIndicatorView!
    var annoucement:AnnounceMent?
    
    class func instantiateViewController() -> AnnouncementDetailViewController {
        let viewController = UIStoryboard.main().instantiateViewController(withIdentifier: AnnouncementDetailViewController.className) as! AnnouncementDetailViewController
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doInitialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- Setup methods
    func doInitialSetup() {
        navigationBarView.configure(title: LocalizeStringConstants.annoucement, isLeftButtonHidden: false, isRightButtonHidden: true)
        navigationBarView.delegate = self
        activityIndicator.color = .white
        activityIndicator.type = .ballClipRotateMultiple
        
        loadWebView()
    }
    
    func loadWebView() {
        if let htmlString = annoucement?.html {
            webView.loadHTMLString(htmlString, baseURL: nil)
        }
    }
    
}
//MARK:- UIWebViewDelegate

extension AnnouncementDetailViewController:UIWebViewDelegate {
    
    public func webViewDidStartLoad(_ webView: UIWebView) {
        activityIndicator.startAnimating()
        webView.backgroundColor = .black
    }
    
    public func webViewDidFinishLoad(_ webView: UIWebView) {
        activityIndicator.stopAnimating()
    }
}
extension AnnouncementDetailViewController:NavigationBarViewDelegate {
    
    func didTapNavigationRightButton(sender: Any) {
    }
    
    func didTapNavigationLeftButton(sender:Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
}


