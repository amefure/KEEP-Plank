//
//  MyDataViewModel.swift
//  PrankMemo
//
//  Created by t&a on 2024/08/27.
//

import SwiftUI
import Combine

class MyDataViewModel: ObservableObject {
    
    private let dateFormatUtility = DateFormatUtility()
    
    private let realmRepository: RealmRepository
    private let userDefaultsRepository: UserDefaultsRepository
    
    private var cancellables: Set<AnyCancellable> = []
    
    @Published private(set) var pranks: [Plank] = []
    @Published var time = Date()
    @Published var notifyFlag = false
    
    init(repositoryDependency: RepositoryDependency = RepositoryDependency()) {
        realmRepository = repositoryDependency.realmRepository
        userDefaultsRepository = repositoryDependency.userDefaultsRepository
    }
    
    public func onAppear() {
        readAllPranks()
        time = getNotifyTimeDate()
        notifyFlag = getNotifyFlag()
        
        $time.sink(receiveValue: { [weak self] date in
            guard let self else { return }
            self.saveNotifyTime(date: date)
            // 通知設定がONなら新しい時間で設定し直す
            if notifyFlag {
                // 削除してから再登録
                AppManager.sharedAppNotifyManager.removeNotificationRequest()
                AppManager.sharedAppNotifyManager.sendNotificationRequest()
            }
        }).store(in: &cancellables)
        
        
        $notifyFlag.sink(receiveValue: { [weak self] flag in
            guard let self else { return }
            self.saveNotifyFlag(isOn: flag)
            if flag {
                AppManager.sharedAppNotifyManager.requestAuthorization()
                // 通知を登録
                AppManager.sharedAppNotifyManager.sendNotificationRequest()
            } else {
                // 通知を削除
                AppManager.sharedAppNotifyManager.removeNotificationRequest()
            }
        }).store(in: &cancellables)
    }
    
    public func onDisappear() {
        cancellables.removeAll()
    }
}

// MARK: - Realm
extension MyDataViewModel {
    
    /// 全プランク情報を取得
    private func readAllPranks() {
        pranks = Array(realmRepository.readAllPranks()
            .sorted(by: { $0.createdAt > $1.createdAt }))
    }
    
    public func getSumTime() -> Int {
        let today = Date()
        let startOfMonth = dateFormatUtility.startOfMonth(today)
        
        var endOfMonthComponents = DateComponents()
        endOfMonthComponents.month = 1
        endOfMonthComponents.day = -1
        let endOfMonth = dateFormatUtility.dateByAdding(startOfMonth, byAdding: endOfMonthComponents)
        
        let currentMonthList = pranks.filter { prank in
            let date = prank.createdAt
            return date >= startOfMonth && date <= endOfMonth
        }
        return currentMonthList.map { $0.miliseconds }.reduce(0, +)
    }
    
    func daysOfContinuousRecords() -> Int {
        let today = Date()
        // レコードの日付を取得してソート
        let dates = Set(pranks.map { dateFormatUtility.startOfDay($0.createdAt) }).sorted(by: { $0 > $1 })
        // 今日の日付から過去に向かって日付をチェック
        var consecutiveDaysCount = 0
        var currentDate = today
        for date in dates {
            // 日付が連続しているかをチェック
            if dateFormatUtility.checkInSameDayAs(date: date, sameDay: currentDate) {
                consecutiveDaysCount += 1
                // 現在の日付を1日減らす
                currentDate = dateFormatUtility.dateByAdding(currentDate, by: .day, value: -1)
            } else {
                break
            }
        }
        return consecutiveDaysCount
    }
    
    
    /// MoneyRecordを月毎にセクション分けした辞書型に変換する
    public func dayMoneyRecordDictionary() -> [Date: [Plank]]? {
        let today = Date()
        var groupedRecords = Dictionary(grouping: pranks) { [weak self] prank in
            guard let self else { return today }
            return dateFormatUtility.startOfMonth(prank.createdAt)
        }
        if (groupedRecords.isEmpty) {
            return nil
        }
        // 今月のDate型を取得
        let currentMonth = dateFormatUtility.startOfMonth(today)
        
        // 6ヶ月前の日付を計算
        let sixMonthsAgo = dateFormatUtility.dateByAdding(currentMonth, by: .month, value: -6)
        
        // 6ヶ月前の日付の月単位の最初の日
        let startDate = dateFormatUtility.startOfMonth(sixMonthsAgo)
        
        var date = startDate
        
        while date <= today {
            // 現在の月の最初の日付をキーとして辞書に存在しない場合、空の配列で追加
            if groupedRecords[date] == nil {
                groupedRecords[date] = []
            }
            // 次の月の最初の日付を計算
            let nextMonth = dateFormatUtility.dateByAdding(date, by: .month, value: 1)
            date = dateFormatUtility.startOfMonth(nextMonth)
        }
        return groupedRecords
    }
}

// MARK: - UserDefaluts
extension MyDataViewModel {

    /// 通知時間取得
    private func getNotifyTimeDate() -> Date {
        var timeStr = userDefaultsRepository.getStringData(key: UserDefaultsKey.NOTICE_TIME)
        if timeStr.isEmpty {
            timeStr = NotifyConfig.INITIAL_TIME
        }
        let timeArray: [Substring] = timeStr.split(separator: "-")
        let hour = Int(timeArray[safe: 0] ?? "19")
        let minute = Int(timeArray[safe: 1] ?? "0")
        return  dateFormatUtility.convertComponentsDate(datDateComponentse: DateComponents(hour: hour, minute: minute))
    }

    /// 通知時間登録
    private func saveNotifyTime(date: Date) {
        let df = DateFormatUtility(format: "H-mm")
        let time = df.getString(date: date)
        userDefaultsRepository.setStringData(key: UserDefaultsKey.NOTICE_TIME, value: time)
    }

    
    /// 通知フラグ取得
    private func getNotifyFlag() -> Bool {
        userDefaultsRepository.getBoolData(key: UserDefaultsKey.NOTICE_FLAG)
    }

    /// 通知フラグ登録
    private func saveNotifyFlag(isOn: Bool) {
        userDefaultsRepository.setBoolData(key: UserDefaultsKey.NOTICE_FLAG, isOn: isOn)
    }
}
