//
//  CalendarView.swift
//  PrankMemo
//
//  Created by t&a on 2024/08/19.
//

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject private var rootEnvironment: RootEnvironment
    @EnvironmentObject private var viewModel: MyHistoryViewModel
    
    private let columns = Array(repeating: GridItem(spacing: 0), count: 7)
    
    var body: some View {
        VStack {
            
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
                }.background(.themaBlack)
                .clipShape(RoundedRectangle(cornerRadius: 5))
            
            HStack {
                
                Text(L10n.calenderSumCount)
                    .font(.system(size: 14))
                
                Spacer()
                
                Text("\(viewModel.pranks.count)")
                    .font(.system(size: 30))
                    .foregroundStyle(.red)
                
                Text(L10n.calenderSumCountUnit)
                    .font(.system(size: 14))
                    .offset(y: 5)
                    .padding(.trailing)
            }.roundedRectangleShadowBackView(height: 80)
                .fontWeight(.bold)
                .foregroundStyle(.themaBlack)
            
            HStack {
                
                Text(L10n.calenderSumTime)
                    .font(.system(size: 14))
                
                Spacer()
                
                let (minute, second , mili) = rootEnvironment.getTimeString(viewModel.getSumTime())
                
                Spacer()
                
                Group {
                    Text("\(minute)")
                        .frame(alignment: .trailing)
                    Text("\(second)")
                        .frame(width: 50, alignment: .trailing)
                    Text("\(mili)")
                        .frame(width: 30, alignment: .leading)
                }.font(.system(size: 20))
                    .foregroundStyle(.red)
                
                Text(L10n.calenderSumTimeUnit)
                    .font(.system(size: 14))
                    .offset(y: 5)
                    .padding(.trailing)
                
            }.roundedRectangleShadowBackView(height: 80)
                .fontWeight(.bold)
                .foregroundStyle(.themaBlack)
            
            Spacer()
        }
    }
}

#Preview {
    CalendarView()
        .environmentObject(RootEnvironment())
}
