//
//  EntryPrankViewModel.swift
//  PrankMemo
//
//  Created by t&a on 2024/08/19.
//

import UIKit
import Combine

/// プランク記録登録画面
class EntryPrankViewModel: ObservableObject {

    @Published private(set) var time: Int = 0
    
    private var cancellables = Set<AnyCancellable>()
    
    private let appTimerManager: AppTimerManager

    init(repositoryDependency: RepositoryDependency = RepositoryDependency()) {
        appTimerManager = repositoryDependency.appTimerManager
    }
    
    public func onAppear() {
        appTimerManager.time.sink { time in
            self.time = time
        }.store(in: &cancellables)
    }
    
    public func startTimer() {
        appTimerManager.startTimer()
    }
    
    public func stopTimer() {
        appTimerManager.stopTimer()
    }
    
    public func resetTimer() {
        appTimerManager.resetTimer()
    }
    
    /// `XX分XX秒`形式の文字列で取得
    public func getTimeString() -> String {
        let minutes = Int(time / 60)
        let second = Int(time) % 60
        // let milliSecond = Int(time * 100) % 100
        return String(format: "%02d分%02d秒", minutes, second)
    }
}
