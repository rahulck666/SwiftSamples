//
//  ViewController.swift
//  ContactApp
//
//  Created by RAHUL CK on 8/16/17.
//  Copyright © 2017 Farabi. All rights reserved.
//

import UIKit
import MessageUI

class ContactListingViewController: UIViewController {
    
    @IBOutlet weak var navigationBarView: NavigationBarView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDataLabel: UILabel!
    var contacts = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doInitialSetup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpDataSource()
        tableView.reloadData()
        showNoDataMessageIfNeeded()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK:- Setup methods
    
    func doInitialSetup()  {
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        setUpDataSource()
        setUpNavigationBarView()
    }
    
    func setUpDataSource() {
        self.contacts = ContactStoreManager.shared.allContacts()
    }
    
    func setUpNavigationBarView() {
        navigationBarView.configure(title: LocalizeStringConstants.contactListingTitle, isLeftButtonHidden: true, isRightButtonHidden: false)
        navigationBarView.setRightButtonTitle(LocalizeStringConstants.add)
        navigationBarView.delegate = self
    }
    
    // MARK:- UI updates methods
    
    func showNoDataMessageIfNeeded()  {
        if contacts.count == 0 {
            noDataLabel.text = LocalizeStringConstants.noDataMessage
        }
        else {
            noDataLabel.text = ""
        }
    }
    
    func handleSelectContact(contact:Contact) {
        let detailActionSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let showDetailAction = UIAlertAction(title: LocalizeStringConstants.showDetail, style: .default) { action -> Void in
            let detailController = ContactDetailViewController.instantiateViewController()
            detailController.viewMode = .view
            detailController.contact = contact
            self.navigationController?.pushViewController(detailController, animated: true)
        }
        let cancelAction = UIAlertAction(title: LocalizeStringConstants.cancel, style: .cancel) { action -> Void in
            
        }
        let callAction = UIAlertAction(title: LocalizeStringConstants.call, style: .default) { action -> Void in
            if let phone = contact.mobile {
                if let url = URL(string: "tel://\(phone)"), UIApplication.shared.canOpenURL(url) {
                    if #available(iOS 10, *) {
                        UIApplication.shared.open(url)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
            }
        }
        let sendAnEmailAction = UIAlertAction(title: LocalizeStringConstants.sendAnEmail, style: .default) { action -> Void in
            let composer = MFMailComposeViewController()
            if let emailId = contact.email {
                if MFMailComposeViewController.canSendMail() {
                    composer.setToRecipients([emailId])
                    composer.setSubject("Message Subject")
                    composer.setMessageBody("Message Body", isHTML: false)
                    self.present(composer, animated: true, completion: nil)
                }
            }
            
        }
        detailActionSheetController.view.tintColor = lightBlueColor
        detailActionSheetController.addAction(showDetailAction)
        detailActionSheetController.addAction(callAction)
        detailActionSheetController.addAction(sendAnEmailAction)
        detailActionSheetController.addAction(cancelAction)
        if UIDevice.isiPad() {
            detailActionSheetController.popoverPresentationController?.sourceView = self.view
            detailActionSheetController.popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: 1, height: 1)
        }
        self.present(detailActionSheetController, animated: true, completion: nil)
    }
    
}
// MARK:- UITableViewDataSource

extension ContactListingViewController:UITableViewDataSource,UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return contacts.count
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactViewCell.className, for: indexPath)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if let contactCell = cell as? ContactViewCell {
            let contact = contacts[indexPath.row]
            contactCell.configure(contact: contact)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = contacts[indexPath.row]
        handleSelectContact(contact: contact)
        tableView.deselectRow(at: indexPath, animated: true)

    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ContactStoreManager.shared.delete(contact: contacts[indexPath.row])
            if let indexToRemove = contacts.index(of:contacts[indexPath.row]) {
                contacts.remove(at: indexToRemove)
                showNoDataMessageIfNeeded()
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
// MARK:- NavigationBarViewDelegate

extension ContactListingViewController:NavigationBarViewDelegate {
    
    func didTapNavigationLeftButton(sender:Any) {
        
    }
    
    func didTapNavigationRightButton(sender:Any) {
        
        let detailController = ContactDetailViewController.instantiateViewController()
        detailController.viewMode = .enter
        self.present(detailController, animated: true, completion: nil)

    }
    
}

