//
//  SCWeek.swift
//  PrankMemo
//
//  Created by t&a on 2024/08/19.
//

import UIKit
import SwiftUI

enum SCWeek: Int, CaseIterable {
    case sunday = 0
    case monday = 1
    case tuesday = 2
    case wednesday = 3
    case thursday = 4
    case friday = 5
    case saturday = 6
    
    public var fullSymbols: String {
        switch self {
        case .sunday: return "日曜日"
        case .monday: return "月曜日"
        case .tuesday: return "火曜日"
        case .wednesday: return "水曜日"
        case .thursday: return "木曜日"
        case .friday: return "金曜日"
        case .saturday: return "土曜日"
        }
    }
    
    public var shortSymbols: String {
        switch self {
        case .sunday: return "SUN"
        case .monday: return "MON"
        case .tuesday: return "TUE"
        case .wednesday: return "WED"
        case .thursday: return "THU"
        case .friday: return "FRI"
        case .saturday: return "SAT"
        }
    }
    
    public var color: Color {
        switch self {
        case .sunday: return .red
        case .saturday: return .blue
        default: return Asset.Colors.themaBlack.swiftUIColor
        }
    }
}

extension Array where Element == SCWeek {
    mutating func moveWeekToFront(_ week: SCWeek) {
        guard let index = firstIndex(of: week) else { return }
        self = Array(self[index...] + self[..<index])
    }
}
