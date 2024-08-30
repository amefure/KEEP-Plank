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

    public func getTheDateCount(date: Date) -> Int {
        let df = DateFormatUtility()
        // 指定した日付
        let specifiedDate = df.startOfDay(date)
        let nextDay =  df.dateByAdding(specifiedDate, by: .day, value: 1)

        let predicate = NSPredicate(format: "createdAt >= %@ AND createdAt < %@", specifiedDate as NSDate, nextDay as NSDate)
        
        let results = realm.objects(Plank.self).filter(predicate)

        // リストのカウントを返す
        return results.count
    }

    /// Create
    public func createPrank(Prank: Plank) {
        try! realm.write {
            realm.add(Prank)
        }
    }

    /// Read
    public func readAllPranks() -> Results<Plank> {
        try! realm.write {
            let Pranks = realm.objects(Plank.self)
            // Deleteでクラッシュするため凍結させる
            return Pranks.freeze().sorted(byKeyPath: "id", ascending: true)
        }
    }

    /// Update
    public func updatePrank(id: ObjectId, newPrank: Plank) {
        try! realm.write {
            guard let result = realm.objects(Plank.self).where({ $0.id == id }).first else {
                return
            }
        }
    }

    /// Remove
    public func removePrank(removeIdArray: [ObjectId]) {
        let predicate = NSPredicate(format: "id IN %@", removeIdArray)
        let objectsToDelete = realm.objects(Plank.self).filter(predicate)

        try! realm.write {
            realm.delete(objectsToDelete)
        }
    }
}

