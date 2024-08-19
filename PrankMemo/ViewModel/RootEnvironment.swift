//
//  RootEnvironment.swift
//  PrankMemo
//
//  Created by t&a on 2024/08/19.
//

import UIKit

/// アプリ内で共通で利用される状態や環境値を保持する
class RootEnvironment: ObservableObject {
    static let shared = RootEnvironment()

    private let userDefaultsRepository: UserDefaultsRepository

    init(repositoryDependency: RepositoryDependency = RepositoryDependency()) {
        userDefaultsRepository = repositoryDependency.userDefaultsRepository
    }
}
