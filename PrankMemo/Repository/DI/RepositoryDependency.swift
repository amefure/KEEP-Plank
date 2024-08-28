//
//  RepositoryDependency.swift
//  PrankMemo
//
//  Created by t&a on 2024/08/19.
//

import UIKit

/// `Repository` & `Manager` クラスのDIクラス
class RepositoryDependency {
    
    /// `Repository`
    public let realmRepository: RealmRepository
    public let userDefaultsRepository: UserDefaultsRepository
    public let scCalenderRepository: SCCalenderRepository
    
    /// `Manager`
    public let appNotifyManager: AppNotifyManager
    public let appTimerManager: AppTimerManager
    
    
    //　シングルトンインスタンスをここで保持する
    static let sharedRealmRepository = RealmRepository()
    static let sharedUserDefaultsRepository = UserDefaultsRepository()
    static let sharedScCalenderRepository = SCCalenderRepository()
    static let sharedAppNotifyManager = AppNotifyManager()
    static let sharedAppTimerManager = AppTimerManager()

    init() {
        realmRepository = RepositoryDependency.sharedRealmRepository
        userDefaultsRepository = RepositoryDependency.sharedUserDefaultsRepository
        appNotifyManager = RepositoryDependency.sharedAppNotifyManager
        appTimerManager = RepositoryDependency.sharedAppTimerManager
        scCalenderRepository = RepositoryDependency.sharedScCalenderRepository
    }
}

