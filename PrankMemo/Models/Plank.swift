//
//  Plank.swift
//  PrankMemo
//
//  Created by t&a on 2024/08/19.
//

import RealmSwift

class Plank: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    /// msだが単位は100ms
    /// 315 なら 3150ms になる
    @Persisted var miliseconds: Int = 0
    /// 作成日
    @Persisted var createdAt = Date()
}
