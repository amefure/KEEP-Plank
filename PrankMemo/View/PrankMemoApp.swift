//
//  PrankMemoApp.swift
//  PrankMemo
//
//  Created by t&a on 2024/08/19.
//

import FirebaseCore
import Foundation
import GoogleMobileAds
import SwiftUI
import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_: UIApplication,
                     didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        // AdMob
        MobileAds.shared.start(completionHandler: nil)

        // Firebase
        FirebaseApp.configure()
        // UNUserNotificationCenterDelegateの適応
        UNUserNotificationCenter.current().delegate = self
        return true
    }

    // フォアグラウンドでも通知を有効にする
    nonisolated func userNotificationCenter(
        _: UNUserNotificationCenter,
        willPresent _: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([[.banner, .list, .sound]])
    }
}

@main
struct PrankMemoApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
