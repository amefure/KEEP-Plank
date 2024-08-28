//
//  RepositoryDependency.swift
//  PrankMemo
//
//  Created by t&a on 2024/08/19.
//

import UIKit

/// `Repository` クラスのDIクラス
class RepositoryDependency {
    
    /// `Repository`
    public let realmRepository: RealmRepository
    public let userDefaultsRepository: UserDefaultsRepository
    public let scCalenderRepository: SCCalenderRepository
    
    
    //　シングルトンインスタンスをここで保持する
    static let sharedRealmRepository = RealmRepository()
    static let sharedUserDefaultsRepository = UserDefaultsRepository()
    static let sharedScCalenderRepository = SCCalenderRepository()

    init() {
        realmRepository = RepositoryDependency.sharedRealmRepository
        userDefaultsRepository = RepositoryDependency.sharedUserDefaultsRepository
        scCalenderRepository = RepositoryDependency.sharedScCalenderRepository
    }
}

