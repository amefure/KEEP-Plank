//
//  SettingViewModel.swift
//  PrankMemo
//
//  Created by t&a on 2024/08/29.
//

import UIKit

class SettingViewModel: ObservableObject {
  

    init(repositoryDependency: RepositoryDependency = RepositoryDependency()) {
    }

    public func onAppear() {
    }

    /// アプリシェアロジック
    public func shareApp(shareText: String, shareLink: String) {
        let items = [shareText, URL(string: shareLink)!] as [Any]
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        if UIDevice.current.userInterfaceIdiom == .pad {
            if let popPC = activityVC.popoverPresentationController {
                popPC.sourceView = activityVC.view
                popPC.barButtonItem = .none
                popPC.sourceRect = activityVC.accessibilityFrame
            }
        }
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let rootVC = windowScene?.windows.first?.rootViewController
        rootVC?.present(activityVC, animated: true, completion: {})
    }
}

