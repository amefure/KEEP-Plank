//
//  RootView.swift
//  PrankMemo
//
//  Created by t&a on 2024/08/19.
//

import SwiftUI


struct RootView: View {
    
    @ObservedObject private var rootEnvironment = RootEnvironment.shared
    @State private var selectTab = 0
   
    var body: some View {
        VStack {
            TabViewLayout(selectTab: $selectTab) {
                switch selectTab {
                case 0:
                    MyHistoryTabRootView()
                        .environmentObject(rootEnvironment)
                case 1:
                    EntryPrankView()
                        .environmentObject(rootEnvironment)
                default:
                    MyDataRootView()
                        .environmentObject(rootEnvironment)
                }
            }
        }
    }
}

#Preview {
    RootView()
}
