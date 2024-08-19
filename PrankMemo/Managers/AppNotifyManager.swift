//
//  AppNotifyManager.swift
//  PrankMemo
//
//  Created by t&a on 2024/08/19.
//

import UIKit
import UserNotifications

class AppNotifyManager {
    
    init() {
        requestAuthorization()
    }
    
    /// 通知許可申請リクエスト
    private func requestAuthorization() {
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter
            .current()
            .requestAuthorization(options: authOptions) { [weak self] granted, error in
                guard let self else { return }
                if !granted {
                    // 通知が拒否された場合の処理
                    DispatchQueue.main.async {
                        self.showSettingsAlert()
                    }
                }
            }
    }
    
    /// 通知が許可されていない場合にアラートで通知許可を促す
    private func showSettingsAlert() {
        let alertController = UIAlertController(title: "通知が許可されていません",
                                                message: "設定アプリから通知を有効にしてください。",
                                                preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "設定を開く", style: .default) { _ in
            guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(settingsURL) {
                UIApplication.shared.open(settingsURL)
            }
        }
        let cancelAction = UIAlertAction(title: L10n.dialogButtonCancel, style: .cancel, handler: nil)
        
        alertController.addAction(settingsAction)
        alertController.addAction(cancelAction)
        

        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let rootVC = windowScene?.windows.first?.rootViewController
        rootVC?.present(alertController, animated: true, completion: {})
    }

    
}

