//
//  CustomNotifyPopUpView.swift
//  PrankMemo
//
//  Created by t&a on 2024/08/28.
//

import SwiftUI

struct CustomNotifyPopUpView: View {
    
    @Binding var isPresented: Bool
    
    public let title: String
    public let subTitle: String
    public let message: String
    public let positiveButtonTitle: String
    public let negativeButtonTitle: String
    public let positiveAction: () -> Void
    public let negativeAction: () -> Void
    
    
    var body: some View {
        if isPresented {
            
            ZStack {
               // 画面全体を覆う黒い背景
               Color.black
                   .opacity(0.5)
                   .onTapGesture {
                       // ダイアログ周りタップで閉じる
                       // isPresented = false
                   }
                
                // ダイアログコンテンツ部分
                VStack(spacing: 0) {
                    
                    Text(title)
                        .frame(width: DeviceSizeUtility.deviceWidth - 60)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .padding(.vertical, 20)
                        .background(.themaBlack)
                    
                    
                    Asset.Images.entry.swiftUIImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 170, height: 170)
                        .padding(.top, 10)
                    
                    Spacer()
                    
                    Text(subTitle)
                        .font(.system(size: 20))
                        .foregroundStyle(.themaRed)
                        .padding(.horizontal, 20)
                        .fontWeight(.bold)
                        .padding(.bottom, 10)
                    
                    Text(message)
                        .font(.system(size: 13))
                        .foregroundStyle(.exText)
                        .padding(.horizontal, 20)
                        .fontWeight(.bold)
                        .lineLimit(4)
                    
                    Spacer()
                    
                    Divider()
                    
                    Spacer()
                        .frame(height: 20)
                    
                    if !positiveButtonTitle.isEmpty {
                        Button {
                            isPresented = false
                            positiveAction()
                        } label: {
                            Text(positiveButtonTitle)
                                .foregroundStyle(.white)
                                .fontWeight(.bold)
                                .frame(width: 250, height: 50)
                                .background(.themaRed)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                    
                    Spacer()
                        .frame(height: 10)
                    
                    if !negativeButtonTitle.isEmpty {
                        Button {
                            isPresented = false
                            negativeAction()
                        } label: {
                            Text(negativeButtonTitle)
                                .foregroundStyle(.exText)
                                .fontWeight(.bold)
                                .frame(width: 250, height: 50)
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                      .stroke(style: StrokeStyle(lineWidth: 2))
                                      .tint(.exText)
                                }
                                
                        }
                    }
                    
                    Spacer()
                        .frame(height: 20)
                   
                }.frame(width: DeviceSizeUtility.deviceWidth - 60, height: 480)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
           // 画面一杯にViewを広げる
           }.ignoresSafeArea()
        }
    }
}


extension View {
    func popUp(isPresented: Binding<Bool>,
               title: String,
               subTitle: String,
               message: String,
               positiveButtonTitle: String = "",
               negativeButtonTitle: String = "",
               positiveAction: @escaping () -> Void = {},
               negativeAction: @escaping () -> Void = {}) -> some View
    {
        overlay(
            CustomNotifyPopUpView(
                isPresented: isPresented,
                title: title,
                subTitle: subTitle,
                message: message,
                positiveButtonTitle: positiveButtonTitle,
                negativeButtonTitle: negativeButtonTitle,
                positiveAction: positiveAction,
                negativeAction: negativeAction
            )
        )
    }
}


#Preview {
    CustomNotifyPopUpView(
        isPresented: Binding.constant(true),
        title: "ポップアップタイトル",
        subTitle: "0分3秒00",
        message: "messagemessagemessagemessagemessagemessagemessage",
        positiveButtonTitle: "OK",
        negativeButtonTitle: "NG",
        positiveAction: {},
        negativeAction: {})
}
