//
//  YearAndMonthSelectionView.swift
//  UNCHILOG
//
//  Created by t&a on 2024/03/30.
//

import SwiftUI

struct YearAndMonthSelectionView: View {
    
    public var showBackButton = false
    
    @EnvironmentObject private var viewModel: CalendarViewModel
    
    @State private var showChart = false
    @State private var showSetting = false
    
    var body: some View {
        
        HStack {
            Spacer()
                .frame(width: 30)
                .padding(.horizontal, 10)
            
            Button {
                viewModel.backMonthPage()
            } label: {
                Image(systemName: "chevron.backward")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
                    .padding(8)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .background(.themaBlack)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            
            Spacer()
            
            if let yearAndMonth = viewModel.getCurrentYearAndMonth {
                Button {
                    viewModel.moveTodayCalendar()
                } label: {
                    Text(yearAndMonth.yearAndMonth)
                        .frame(width: 100)
                }.frame(width: 100)
                    .padding()
            }
          
            Spacer()
            
            Button {
                viewModel.forwardMonthPage()
            } label: {
                Image(systemName: "chevron.forward")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
                    .padding(8)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .background(.themaBlack)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            
            Spacer()
                .frame(width: 30)
                .padding(.horizontal, 10)
            
        }.foregroundStyle(.themaBlack)
    }
}

#Preview {
    YearAndMonthSelectionView()
        .environmentObject(CalendarViewModel())
}
