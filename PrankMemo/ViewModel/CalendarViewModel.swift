//
//  CalendarViewModel.swift
//  PrankMemo
//
//  Created by t&a on 2025/07/03.
//
import Combine
import UIKit
import RealmSwift

class CalendarViewModel: ObservableObject {
    @MainActor static let shared = CalendarViewModel()

    private let dateFormatUtility = DateFormatUtility()

    // MARK: Calendar ロジック

    @Published var currentDates: [[SCDate]] = []
    @Published private(set) var currentYearAndMonth: [SCYearAndMonth] = []
    @Published private(set) var dayOfWeekList: [SCWeek] = []
    /// アプリに表示しているカレンダー年月インデックス番号
    @Published var displayCalendarIndex: CGFloat = 0

    /// 曜日始まり
    @Published private(set) var initWeek: SCWeek = .sunday
    
    @Published private(set) var pranks: [Plank] = []

    /// カレンダーをイニシャライズしたかどうか
    private var isInitializeFlag: Bool = false

    private let realmRepository: RealmRepository
    private let userDefaultsRepository: UserDefaultsRepository
    private let scCalenderRepository: SCCalenderRepository

    private var cancellables: Set<AnyCancellable> = []
    private var updateCancellable: AnyCancellable?

    deinit {
        updateCancellable?.cancel()
    }

    init(repositoryDependency: RepositoryDependency = RepositoryDependency()) {
        realmRepository = repositoryDependency.realmRepository
        userDefaultsRepository = repositoryDependency.userDefaultsRepository
        scCalenderRepository = repositoryDependency.scCalenderRepository

        getInitWeek()

        dayOfWeekList = setFirstWeek(week: initWeek)

        // 初回描画用に最新月だけ取得して表示する
        let today = Calendar(identifier: .gregorian).dateComponents([.year, .month, .day], from: Date())
        let yearAndMonth = SCYearAndMonth(year: today.year ?? 1, month: today.month ?? 1)
        let dates = scCalenderRepository.createDates(yearAndMonth: yearAndMonth, df: dateFormatUtility)
        currentDates = [dates]
        currentYearAndMonth = [yearAndMonth]
        scCalenderRepository.initialize(initWeek: initWeek)
    }

    public func onAppear() {
        
        scCalenderRepository.displayCalendarIndex
            .receive(on: DispatchQueue.main)
            .sink { [weak self] index in
                guard let self else { return }
                self.displayCalendarIndex = CGFloat(index)
                
                // 表示年月が変化するたびに取得する
                self.readAllPranks()
            }.store(in: &cancellables)
        
        scCalenderRepository.currentDates
            .receive(on: DispatchQueue.main)
            .sink { [weak self] dates in
                guard let self else { return }
                self.currentDates = dates
            }.store(in: &cancellables)
        
        scCalenderRepository.currentYearAndMonth
            .receive(on: DispatchQueue.main)
            .sink { [weak self] currentYearAndMonth in
                guard let self else { return }
                self.currentYearAndMonth = currentYearAndMonth
            }.store(in: &cancellables)
        
        scCalenderRepository.dayOfWeekList
            .receive(on: DispatchQueue.main)
            .sink { [weak self] list in
                guard let self else { return }
                self.dayOfWeekList = list
            }.store(in: &cancellables)
        
        readAllPranks()
    }

    public func onDisappear() {
        cancellables.forEach { $0.cancel() }
    }
}

// MARK: - Realm
extension CalendarViewModel {
    
    /// 全プランク情報を取得
    private func readAllPranks() {
        guard let yearAndMonth = getCurrentYearAndMonth else { return }
        let sorted = realmRepository.readAllPranks()
            .filter { [weak self] in
                guard let self else { return false }
                return self.dateFormatUtility.inMonth(date: $0.createdAt, year: yearAndMonth.year, month: yearAndMonth.month)
           }.sorted(by: { $0.createdAt > $1.createdAt })
        pranks = Array(sorted)
    }
    
    /// 全プランク情報を取得
    public func removePrank(id: ObjectId) {
        realmRepository.removePrank(removeIdArray: [id])
        readAllPranks()
    }
    
    public func getSumTime() -> Int {
        pranks.map { $0.miliseconds }.reduce(0, +)
    }
}

// MARK: - SCCalender

extension CalendarViewModel {
    /// 年月ページを1つ進める
    public func forwardMonthPage() {
        let count: Int = currentYearAndMonth.count
        let next = Int(min(displayCalendarIndex + 1, CGFloat(count)))
        scCalenderRepository.setDisplayCalendarIndex(index: next)
        // 最大年月まで2になったら翌月を追加する
        if displayCalendarIndex == CGFloat(count) - 2 {
            addNextMonth()
        }
    }

    /// 年月ページを1つ戻る
    public func backMonthPage() {
        if displayCalendarIndex == 2 {
            // 残り年月が2になったら前月を12ヶ月分追加する
            addPreMonth()
            // 2のタイミングで12ヶ月分追加するのでインデックスを+10
            let next = Int(displayCalendarIndex + 10)
            scCalenderRepository.setDisplayCalendarIndex(index: next)
        } else {
            let next = Int(displayCalendarIndex - 1)
            scCalenderRepository.setDisplayCalendarIndex(index: next)
        }
    }

    /// 現在表示中の年月を取得する
    public var getCurrentYearAndMonth: SCYearAndMonth? {
        return currentYearAndMonth[safe: Int(displayCalendarIndex)]
    }

    /// 格納済みの最新月の翌月を追加する
    private func addNextMonth() {
        _ = scCalenderRepository.addNextMonth()
    }

    /// 格納済みの最古月の前月を12ヶ月分追加する
    private func addPreMonth() {
        _ = scCalenderRepository.addPreMonth()
    }

    /// 週始まりを設定
    public func setFirstWeek(week: SCWeek) -> [SCWeek] {
        scCalenderRepository.setFirstWeek(week)
    }

    /// 今月にカレンダーを移動
    public func moveTodayCalendar() {
        // 今月の年月を取得
        let (year, month) = dateFormatUtility.getDateYearAndMonth()

        guard let displayYearAndMonth = currentYearAndMonth[safe: Int(displayCalendarIndex)] else { return }
        // 今月を表示しているなら更新しない
        guard displayYearAndMonth.month != month else { return }
        guard let todayIndex = currentYearAndMonth.firstIndex(where: { $0.year == year && $0.month == month }) else { return }
        displayCalendarIndex = CGFloat(todayIndex)
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

extension CalendarViewModel {
    /// 週始まりを取得
    private func getInitWeek() {
        let week = userDefaultsRepository.getIntData(key: UserDefaultsKey.INIT_WEEK)
        initWeek = SCWeek(rawValue: week) ?? SCWeek.sunday
    }
}
