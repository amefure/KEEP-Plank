//
//  EntryPlankView.swift
//  PrankMemo
//
//  Created by t&a on 2024/08/19.
//

import SwiftUI
import Combine

struct EntryPlankView: View {
    @EnvironmentObject private var rootEnvironment: RootEnvironment
    // 親Viewで更新が走りEntryPrankViewが再描画されるためObservedObjectだと画面が更新されない
    @StateObject private var viewModel = EntryPlankViewModel()
    @State private var showEntryPopUp = false
    @State private var showEntrySuccessDialog = false
    var body: some View {
        VStack {
            
            AdMobBannerView()
                .frame(height: 60)
            
            Spacer()

            let (minute, second , mili) = rootEnvironment.getTimeString(viewModel.time)
            
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
                if !rootEnvironment.isCouting {
                    viewModel.startTimer()
                    rootEnvironment.isCouting = true
                } else {
                    showEntryPopUp = true
                    viewModel.stopTimer()
                }
            } label: {
                Text(rootEnvironment.isCouting ? "FINISH" : "PLANK START!")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(width: 180, height: 180)
                    .background(.themaRed)
                    .clipShape(RoundedRectangle(cornerRadius: 200))
                    .shadow(color: .gray,radius: 3, x: 2, y: 2)
            }
            
            Spacer()
            
        }.onAppear {
            viewModel.onAppear()
        }.popUp(
            isPresented: $showEntryPopUp,
            title: L10n.popupPrankEntryTitle,
            subTitle: rootEnvironment.getTimeStringFull(viewModel.time),
            message: L10n.popupPrankEntryMsg,
            positiveButtonTitle: L10n.popupButtonOk,
            negativeButtonTitle: L10n.dialogButtonCancel,
            positiveAction: {
                rootEnvironment.isCouting = false
                viewModel.createPrank()
                viewModel.resetTimer()
                showEntrySuccessDialog = true
            },
            negativeAction: {
                rootEnvironment.isCouting = false
                viewModel.resetTimer()
            }
        ).dialog(
            isPresented: $showEntrySuccessDialog,
            title: L10n.dialogTitle,
            message: L10n.dialogEntrySuccessMsg,
            positiveButtonTitle: L10n.dialogButtonOk
        )
    }
}

#Preview {
    EntryPlankView()
        .environmentObject(RootEnvironment())
}
