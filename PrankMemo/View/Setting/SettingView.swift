//
//  SettingView.swift
//  PrankMemo
//
//  Created by t&a on 2024/08/29.
//

import SwiftUI

struct SettingView: View {
    
    @EnvironmentObject private var rootEnvironment: RootEnvironment
    private var viewModel = SettingViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            
            HStack {
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)
                        .padding(8)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .background(.themaBlack)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                
                Spacer()
                
                Text(L10n.settingTitle)
                    .foregroundStyle(.exText)
                    .fontWeight(.bold)
                
                Spacer()
                
                Spacer()
                    .frame(width: 15, height: 15)
                    .padding(8)
                
            }.padding(.horizontal)
                .padding(.top)
            
            List {
                Section(header: Text("Link"), footer: Text(L10n.settingSectionLinkDesc)) {
                    if let url = URL(string: StaticUrls.APP_REVIEW_URL) {
                        // 1:レビューページ
                        Link(destination: url, label: {
                            HStack {
                                Image(systemName: "hand.thumbsup")
                                    .frame(width: 30)
                                    .foregroundColor(.themaYellow)
                                Text(L10n.settingSectionLinkReview)
                            }.foregroundStyle(.white)
                        }).listRowHeight()
                    }
                    
                    // 2:シェアボタン
                    Button {
                        viewModel.shareApp(
                            shareText: L10n.settingSectionLinkShareText,
                            shareLink: StaticUrls.APP_REVIEW_URL
                        )
                    } label: {
                        HStack {
                            Image(systemName: "star.bubble")
                                .frame(width: 30)
                                .foregroundColor(.themaYellow)
                            
                            Text(L10n.settingSectionLinkRecommend)
                        }.foregroundStyle(.white)
                    }.listRowHeight()
                    
                    if let url = URL(string: StaticUrls.APP_CONTACT_URL) {
                        // 3:お問い合わせフォーム
                        Link(destination: url, label: {
                            HStack {
                                Image(systemName: "paperplane")
                                    .frame(width: 30)
                                    .foregroundColor(.themaYellow)
                                Text(L10n.settingSectionLinkContact)
                                Image(systemName: "link").font(.caption)
                            }.foregroundStyle(.white)
                        }).listRowHeight()
                    }
                    
                    if let url = URL(string: StaticUrls.APP_TERMS_OF_SERVICE_URL) {
                        // 4:利用規約とプライバシーポリシー
                        Link(destination: url, label: {
                            HStack {
                                Image(systemName: "note.text")
                                    .frame(width: 30)
                                    .foregroundColor(.themaYellow)
                                Text(L10n.settingSectionLinkTerms)
                                Image(systemName: "link").font(.caption)
                            }.foregroundStyle(.white)
                        }).listRowHeight()
                          
                    }
                      
                }.listRowBackground(Color.themaBlack)
                    .listRowSeparatorTint(.white)
                
                Section {
                    HStack {
                        Spacer()
                        VStack(alignment: .center, spacing: 4) {
                            Asset.Images.appIcon.swiftUIImage
                                .resizable()
                                .padding(5)
                                .frame(width: 50, height: 50)
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 50))
                                .padding(.bottom, 8)
                                .shadow(color: .gray,radius: 3, x: 2, y: 2)

                            Text("KEEP PLANK Ver \(viewModel.getVersion())")
                            Text("Created by Shibuya")
                        }.fontSS()
                        Spacer()
                    }
                }.listRowBackground(Color.clear)
            }.scrollContentBackground(.hidden)
                .background(.white)
            
        }.foregroundStyle(.exText)
            .navigationBarBackButtonHidden()
    }
}

private extension View {
    func listRowHeight(height: CGFloat = 37) -> some View {
        frame(height: height)
    }
}

#Preview {
    SettingView()
}
