//
//  RealmDBManager.swift
//  ContactApp
//
//  Created by RAHUL CK on 8/17/17.
//  Copyright © 2017 Farabi. All rights reserved.
//
import Foundation
import RealmSwift

class RealmDBManager {
    
    static let sharedInstance = RealmDBManager() // Singleton Instance
    
    private var realmReference: Realm?
    
    init() {
        configRealmForMigration()
        do {
            realmReference = try Realm()
        } catch let error as NSError {
            debugPrint(error.debugDescription)
        }
    }
    
    func realmRef() -> Realm {
        return self.realmReference!
    }
    
    func configRealmForMigration() {
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 91,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema versio n lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion > 91) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
        })
        
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
        debugPrint("Realm db path: ")
        debugPrint(config.fileURL ?? "")
        
    }
    
    class func migrte(){
        Realm.Configuration.defaultConfiguration.deleteRealmIfMigrationNeeded = true
    }
}
