//
//  YearAndMonthSelectionView.swift
//  UNCHILOG
//
//  Created by t&a on 2024/03/30.
//

import SwiftUI

struct YearAndMonthSelectionView: View {
    
    public var showBackButton = false
    
    @EnvironmentObject private var viewModel: MyHistoryViewModel
    
    @State private var showChart = false
    @State private var showSetting = false
    
    var body: some View {
        
        HStack {
            Spacer()
                .frame(width: 30)
                .padding(.horizontal, 10)
            
            Button {
                viewModel.backMonth()
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
            
            Text(viewModel.getCurrentYearAndMonth())
                    .frame(width: 100)
                    .fontWeight(.bold)
            
            Spacer()
            
            Button {
                viewModel.forwardMonth()
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
            
            Button {
                viewModel.moveToDayYearAndMonthCalendar()
            } label: {
                Image("back_today")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
            }.padding(.horizontal, 10)
        }.foregroundStyle(.themaBlack)
    }
}

#Preview {
    YearAndMonthSelectionView()
        .environmentObject(MyHistoryViewModel())
}
