//
//  RepositoryDependency.swift
//  PrankMemo
//
//  Created by t&a on 2024/08/19.
//

import UIKit

/// `Repository` & `Manager` クラスのDIクラス
class RepositoryDependency {
    
    public let realmRepository: RealmRepository
    public let userDefaultsRepository: UserDefaultsRepository   
    
    //　シングルトンインスタンスをここで保持する
    static let sharedRealmRepository = RealmRepository()
    static let sharedUserDefaultsRepository = UserDefaultsRepository()

    init() {
        realmRepository = RepositoryDependency.sharedRealmRepository
        userDefaultsRepository = RepositoryDependency.sharedUserDefaultsRepository
    }
}

