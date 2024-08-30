//
//  EntryPlankViewModel.swift
//  PrankMemo
//
//  Created by t&a on 2024/08/19.
//

import UIKit
import Combine

/// プランク記録登録画面
class EntryPlankViewModel: ObservableObject {

    @Published private(set) var time: Int = 0
    
    private var cancellables = Set<AnyCancellable>()
    
    private let appTimerManager = AppManager.sharedAppTimerManager
    private let realmRepository: RealmRepository

    init(repositoryDependency: RepositoryDependency = RepositoryDependency()) {
        realmRepository = repositoryDependency.realmRepository
    }
    
    public func onAppear() {
        appTimerManager.time.sink { [weak self] time in
            guard let self else { return }
            self.time = time
        }.store(in: &cancellables)
    }
}

// MARK: Timer
extension EntryPlankViewModel {
    
    public func startTimer() {
        appTimerManager.startTimer()
    }
    
    public func stopTimer() {
        appTimerManager.stopTimer()
    }
    
    public func resetTimer() {
        appTimerManager.resetTimer()
    }

}


// MARK: Prank
extension EntryPlankViewModel {
    public func createPrank() {
        let prank = Plank()
        prank.createdAt = Date()
        prank.miliseconds = time
        realmRepository.createPrank(Prank: prank)
    }
    /// デバッグ用
    public func createDemoPranks() {
        let calendar = Calendar.current
        let today = Date()
        // 今日から2週間前までの範囲を設定
        guard let twoWeeksAgo = calendar.date(byAdding: .day, value: -180, to: today) else {
            return
        }
        
        var date = twoWeeksAgo
        while date <= today {
            let prank = Plank()
            prank.createdAt = date
            
            // ランダムな秒数を生成
            prank.miliseconds = Int.random(in: 0..<10000) // 0秒から1時間以内のランダムな秒数

            // Prankデータを保存
            realmRepository.createPrank(Prank: prank)
            
            // 次の日に進める
            guard let nextDate = calendar.date(byAdding: .day, value: 1, to: date) else {
                print("Failed to calculate next date.")
                return
            }
            date = nextDate
        }
    }
}
