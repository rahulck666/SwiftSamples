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
        } catch _ {}
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
    
    

}
