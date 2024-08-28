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
    private let realmRepository: RealmRepository

    init(repositoryDependency: RepositoryDependency = RepositoryDependency()) {
        realmRepository = repositoryDependency.realmRepository
        appTimerManager = repositoryDependency.appTimerManager
    }
    
    public func onAppear() {
        appTimerManager.time.sink { [weak self] time in
            guard let self else { return }
            self.time = time
        }.store(in: &cancellables)
    }
}

// MARK: Timer
extension EntryPrankViewModel {
    
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
extension EntryPrankViewModel {
    public func createPrank() {
        let prank = Prank()
        prank.createdAt = Date()
        prank.miliseconds = time
        realmRepository.createPrank(Prank: prank)
    }
}
