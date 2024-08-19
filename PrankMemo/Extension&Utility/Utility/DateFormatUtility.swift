//
//  DateFormatUtility.swift
//  PrankMemo
//
//  Created by t&a on 2024/08/19.
//

import UIKit

class DateFormatUtility {
    
    private let df = DateFormatter()
    private var c = Calendar(identifier: .gregorian)
    
    init(format: String = "yyyy-MM-dd") {
        df.dateFormat = format
        df.locale = Locale(identifier: "ja_JP")
        c.timeZone = TimeZone(identifier: "Asia/Tokyo")!
        df.calendar = c
    }
}
    
// MARK: -　DateFormatter
extension DateFormatUtility {
    
    /// `Date`型を受け取り`String`型を返す
    public func getString(date: Date) -> String {
        return df.string(from: date)
    }
    
    /// `String`型を受け取り`Date`型を返す
    public func getDate(str: String) -> Date {
        return df.date(from: str) ?? Date()
    }
}

// MARK: -　Calendar
extension DateFormatUtility {
    
    /// `Date`型を受け取りその日の00:00:00の`Date`型を返す
    public func startOfDay(_ date: Date) -> Date {
        return c.startOfDay(for: date)
    }
    
    /// Date型の加算/減算
    /// - Parameters:
    ///   - date: 対象の日付
    ///   - by: 対象コンポーネント
    ///   - value: 値
    /// - Returns: 結果
    public func dateByAdding(_ date: Date, by: Calendar.Component, value: Int) -> Date {
        return c.date(byAdding: by, value: value, to: date) ?? Date()
    }
}
