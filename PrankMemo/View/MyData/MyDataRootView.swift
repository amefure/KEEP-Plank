//
//  MyDataRootView.swift
//  PrankMemo
//
//  Created by t&a on 2024/08/27.
//

import SwiftUI
import Charts

struct MyDataRootView: View {
    @ObservedObject private var rootEnvironment = RootEnvironment.shared
    @ObservedObject private var viewModel = MyDataViewModel()
    private let df = DateFormatUtility(format: "M月")
    
    var body: some View {
        VStack {

            HStack {
                Text("月別合計回数")
                    .font(.system(size: 14))
                    .fontWeight(.bold)
                
                Spacer()
            }.padding(.horizontal)
            
            HStack {
                Chart {
                    let dic = viewModel.dayMoneyRecordDictionary()
                    ForEach(dic.keys.sorted(by: { $0 < $1 }), id: \.self) { date in
                        
                        BarMark(
                          x: .value("年月", df.getString(date: date)),
                          y: .value("回数", dic[date]?.count ?? 0)
                      ).foregroundStyle(.themaBlack)
                            .annotation {
                                Text("\(dic[date]?.count ?? 0)")
                                    .font(.system(size: 12))
                                    .fontWeight(.bold)
                                    .foregroundStyle(.themaBlack)
                            }
                    }
                }
                .frame(width: DeviceSizeUtility.deviceWidth - 60 , height: 110)
            }.roundedRectangleShadowBackView(height: 140)
            
            
            HStack {
                Text("\(df.getString(date: Date()))合計時間")
                    .font(.system(size: 14))
                    .fontWeight(.bold)
                
                Spacer()
            }.padding()
            
            HStack {
                
                Spacer()
                
                
                let (minute, second , mili) = rootEnvironment.getTimeString(viewModel.getSumTime())
                
                Spacer()
                
                Group {
                    Text("\(minute)")
                        .frame(alignment: .trailing)
                    Text("\(second)")
                        .frame(width: 50, alignment: .trailing)
                    Text("\(mili)")
                        .frame(width: 30, alignment: .leading)
                }.font(.system(size: 20))
                    .foregroundStyle(.red)
                
                Text(" / 月")
                    .font(.system(size: 14))
                    .offset(y: 5)
                    .padding(.trailing)
                
            }.roundedRectangleShadowBackView(height: 80)
                .fontWeight(.bold)
                .foregroundStyle(.themaBlack)
            
            
            HStack {
                Text("連続日数")
                    .font(.system(size: 14))
                    .fontWeight(.bold)
                
                Spacer()
            }.padding()
            
            HStack {
                
                
                Spacer()
                
                Text("\(viewModel.daysOfContinuousRecords())")
                    .font(.system(size: 30))
                    .foregroundStyle(.red)
                
                Text("日")
                    .font(.system(size: 14))
                    .offset(y: 5)
                    .padding(.trailing)
                
            }.roundedRectangleShadowBackView(height: 80)
                .fontWeight(.bold)
                .foregroundStyle(.themaBlack)
            
            Spacer()
        }.foregroundStyle(.exText)
            .onAppear {
                viewModel.onAppear()
            }
    }
}

#Preview {
    MyDataRootView()
        .environmentObject(RootEnvironment())
}
