//
//  RootView.swift
//  PrankMemo
//
//  Created by t&a on 2024/08/19.
//

import SwiftUI


struct RootView: View {
    
    @ObservedObject private var rootEnvironment = RootEnvironment.shared
    @State private var selectTab = 1
   
    var body: some View {
        VStack(spacing: 0) {
            NavigationStack {
                TabViewLayout(selectTab: $selectTab) {
                    switch selectTab {
                    case 0:
                        MyHistoryTabRootView()
                            .environmentObject(rootEnvironment)
                    case 1:
                        EntryPlankView()
                            .environmentObject(rootEnvironment)
                    default:
                        MyDataRootView()
                            .environmentObject(rootEnvironment)
                    }
                }.environmentObject(rootEnvironment)
            }
        }
    }
}

#Preview {
    RootView()
}
