//
//  SCYearAndMonth.swift
//  PrankMemo
//
//  Created by t&a on 2024/08/19.
//

import UIKit

struct SCYearAndMonth: Identifiable {
    public var id: UUID = UUID()
    public var year: Int
    public var month: Int
    
    public var yearAndMonth: String {
        return "\(year)年\(month)月"
    }
}
