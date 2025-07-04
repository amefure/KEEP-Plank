//
//  CalendarView.swift
//  PrankMemo
//
//  Created by t&a on 2024/08/19.
//

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject private var rootEnvironment: RootEnvironment
    @EnvironmentObject  private var viewModel: CalendarViewModel
    
    private let columns = Array(repeating: GridItem(spacing: 0), count: 7)
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
    
                LazyVGrid(columns: columns, spacing: 0) {
                    ForEach(viewModel.dayOfWeekList, id: \.self) { week in
                        Text(week.shortSymbols)
                            .foregroundStyle(week.color)
                            .fontWeight(.bold)
                    }
                }.padding(.vertical, 8)
                    .frame(height: 40)

                
                CarouselCalendarView()
                    .environmentObject(viewModel)
                   

                
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
                    .padding(.vertical, 10)
                
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
}

#Preview {
    CalendarView()
        .environmentObject(RootEnvironment())
}
