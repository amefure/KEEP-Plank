//
//  MyHistoryTabRootView.swift
//  PrankMemo
//
//  Created by t&a on 2024/08/27.
//

import SwiftUI

struct MyHistoryTabRootView: View {
    @EnvironmentObject private var rootEnvironment: RootEnvironment
    @ObservedObject private var viewModel = MyHistoryViewModel()
    
    @State private var selectTab = 0
    
    var body: some View {
        VStack(spacing: 0) {
            
            YearAndMonthSelectionView()
                .environmentObject(viewModel)
                .padding(.bottom)

            HStack {
                Button {
                    selectTab = 0
                } label: {
                    Image(systemName: "calendar")
                        .frame(width: (DeviceSizeUtility.deviceWidth / 2) - 20, height: 30)
                        .foregroundStyle(selectTab == 0 ? .white : .themaBlack)
                        .background(selectTab == 0 ? .themaBlack : .white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                Rectangle()
                    .fill(.themaBlack)
                    .frame(width: 2, height: 40)
                
                Button {
                    selectTab = 1
                } label: {
                    Image(systemName: "list.bullet")
                        .frame(width: (DeviceSizeUtility.deviceWidth / 2) - 20, height: 30)
                        .foregroundStyle(selectTab == 1 ? .white : .themaBlack)
                        .background(selectTab == 1 ? .themaBlack : .white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }.padding(.horizontal)
            
            Rectangle()
                .fill(.themaBlack)
                .frame(width: DeviceSizeUtility.deviceWidth, height: 2)
                .padding(.bottom)
            
            switch selectTab {
            case 0:
                CalendarView()
                    .environmentObject(viewModel)
                    .environmentObject(rootEnvironment)
            default:
                TimeLineView()
                    .environmentObject(viewModel)
                    .environmentObject(rootEnvironment)
            }
        }.onAppear { viewModel.onAppear() }
    }
}

#Preview {
    MyHistoryTabRootView()
        .environmentObject(RootEnvironment())
}
