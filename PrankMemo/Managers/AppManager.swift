//
//  AppManager.swift
//  PrankMemo
//
//  Created by t&a on 2024/08/28.
//

import UIKit

class AppManager: NSObject {
    static let sharedAppNotifyManager = AppNotifyManager()
    static let sharedAppTimerManager = AppTimerManager()
}

