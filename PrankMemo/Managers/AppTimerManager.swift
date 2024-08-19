//
//  AppTimerManager.swift
//  PrankMemo
//
//  Created by t&a on 2024/08/19.
//

import UIKit
import Combine

class AppTimerManager {
    
    public var time: AnyPublisher<Int, Never> {
        _time.eraseToAnyPublisher()
    }
    private let _time = CurrentValueSubject<Int, Never>(0)
    
    private var timer = Timer()
    
    
    public func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] _ in
            guard let self else { return }
            let time = _time.value + 1
            _time.send(time)
        })
    }
    
    /// タイマー中断
    public func stopTimer() {
        timer.invalidate()
    }
    
    public func resetTimer() {
        timer.invalidate()
        timer = Timer()
        _time.value = 0
    }
}
