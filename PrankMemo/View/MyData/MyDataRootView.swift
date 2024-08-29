//
//  MyDataRootView.swift
//  PrankMemo
//
//  Created by t&a on 2024/08/27.
//

import SwiftUI
import Charts

struct MyDataRootView: View {
    @EnvironmentObject private var rootEnvironment: RootEnvironment
    @ObservedObject private var viewModel = MyDataViewModel()
    private let df = DateFormatUtility(format: "M" + L10n.monthUnit)
    
    var body: some View {
        VStack {
            
            HStack {
                
                Spacer()
                    .frame(width: 15, height: 15)
                    .padding(8)
                
                Spacer()
                
                Text("MyData")
                    .foregroundStyle(.exText)
                    .fontWeight(.bold)
                
                Spacer()
                
                NavigationLink {
                    SettingView()
                        .environmentObject(rootEnvironment)
                } label: {
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)
                        .padding(8)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .background(.themaBlack)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
            }.padding(.horizontal)
            
            ScrollView {

                HStack {
                    Text(L10n.mydataSumCount)
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                    
                    Spacer()
                }.padding(.horizontal)
                
                HStack {
                    if let dic = viewModel.dayMoneyRecordDictionary() {
                        Chart {
                            ForEach(dic.keys.sorted(by: { $0 < $1 }), id: \.self) { date in
                                
                                BarMark(
                                    x: .value(L10n.mydataChartsX, df.getString(date: date)),
                                    y: .value(L10n.mydataChartsY, dic[date]?.count ?? 0)
                                ).foregroundStyle(.themaRed)
                                    .annotation {
                                        Text("\(dic[date]?.count ?? 0)")
                                            .font(.system(size: 12))
                                            .fontWeight(.bold)
                                            .foregroundStyle(.themaBlack)
                                    }
                            }
                        }.frame(width: DeviceSizeUtility.deviceWidth - 60 , height: 110)
                    } else {
                        Text(L10n.mydataNoData)
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                            .foregroundStyle(.yellow)
                    }
                    
                }.roundedRectangleShadowBackView(height: 140)
                
                
                HStack {
                    Text("\(df.getString(date: Date()))" + L10n.calenderSumTime)
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
                        .foregroundStyle(.themaRed)
                    
                    Text(L10n.calenderSumTimeUnit)
                        .font(.system(size: 14))
                        .offset(y: 5)
                        .padding(.trailing)
                    
                }.roundedRectangleShadowBackView(height: 80)
                    .fontWeight(.bold)
                    .foregroundStyle(.themaBlack)
                
                
                HStack {
                    Text(L10n.mydataContinuousDay)
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                    
                    Spacer()
                }.padding()
                
                HStack {
                    
                    
                    Spacer()
                    
                    Text("\(viewModel.daysOfContinuousRecords())")
                        .font(.system(size: 30))
                        .foregroundStyle(.themaRed)
                    
                    Text(L10n.dayUnit)
                        .font(.system(size: 14))
                        .offset(y: 5)
                        .padding(.trailing)
                    
                }.roundedRectangleShadowBackView(height: 80)
                    .fontWeight(.bold)
                    .foregroundStyle(.themaBlack)
                
                
                HStack {
                    Text(L10n.mydataNotifySetting)
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Toggle(isOn: $viewModel.notifyFlag) {
                        Text(L10n.mydataNotifySettingSwitch)
                    }.labelsHidden()
                        .tint(.themaBlack)
                    
                }.padding()
                
                VStack {
                    
                    HStack {
                        Spacer()
                        
                        DatePicker(
                            selection: $viewModel.time,
                            displayedComponents: DatePickerComponents.hourAndMinute,
                            label: {
                                Text(L10n.mydataNotifyTime)
                                    .foregroundColor(.exText)
                            }
                        ).environment(\.locale, Locale(identifier: L10n.dateLocale))
                            .colorMultiply(.exText)
                    }
                   
                    Text(L10n.mydataNotifyDesc)
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                }.roundedRectangleShadowBackView(height: 120)
                    .fontWeight(.bold)
                    .foregroundStyle(.themaBlack)
                
                Spacer()
            }
        }.foregroundStyle(.exText)
            .onAppear {
                viewModel.onAppear()
            }.onDisappear {
                viewModel.onDisappear()
            }
    }
}

#Preview {
    MyDataRootView()
        .environmentObject(RootEnvironment())
}
