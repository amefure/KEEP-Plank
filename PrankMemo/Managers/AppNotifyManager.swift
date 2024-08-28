//
//  AppNotifyManager.swift
//  PrankMemo
//
//  Created by t&a on 2024/08/19.
//

import UIKit
import UserNotifications

class AppNotifyManager {
    
    private let userDefaultsRepository: UserDefaultsRepository

    init(repositoryDependency: RepositoryDependency = RepositoryDependency()) {
        userDefaultsRepository = repositoryDependency.userDefaultsRepository
    }
    
    private let NOTIFY_ID = "NOTIFY_ID"
    
    /// 通知許可申請リクエスト
    public func requestAuthorization() {
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
        let alertController = UIAlertController(title: L10n.notifyRejectionTitle,
                                                message: L10n.notifyRejectionMsg,
                                                preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: L10n.notifyRejectionShowSetting, style: .default) { _ in
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


    public func sendNotificationRequest() {
        let content = UNMutableNotificationContent()
        content.title = NotifyConfig.INITIAL_TITLE


        content.body = userDefaultsRepository.getStringData(key: UserDefaultsKey.NOTICE_MSG, initialValue: NotifyConfig.INITIAL_MSG)

        let timeStr = userDefaultsRepository.getStringData(key: UserDefaultsKey.NOTICE_TIME, initialValue: NotifyConfig.INITIAL_TIME)

        // "H-m"形式で取得した文字列を配列に変換
        let timeArray = timeStr.split(separator: "-")

        let hour = Int(timeArray[safe: 0] ?? "19") ?? 19
        let minute = Int(timeArray[safe: 1] ?? "0") ?? 0

        // 毎週設定するために各曜日で登録する
        Weekday.allCases.forEach { week in
            var dateComponents = DateComponents()
            dateComponents.hour = hour
            dateComponents.minute = minute
            dateComponents.weekday = week.rawValue
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            let request = UNNotificationRequest(identifier: NOTIFY_ID + String(week.rawValue), content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request)
        }
    }

    public func removeNotificationRequest() {
        Weekday.allCases.forEach { week in
            let center = UNUserNotificationCenter.current()
            center.removePendingNotificationRequests(withIdentifiers: [NOTIFY_ID + String(week.rawValue)])
        }
    }
}


private enum Weekday: Int, CaseIterable {
    case sunday = 1
    case monday = 2
    case tuesday = 3
    case wednesday = 4
    case thursday = 5
    case friday = 6
    case saturday = 7
}
