//
//  EntryPrankView.swift
//  PrankMemo
//
//  Created by t&a on 2024/08/19.
//

import SwiftUI
import Combine

struct EntryPrankView: View {
    @ObservedObject private var entryPrankViewModel = EntryPrankViewModel()
    var body: some View {
        VStack {
            Text("\(entryPrankViewModel.getTimeString())")
            
            Button {
                entryPrankViewModel.startTimer()
            } label: {
                Text("Start")
            }
            
            Button {
                entryPrankViewModel.stopTimer()
            } label: {
                Text("Stop")
            }
            
            Button {
                entryPrankViewModel.resetTimer()
            } label: {
                Text("Reset")
            }
        }.onAppear {
            entryPrankViewModel.onAppear()
        }
    }
}

#Preview {
    EntryPrankView()
}
