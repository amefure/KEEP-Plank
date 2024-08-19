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
        GADMobileAds.sharedInstance().start(completionHandler: nil)

        // Firebase
        FirebaseApp.configure()

        // 通知申請
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
            if granted {
                UNUserNotificationCenter.current().delegate = self
            }
        }

        return true
    }

    // フォアグラウンドでも通知を有効にする
    func userNotificationCenter(
        _: UNUserNotificationCenter,
        willPresent _: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([[.banner, .list, .sound]])
    }
}

@main
struct PrankMemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
