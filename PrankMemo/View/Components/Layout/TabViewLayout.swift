//
//  TabViewLayout.swift
//  PrankMemo
//
//  Created by t&a on 2024/08/19.
//

import SwiftUI

struct TabViewLayout<Content: View>: View {
    var content: Content
    
    @Binding private var selectTab: Int
    
    init(selectTab: Binding<Int>,@ViewBuilder  content: () -> Content) {
        self._selectTab = selectTab
        self.content = content()
    }
    var body: some View {
        VStack {
            Spacer()
            
            content
            
            Spacer()
            
            Rectangle()
                .frame(height: 1)
                .tint(.brown)
                .padding(.bottom, 30)
            
            HStack {
                Spacer()
                
                Button {
                    selectTab = 0
                } label: {
                    Image(systemName: "house.fill")
                }.foregroundStyle(.black)
                
                Spacer()
                
                Button {
                    selectTab = 1
                } label: {
                    Image(systemName: "house.fill")
                }.foregroundStyle(.black)
                
                Spacer()
                
                Button {
                    selectTab = 2
                } label: {
                    Image(systemName: "house.fill")
                }.foregroundStyle(.black)
                
                Spacer()
            }
        }
    }
}

#Preview {
    TabViewLayout(selectTab: Binding.constant(0)) {
        Text("Test")
    }
}
