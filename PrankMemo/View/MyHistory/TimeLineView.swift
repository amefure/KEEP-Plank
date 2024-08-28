//
//  TimeLineView.swift
//  PrankMemo
//
//  Created by t&a on 2024/08/27.
//

import SwiftUI

struct TimeLineView: View {
    
    @EnvironmentObject private var rootEnvironment: RootEnvironment
    @EnvironmentObject private var viewModel: MyHistoryViewModel
    private let dateFormatUtility = DateFormatUtility(format: "d日")
    
    var body: some View {
        if viewModel.pranks.isEmpty {
            
            Spacer()
            
            Asset.Images.nodata.swiftUIImage
                .resizable()
                .frame(width: 300, height: 300)
            
            Text("記録がありません。")
                .fontWeight(.bold)
            
            Spacer()
            
        } else {
            List {
                ForEach(viewModel.pranks) { prank in
                    HStack {
                        Text(dateFormatUtility.getString(date: prank.createdAt))
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        let (minute, second , mili) = rootEnvironment.getTimeString(prank.miliseconds)
                        
                        Spacer()
                        
                        Group {
                            Text("\(minute)")
                                .frame(alignment: .trailing)
                            Text("\(second)")
                                .frame(width: 35, alignment: .trailing)
                            Text("\(mili)")
                                .frame(width: 20, alignment: .leading)
                        }.font(.system(size: 14))
                            .fontWeight(.bold)
                        
                    }.foregroundStyle(.white)
                }.listRowBackground(Color.themaBlack)
            }.scrollContentBackground(.hidden)
                .background(.white)
        }
    }
}

#Preview {
    TimeLineView()
}
