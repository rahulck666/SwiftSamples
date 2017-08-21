//
//  ViewController.swift
//  AnnouncementApp
//
//  Created by RAHUL CK on 8/21/17.
//  Copyright © 2017 Farabi. All rights reserved.
//

import UIKit
import NVActivityIndicatorView


class AnnouncementViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var announcements:[AnnounceMent]?
    @IBOutlet weak var navigationBarView: NavigationBarView!
    @IBOutlet weak var activityIndicator: NVActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doInitialSetup()
        activityIndicator.startAnimating()
        WebserviceManager.shared.fechAnnouncements(operation: .fetchAnnouncementList, delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- Setup methods
    func doInitialSetup() {
        navigationBarView.configure(title: LocalizeStringConstants.annoucement, isLeftButtonHidden: true, isRightButtonHidden: true)
        tableView.tableFooterView = UIView.init(frame: CGRect.zero)
        activityIndicator.color = lightBlueColor
        activityIndicator.type = .ballTrianglePath
        
    }
    
}
//MARK:- UITableViewDelegate

extension AnnouncementViewController:UITableViewDelegate,UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return announcements?.count ?? 0
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AnnouncementViewCell.className, for: indexPath)
        return cell
        
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let announcement = announcements?[indexPath.row]
        if let announcementCell = cell as? AnnouncementViewCell ,let announcement = announcement {
            announcementCell.configure(with: announcement)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let announcement = announcements?[indexPath.row] {
            let announcementDetailController = AnnouncementDetailViewController.instantiateViewController()
            announcementDetailController.annoucement = announcement
            self.navigationController?.pushViewController(announcementDetailController, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
//MARK:- WebserviceManagerDelegate
extension AnnouncementViewController:WebserviceManagerDelegate {
    
    func webserviceOperationCompleted(operation:WebServiceOperation,operationResult:WebserviceOperationResult) {
        activityIndicator.stopAnimating()
        
        if let announcements = operationResult as? [AnnounceMent] {
            self.announcements = announcements
            tableView.reloadData()
        }
    }
    
    func webserviceOperationFailed(operation:WebServiceOperation, error:Error?) {
        activityIndicator.stopAnimating()
        showAlert(with: LocalizeStringConstants.annoucement, message: MessageConstants.sometingWentWrong)
    }
    
    func showAlert(with title:String,message:String)  {
        let alertController = UIAlertController(title:title , message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: LocalizeStringConstants.Ok, style: .default) { (action:UIAlertAction!) in
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion:nil)
    }
    
}
