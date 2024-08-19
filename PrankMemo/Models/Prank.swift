//
//  Prank.swift
//  PrankMemo
//
//  Created by t&a on 2024/08/19.
//

import RealmSwift

class Prank: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var seconds: Int = 0
    @Persisted var createdAt = Date()
}
