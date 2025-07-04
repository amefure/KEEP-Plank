//
//  TimeLineView.swift
//  PrankMemo
//
//  Created by t&a on 2024/08/27.
//

import SwiftUI

struct TimeLineView: View {
    
    @EnvironmentObject private var rootEnvironment: RootEnvironment
    @EnvironmentObject private var viewModel: CalendarViewModel
    private let dateFormatUtility = DateFormatUtility(format: "d")
    private let timeFormatUtility = DateFormatUtility(format: "HH:mm")
    
    var body: some View {
        if viewModel.pranks.isEmpty {
            
            Spacer()
            
            Asset.Images.nodata.swiftUIImage
                .resizable()
                .frame(width: 300, height: 300)
            
            Text(L10n.timelineNoData)
                .foregroundStyle(.exText)
                .fontM(bold: true)
            
            Spacer()
            
        } else {
            List {
                ForEach(viewModel.pranks) { prank in
                    HStack {
                        
                        ZStack {
                            Image(systemName: "circle.fill")
                                .blur(radius: 2)
                                .opacity(0.7)
                                .scaleEffect(1.2)
                            
                            Image(systemName: "circle.fill")
                                
                        }.fontSS(bold: true)
                       
                        
                        HStack(alignment: .bottom) {
                            Text(dateFormatUtility.getString(date: prank.createdAt))
                                .fontL(bold: true)
                            
                            Text(L10n.dayUnit)
                                .fontS()
                            
                            Text(timeFormatUtility.getString(date: prank.createdAt))
                                .fontS()
                        }
        
                        
                        Spacer()
                        
                        let (minute, second , mili) = rootEnvironment.getTimeString(prank.miliseconds)
                        
                        Spacer()
                        
                        Group {
                            Text(minute)
                                .frame(alignment: .trailing)
                            Text(second)
                                .frame(width: 35, alignment: .trailing)
                            Text(mili)
                                .frame(width: 25, alignment: .leading)
                        }.fontM(bold: true)
                        
                    }.padding(.vertical, 8)
                        .foregroundStyle(.white)
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button {
                                viewModel.removePrank(id: prank.id)
                            } label: {
                                Image(systemName: "trash")
                            }.tint(.themaRed)
                        }
                }.listRowBackground(Color.themaBlack)
                    .listRowSeparatorTint(.white)
            }.scrollContentBackground(.hidden)
                .background(.white)
              
        }
    }
}

#Preview {
    TimeLineView()
}
