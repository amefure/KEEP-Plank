//
//  EntryPrankView.swift
//  PrankMemo
//
//  Created by t&a on 2024/08/19.
//

import SwiftUI
import Combine

struct EntryPrankView: View {
    @EnvironmentObject private var rootEnvironment: RootEnvironment
    @ObservedObject private var entryPrankViewModel = EntryPrankViewModel()
    @State private var isCouting = false
    var body: some View {
        VStack {
            
            Spacer()
            
            let (minute, second , mili) = rootEnvironment.getTimeString(entryPrankViewModel.time)
            
            HStack {
                Spacer()
                Text("\(minute)")
                    .frame(alignment: .trailing)
                Text("\(second)")
                    .frame(width: 100, alignment: .trailing)
                Text("\(mili)")
                    .frame(width: 60, alignment: .leading)
                Spacer()
            }.font(.system(size: 40))
                .fontWeight(.bold)
                .foregroundStyle(.themaBlack)
            
            Spacer()
            
            Button {
                if !isCouting {
                    isCouting = true
                    entryPrankViewModel.startTimer()
                } else {
                    isCouting = false
                    entryPrankViewModel.stopTimer()
                    entryPrankViewModel.createPrank()
                    entryPrankViewModel.resetTimer()
                }
                
            } label: {
                Text(isCouting ? "FINISH" : "PRANK START!")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(width: DeviceSizeUtility.deviceWidth - 40, height: 60)
                    .background(.themaBlack)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            
            if isCouting {
                Button {
                    isCouting = false
                    entryPrankViewModel.stopTimer()
                } label: {
                    Text("STOP")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .frame(width: DeviceSizeUtility.deviceWidth - 40, height: 60)
                        .background(.themaBlack)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
            } else {
                Spacer()
                    .frame(width: DeviceSizeUtility.deviceWidth - 40, height: 60)
            }
            
            Spacer()
            
        }.onAppear {
            entryPrankViewModel.onAppear()
        }
    }
}

#Preview {
    EntryPrankView()
}
