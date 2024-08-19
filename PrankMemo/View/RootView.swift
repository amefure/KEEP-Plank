//
//  RootView.swift
//  PrankMemo
//
//  Created by t&a on 2024/08/19.
//

import SwiftUI


struct RootView: View {
    
    @State private var selectTab = 0
   
    var body: some View {
        VStack {
            TabViewLayout(selectTab: $selectTab) {
                switch selectTab {
                case 0:
                    HomeView()
                case 1:
                    EntryPrankView()
                default:
                    EntryPrankView()
                }
               
            }
        }
    }
}

#Preview {
    RootView()
}
