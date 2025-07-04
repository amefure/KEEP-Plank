//
//  RootTab.swift
//  PrankMemo
//
//  Created by t&a on 2025/07/03.
//

enum RootTab: CaseIterable {
    case myHistory
    case entryPlank
    case myData
    
    var imageName: String {
        switch self {
        case .myHistory:
            return "calendar.badge.clock"
        case .entryPlank:
            return "house.fill"
        case .myData:
            return "chart.bar"
        }
    }
}
