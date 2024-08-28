//
//  MyHistoryViewModel.swift
//  PrankMemo
//
//  Created by t&a on 2024/08/19.
//

import UIKit
import Combine

class MyHistoryViewModel: ObservableObject {
    
    private let dateFormatUtility = DateFormatUtility()
    
    // MARK: Calendar ロジック
    @Published var currentDates: [[SCDate]] = []
    @Published private(set) var currentYearAndMonth: [SCYearAndMonth] = []
    @Published private(set) var dayOfWeekList: [SCWeek] = []
    
    // MARK: 永続化
    @Published private(set) var initWeek: SCWeek = .sunday
    

    // MARK: Dialog
    @Published var showOutOfRangeCalendarDialog = false

   
    private let realmRepository: RealmRepository
    private let userDefaultsRepository: UserDefaultsRepository
    private let scCalenderRepository: SCCalenderRepository
    
    private var cancellables: Set<AnyCancellable> = []
    
    @Published private(set) var pranks: [Prank] = []


    init(repositoryDependency: RepositoryDependency = RepositoryDependency()) {
        realmRepository = repositoryDependency.realmRepository
        userDefaultsRepository = repositoryDependency.userDefaultsRepository
        scCalenderRepository = repositoryDependency.scCalenderRepository
        
        getInitWeek()

        scCalenderRepository.currentDates.receive(on: DispatchQueue.main).sink { _ in
        } receiveValue: { [weak self] currentDates in
            guard let self else { return }
            self.currentDates = currentDates
        }.store(in: &cancellables)
        
        scCalenderRepository.currentYearAndMonth.sink { _ in
        } receiveValue: { [weak self] currentYearAndMonth in
            guard let self else { return }
            self.currentYearAndMonth = currentYearAndMonth
        }.store(in: &cancellables)
        
        scCalenderRepository.dayOfWeekList.sink { _ in
        } receiveValue: { [weak self] dayOfWeekList in
            guard let self else { return }
            self.dayOfWeekList = dayOfWeekList
        }.store(in: &cancellables)
        
        setFirstWeek(week: initWeek)
    }
    
    public func onAppear() {
        readAllPranks()
    }
}

// MARK: - Realm
extension MyHistoryViewModel {
    
    /// 全プランク情報を取得
    private func readAllPranks() {
        guard let yearAndMonth = currentYearAndMonth[safe: 1] else { return }
        pranks = Array(realmRepository.readAllPranks()
            .filter {
                self.dateFormatUtility.inMonth(date: $0.createdAt, year: yearAndMonth.year, month: yearAndMonth.month)
           }
            .sorted(by: { $0.createdAt > $1.createdAt }))
    }
    
    public func getSumTime() -> Int {
        pranks.map { $0.miliseconds }.reduce(0, +)
    }
}

// MARK: - SCCalender
extension MyHistoryViewModel {
    
    /// 年月を取得
    public func getCurrentYearAndMonth() -> String {
        return currentYearAndMonth[safe: 1]?.yearAndMonth ?? ""
    }
   
    /// 年月を1つ進める
    public func forwardMonth() {
        let result = scCalenderRepository.forwardMonth()
        showOutOfRangeCalendarDialog = !result
        readAllPranks()
    }

    /// 年月を1つ戻す
    public func backMonth() {
        let result = scCalenderRepository.backMonth()
        showOutOfRangeCalendarDialog = !result
        readAllPranks()
    }
    
    /// 週始まりを設定
    public func setFirstWeek(week: SCWeek) {
        scCalenderRepository.setFirstWeek(week)
    }
    
    /// カレンダー表示年月を指定して更新
    public func moveYearAndMonthCalendar(year: Int, month: Int) {
        scCalenderRepository.moveYearAndMonthCalendar(year: year, month: month)
    }
    
    /// 今月にカレンダーを移動
    public func moveToDayYearAndMonthCalendar() {
        guard let current = currentYearAndMonth[safe: 1] else { return  }
        let (year, month) = dateFormatUtility.getDateYearAndMonth()
        // 今月を表示しているなら更新しない
        if current.month != month {
            moveYearAndMonthCalendar(year: year, month: month)
        }
    }
    
    /// Poopが追加された際にカレンダー構成用のデータも更新
    public func addPoopUpdateCalender(createdAt: Date) {
        let (year, date) = getUpdateCurrentDateIndex(createdAt: createdAt)
        if year != -1 && date != -1 {
            currentDates[year][date].count += 1
        }
    }
    /// Poopが削除された際にカレンダー構成用のデータも更新
    public func deletePoopUpdateCalender(createdAt: Date) {
        let (year, date) = getUpdateCurrentDateIndex(createdAt: createdAt)
        if year != -1 && date != -1 {
            currentDates[year][date].count -= 1
        }
    }
    
    // 更新対象のインデックス番号を取得する
    private func getUpdateCurrentDateIndex(createdAt: Date) -> (Int, Int) {
        // 月でフィルタリング
        guard let index = currentYearAndMonth.firstIndex(where: { $0.month == dateFormatUtility.getDateYearAndMonth(date: createdAt).month }) else { return (-1, -1) }
        // 更新対象のSCDateを取得
        guard let index2 = currentDates[index].firstIndex(where: {
            if let date = $0.date {
                return dateFormatUtility.checkInSameDayAs(date: date, sameDay: createdAt)
            } else {
                return false
            }
        }) else { return (-1, -1) }
        return (index, index2)
    }
}



// MARK: - UserDefaults
extension MyHistoryViewModel {
    

    /// 週始まりを取得
    private func getInitWeek() {
        let week = userDefaultsRepository.getIntData(key: UserDefaultsKey.INIT_WEEK)
        initWeek = SCWeek(rawValue: week) ?? SCWeek.sunday
    }

    /// 週始まりを登録
    public func saveInitWeek(week: SCWeek) {
        initWeek = week
        userDefaultsRepository.setIntData(key: UserDefaultsKey.INIT_WEEK, value: week.rawValue)
    }
}
