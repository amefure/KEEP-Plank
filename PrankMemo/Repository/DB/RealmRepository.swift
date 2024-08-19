//
//  RealmRepository.swift
//  PrankMemo
//
//  Created by t&a on 2024/08/19.
//

import RealmSwift
import UIKit

class RealmRepository {
    
    init() {
        let config = Realm.Configuration(schemaVersion: RealmConfig.MIGRATION_VERSION)
        Realm.Configuration.defaultConfiguration = config
        realm = try! Realm()
    }

    private let realm: Realm


    /// Create
    public func createPrank(Prank: Prank) {
        try! realm.write {
            realm.add(Prank)
        }
    }

    /// Read
    public func readAllPranks() -> Results<Prank> {
        try! realm.write {
            let Pranks = realm.objects(Prank.self)
            // Deleteでクラッシュするため凍結させる
            return Pranks.freeze().sorted(byKeyPath: "id", ascending: true)
        }
    }

    /// Update
    public func updatePrank(id: ObjectId, newPrank: Prank) {
        try! realm.write {
            guard let result = realm.objects(Prank.self).where({ $0.id == id }).first else {
                return
            }
        }
    }

    /// Remove
    public func removePrank(removeIdArray: [ObjectId]) {
        let predicate = NSPredicate(format: "id IN %@", removeIdArray)
        let objectsToDelete = realm.objects(Prank.self).filter(predicate)

        try! realm.write {
            realm.delete(objectsToDelete)
        }
    }
}

