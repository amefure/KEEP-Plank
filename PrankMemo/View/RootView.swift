//
//  RootView.swift
//  PrankMemo
//
//  Created by t&a on 2024/08/19.
//

import SwiftUI



struct RootView: View {
    
    @ObservedObject private var rootEnvironment = RootEnvironment.shared
    @State private var selectTab: RootTab = .entryPlank
   
    var body: some View {
        VStack(spacing: 0) {
            NavigationStack {
                TabViewLayout(selectTab: $selectTab) {
                    switch selectTab {
                    case .myHistory:
                        MyHistoryTabRootView()
                            .environmentObject(rootEnvironment)
                    case .entryPlank:
                        EntryPlankView()
                            .environmentObject(rootEnvironment)
                    case .myData:
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
