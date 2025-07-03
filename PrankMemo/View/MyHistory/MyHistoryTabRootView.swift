//
//  MyHistoryTabRootView.swift
//  PrankMemo
//
//  Created by t&a on 2024/08/27.
//

import SwiftUI

/// History領域のタブ
private enum HistoryTab: CaseIterable {
    case calendar
    case timeline
    
    var imageName: String {
        return switch self {
        case .calendar:
            "calendar"
        case .timeline:
            "list.bullet"
        }
    }
}

struct MyHistoryTabRootView: View {
    @EnvironmentObject private var rootEnvironment: RootEnvironment
    @StateObject private var viewModel = CalendarViewModel()
    
    @State private var selectTab: HistoryTab = .calendar
    
    var body: some View {
        VStack(spacing: 0) {
            
            YearAndMonthSelectionView()
                .environmentObject(viewModel)
                .padding(.bottom)

            SelectTabPickerView(selectTab: $selectTab)
                .padding(.bottom)
            
            switch selectTab {
            case .calendar:
                CalendarView()
                    .environmentObject(viewModel)
                    .environmentObject(rootEnvironment)
            case .timeline:
                TimeLineView()
                    .environmentObject(viewModel)
                    .environmentObject(rootEnvironment)
            }
        }.onAppear { viewModel.onAppear() }
            .onDisappear { viewModel.onDisappear() }
    }
}

#Preview {
    MyHistoryTabRootView()
        .environmentObject(RootEnvironment())
}

private struct SelectTabPickerView: View {
    @Namespace private var tabAnimation
    @Binding var selectTab: HistoryTab
    var body: some View {
        HStack {
            
            ForEach(HistoryTab.allCases, id: \.self) { tab in
                Button {
                    selectTab = tab
                } label: {
                  
                    ZStack {
                        if selectTab == tab {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: (DeviceSizeUtility.deviceWidth / 2) - 20, height: 30)
                                .foregroundColor(.themaBlack)
                                .matchedGeometryEffect(id: "block", in: tabAnimation)
                        } else {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: (DeviceSizeUtility.deviceWidth / 2) - 20, height: 30)
                                .foregroundColor(.clear)
                        }
                        
                        Image(systemName: tab.imageName)
                            .frame(width: (DeviceSizeUtility.deviceWidth / 2) - 20, height: 30)
                            .foregroundStyle(selectTab == tab ? .white : .themaBlack)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
        }.background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: .black.opacity(0.2), radius: 5, x: 3, y: 3)
    }
}
