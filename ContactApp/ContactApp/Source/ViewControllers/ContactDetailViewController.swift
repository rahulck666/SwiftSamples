//
//  ContactDetailViewController.swift
//  ContactApp
//
//  Created by RAHUL CK on 8/19/17.
//  Copyright © 2017 Farabi. All rights reserved.
//

import UIKit
import ImagePicker
import DatePickerDialog

enum ContactDetailViewMode {
    case enter
    case view
    case edit
}
protocol ContactDetailViewControllerDelegate:NSObjectProtocol {
    func didUserChange(contact:Contact)
    func didUserAdd(contact:Contact)
    
}
class ContactDetailViewController: UIViewController {
    
    @IBOutlet weak var birthDateSelectionbutton: UIButton!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var birthDateTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var navigationBarView: NavigationBarView!
    var selectedProfileImage:UIImage?
    var viewMode:ContactDetailViewMode = .edit
    var contact = Contact()
    var selectedDate:Date?
    weak var delegate:ContactDetailViewControllerDelegate?
    
    class func instantiateViewController()-> ContactDetailViewController {
        let viewController = UIStoryboard.main().instantiateViewController(withIdentifier: ContactDetailViewController.className) as! ContactDetailViewController
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
    
    // MARK:- Setup methods
    func doInitialSetup()  {
        setUpNavigationBarView(for: self.viewMode)
        let tapGestureForImage = UITapGestureRecognizer(target: self, action: #selector(ContactDetailViewController.profileImageTapped))
        tapGestureForImage.numberOfTapsRequired = 1
        self.profileImageView.isUserInteractionEnabled = true
        self.profileImageView.addGestureRecognizer(tapGestureForImage)
        updateUIFor(viewMode: viewMode)
    }
    
    func setUpNavigationBarView(for mode:ContactDetailViewMode) {
        navigationBarView.configure(title: LocalizeStringConstants.contactListingTitle, isLeftButtonHidden: false, isRightButtonHidden: false)
        switch mode {
        case .view:
            navigationBarView.setLeftButtonTitle(LocalizeStringConstants.back)
            navigationBarView.setRightButtonTitle(LocalizeStringConstants.edit)
            break
        case .edit:
            navigationBarView.setLeftButtonTitle(LocalizeStringConstants.back)
            navigationBarView.setRightButtonTitle(LocalizeStringConstants.save)
            break
        case .enter:
            navigationBarView.setLeftButtonTitle(LocalizeStringConstants.cancel)
            navigationBarView.setRightButtonTitle(LocalizeStringConstants.save)
            break
        }
        
        navigationBarView.delegate = self
    }
    
    // MARK:- UpdateUI methods
    
    func updateUIFor(viewMode:ContactDetailViewMode)  {
        var isEditable = true
        switch viewMode {
        case .view:
            isEditable = false
            updateUI(with: contact)
            break
        case .edit:
            isEditable = true
            updateUI(with: contact)
            break
        case .enter:
            isEditable = true
            break
        }
        emailTextField.isUserInteractionEnabled = isEditable
        firstNameTextField.isUserInteractionEnabled = isEditable
        lastNameTextField.isUserInteractionEnabled = isEditable
        addressTextField.isUserInteractionEnabled = isEditable
        mobileTextField.isUserInteractionEnabled = isEditable
        profileImageView.isUserInteractionEnabled = isEditable
        birthDateSelectionbutton.isUserInteractionEnabled = isEditable
        setUpNavigationBarView(for: viewMode)
        
    }
    
    func updateUI(with contact:Contact) {
        firstNameTextField.text = contact.firstName ?? ""
        lastNameTextField.text = contact.lastName ?? ""
        emailTextField.text = contact.email ?? ""
        addressTextField.text = contact.address ?? ""
        mobileTextField.text = contact.mobile ?? ""
        birthDateTextField.text = contact.birthDate?.description ?? ""
        selectedDate = contact.birthDate
        profileImageView.image = contact.profilePic
        if let date = contact.birthDate {
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = DateFormat.format1.rawValue
            self.birthDateTextField.text = dateFormater.string(from: date)
        }
    }
    
    // MARK:- UI Callback methods
    @IBAction func selectbirthDateTapped(_ sender: Any) {
        DatePickerDialog().show(title: LocalizeStringConstants.datePickerTitle, doneButtonTitle: LocalizeStringConstants.done, cancelButtonTitle: LocalizeStringConstants.cancel, datePickerMode: .date) {
            (date) -> Void in
            if let date = date {
                let dateFormater = DateFormatter()
                dateFormater.dateFormat = DateFormat.format1.rawValue
                self.birthDateTextField.text = dateFormater.string(from: date)
                self.selectedDate =  date
            }
        }
    }
    
    func profileImageTapped() {
        let imagePickerController = ImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.imageLimit = 1
        present(imagePickerController, animated: true, completion: nil)
    }
    
    // MARK:- Validation Related methods
    
    func validateUserField() -> Bool {
        
        var isValid = true
        var message = MessageConstants.invalidUserDetails
        if (firstNameTextField.text?.isEmpty ?? true) == true {
            message = MessageConstants.invalidFirstNameMessage
            firstNameTextField.becomeFirstResponder()
            isValid = false
            
        }
        else if (lastNameTextField.text?.isEmpty ?? true) == true {
            message = MessageConstants.invalidLastNameMessage
            lastNameTextField.becomeFirstResponder()
            isValid = false
        }
        else if !Utility.isValid(phoneNumber: mobileTextField.text) {
            message = MessageConstants.invalidMobileMessage
            mobileTextField.becomeFirstResponder()
            isValid = false
        }
        else if !Utility.isValid(emailAddress: emailTextField.text) {
            message = MessageConstants.invalidEmailMessage
            emailTextField.becomeFirstResponder()
            isValid = false
        }
        
        if isValid == false {
            showAlert(with: MessageConstants.errorAlertTitle, message: message,okAction: {})
        }
        return isValid
    }
    
    func showAlert(with title:String,message:String,okAction:@escaping () -> ())  {
        let alertController = UIAlertController(title:title , message: message, preferredStyle: .alert)
        let OkAction = UIAlertAction(title: LocalizeStringConstants.ok, style: .default) { (action:UIAlertAction!) in
            okAction()
        }
        alertController.addAction(OkAction)
        self.present(alertController, animated: true, completion:nil)
    }
}
// MARK:- NavigationBarViewDelegate

extension ContactDetailViewController:NavigationBarViewDelegate {
    
    func didTapNavigationLeftButton(sender:Any) {
        switch viewMode {
        case .edit,.view:
            _ = self.navigationController?.popViewController(animated: true)
            break
        case .enter:
            self.dismiss(animated: true, completion: nil)
            break
        }
    }
    
    func didTapNavigationRightButton(sender:Any) {
        
        guard validateUserField() else {
            return
        }
        switch viewMode {
        case .edit:
            ContactStoreManager.shared.edit(contact: contact, editBlock: { () in
                contact.firstName = firstNameTextField.text ?? ""
                contact.lastName = lastNameTextField.text ?? ""
                contact.email = emailTextField.text ?? ""
                contact.mobile = mobileTextField.text ?? ""
                contact.address = addressTextField.text ?? ""
                contact.birthDate = selectedDate
                contact.profilePic = profileImageView.image
            })
            showAlert(with: MessageConstants.success, message: MessageConstants.savedSuccessfully, okAction: {
                _ = self.navigationController?.popViewController(animated: true)
            })
            self.delegate?.didUserChange(contact: contact)
            break
        case .enter:
            contact.firstName = firstNameTextField.text ?? ""
            contact.lastName = lastNameTextField.text ?? ""
            contact.email = emailTextField.text ?? ""
            contact.mobile = mobileTextField.text ?? ""
            contact.address = addressTextField.text ?? ""
            contact.birthDate = selectedDate
            contact.profilePic = profileImageView.image
            ContactStoreManager.shared.save(contact: contact)
            showAlert(with: MessageConstants.success, message: MessageConstants.savedSuccessfully, okAction: {
                self.dismiss(animated: true, completion: nil)
            })
            self.delegate?.didUserAdd(contact: contact)
            
        case .view:
            viewMode = .edit
            updateUIFor(viewMode: .edit)
        }
    }
    
}
// MARK:- ImagePickerDelegate

extension ContactDetailViewController:ImagePickerDelegate {
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        self.dismiss(animated: true, completion: nil)
        selectedProfileImage = images.first
        profileImageView.image = selectedProfileImage
        
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        self.dismiss(animated: true, completion: nil)
        
        selectedProfileImage = images.first
        profileImageView.image = selectedProfileImage
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}
// MARK:- UITextFieldDelegate
extension ContactDetailViewController:UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField .resignFirstResponder()
        return true
    }
}

