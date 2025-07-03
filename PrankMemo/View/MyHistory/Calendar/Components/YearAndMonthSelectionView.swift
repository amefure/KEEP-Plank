//
//  YearAndMonthSelectionView.swift
//  UNCHILOG
//
//  Created by t&a on 2024/03/30.
//

import SwiftUI

struct YearAndMonthSelectionView: View {
    
    @EnvironmentObject private var viewModel: CalendarViewModel
    
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
                        .fontM(bold: true)
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
