//
//  ContactStoreManager.swift
//  ContactApp
//
//  Created by RAHUL CK on 8/17/17.
//  Copyright © 2017 Farabi. All rights reserved.
//

import UIKit
import RealmSwift

struct ContactStoreManager {
    
    static let shared = ContactStoreManager() // Singleton Instance
    
    /**
     Add or update Contact
     - parameter contact: Contact
     */
    func save(contact: Contact) -> Void {
        
        let realm: Realm = RealmDBManager.sharedInstance.realmRef()
        
        // To Generate AutoIncrement primary key.Since all contact field should be editable we can't use any field as primary key
        if contact.identifier == 0 {
            contact.identifier = (realm.objects(Contact.self).max(ofProperty: "identifier")
                as Int? ?? 0) + 1
        }
        do {
            try realm.write {
                realm.add(contact, update: true)
            }
        } catch {
            assert(false, "Can't add contact in realm")
        }
        // Write Profile Image to document directory if any
        if let profilePic = contact.profilePic {
            FileManagerHelper.writeImage(profilePic, fileName:String(contact.identifier))
        }
    }
    /**
     Edit contact
     - parameter contact: Contact
     - parameter editBlock: Changes for contact
     
     */
    func edit(contact:Contact, editBlock:(Void) -> Void) -> Void {
        let realm: Realm? = RealmDBManager.sharedInstance.realmRef()
        do {
            try realm?.write {
                editBlock()
            }
        } catch {
            assert(false, "Can't add contact in realm")
        }
        // Write Profile Image to document directory if any
        if let profilePic = contact.profilePic {
            FileManagerHelper.writeImage(profilePic, fileName:String(contact.identifier))
        }
        
        
    }
    
    /**
     Fetch All Contacts
     - returns: [Contact]
     */
    func allContacts() -> [Contact] {
        let realm: Realm? = RealmDBManager.sharedInstance.realmRef()
        
        if let contacts = realm?.objects(Contact.self) {
            return Array(contacts)
        }
        return Array()
    }
    /**
     Delete a Contact
     - parameter contact: Contact
     */
    func delete(contact:Contact) {
        do {
            let fileUrl = FileManager.urlForSavingProfileImage(fileName: String(contact.identifier))
            try FileManager.default.removeItem(at: fileUrl)
            
            let realm: Realm? = RealmDBManager.sharedInstance.realmRef()
            try realm?.write {
                realm?.delete(contact)
            }
        } catch {
            assert(false, "Can't delete the contact in realm")
        }
        
    }
    
    
    
    
}
