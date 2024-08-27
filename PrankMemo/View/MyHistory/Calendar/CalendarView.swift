//
//  HomeCalendarView.swift
//  PrankMemo
//
//  Created by t&a on 2024/08/19.
//

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject private var rootEnvironment: RootEnvironment
    
    @ObservedObject private var viewModel = HomeCalendarViewModel()
    
    private let columns = Array(repeating: GridItem(spacing: 0), count: 7)
    
    @State private var selectTab = 1
    
    
    var body: some View {
        VStack {
            YearAndMonthSelectionView()
                .environmentObject(viewModel)
            
            switch selectTab {
            case 0:
                
                LazyVGrid(columns: columns, spacing: 0) {
                    ForEach(viewModel.dayOfWeekList, id: \.self) { week in
                        Text(week.shortSymbols)
                            .fontWeight(.bold)
                            .foregroundStyle(week.color)
                            .opacity(0.8)
                    }
                }
                
                CarouselCalendarView(
                    yearAndMonths: viewModel.currentYearAndMonth,
                    dates: viewModel.currentDates) { index in
                        if index == 1 {
                            viewModel.backMonth()
                        } else {
                            viewModel.forwardMonth()
                        }
                    }.clipShape(RoundedRectangle(cornerRadius: 5))
            default:
                TimeLineView()
            }
        }
    }
}

#Preview {
    CalendarView()
        .environmentObject(RootEnvironment())
}
