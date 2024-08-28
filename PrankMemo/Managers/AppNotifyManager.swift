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


    public func sendNotificationRequest(_ userName: String, _ date: Date) {
        let content = UNMutableNotificationContent()
        content.title = "プランクメモ"


        content.body = ""

        // Setting > TimePickerView.swift
        //let timeStr = // userDefaultsRepository.getStringData(key: UserDefaultsKey.NOTICE_TIME, initialValue: NotifyConfig.INITIAL_TIME)

        var dateStr = ""

        // dateStr = DateFormatUtility().getNotifyString(date: date)

        // "yyyy-MM-dd"形式で取得した文字列を配列に変換
        let dateArray = dateStr.split(separator: "-")
        // "H-m"形式で取得した文字列を配列に変換
        //let timeArray = timeStr.split(separator: "-")

        let month = Int(dateArray[safe: 1] ?? "1") ?? 1
        let day = Int(dateArray[safe: 2] ?? "1") ?? 1
        let hour = Int(timeArray[safe: 0] ?? "6") ?? 6
        let minute = Int(timeArray[safe: 1] ?? "0") ?? 0

        let dateComponent = DateComponents(
            month: month,
            day: day,
            hour: hour,
            minute: minute
        )

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
        let request = UNNotificationRequest(identifier: NOTIFY_ID, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }

    public func removeNotificationRequest() {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [NOTIFY_ID])
    }
}

