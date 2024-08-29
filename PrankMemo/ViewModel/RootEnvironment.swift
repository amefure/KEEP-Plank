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
    
    @Published var isCouting = false

    private let userDefaultsRepository: UserDefaultsRepository

    init(repositoryDependency: RepositoryDependency = RepositoryDependency()) {
        userDefaultsRepository = repositoryDependency.userDefaultsRepository
    }
    
    /// `XX分XX秒XX`形式の文字列で取得
    public func getTimeString(_ timeInMillis: Int) -> (String, String, String) {
        // ミリ秒単位から分と秒とミリ秒に変換
        // 保存しているのは100ms単位のため1000ではなく100で割る
        let totalSeconds = timeInMillis / 100
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        let milliseconds = timeInMillis % 100
        
        let minutesStr = String(format: "%01d" + L10n.minuteUnit, minutes)
        let secondsStr = String(format: "%01d" + L10n.secondUnit, seconds)
        let millisecondsStr = String(format: "%02d", milliseconds)
        return (minutesStr, secondsStr, millisecondsStr)
    }
}
