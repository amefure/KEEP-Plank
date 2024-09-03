//
//  TabViewLayout.swift
//  PrankMemo
//
//  Created by t&a on 2024/08/19.
//

import SwiftUI

struct TabViewLayout<Content: View>: View {
    
    @EnvironmentObject private var rootEnvironment: RootEnvironment
    
    var content: Content
    
    @Binding private var selectTab: Int
    
    init(selectTab: Binding<Int>, @ViewBuilder content: () -> Content) {
        self._selectTab = selectTab
        self.content = content()
    }
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            content
            
            Spacer()
            
            HStack {
                Spacer()
                
                Button {
                    // タイム計測中はタブ遷移を無効に
                    if !rootEnvironment.isCouting {
                        selectTab = 0
                    }
                } label: {
                    Image(systemName: "calendar.badge.clock")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                }.foregroundStyle(rootEnvironment.isCouting ? .gray : .white)
                    .disabled(rootEnvironment.isCouting)
                
                Spacer()
                
                Button {
                    selectTab = 1
                } label: {
                    Image(systemName: "house.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                }.foregroundStyle(.white)
                
                Spacer()
                
                Button {
                    // タイム計測中はタブ遷移を無効に
                    if !rootEnvironment.isCouting {
                        selectTab = 2
                    }
                } label: {
                    Image(systemName: "chart.bar")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                }.foregroundStyle(rootEnvironment.isCouting ? .gray : .white)
                    .disabled(rootEnvironment.isCouting)
                
                Spacer()
            }.frame(width: DeviceSizeUtility.deviceWidth - 40, height: 60)
                .background(Asset.Colors.themaBlack.swiftUIColor)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
                .padding(.bottom, 5)
        }
    }
}

#Preview {
    TabViewLayout(selectTab: Binding.constant(0)) {
        Text("Test")
    }
}
