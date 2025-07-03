//
//  DeviceSizeUtility.swift
//  PrankMemo
//
//  Created by t&a on 2024/08/19.
//

import UIKit

final class DeviceSizeUtility: Sendable {
    
    static var deviceWidth: CGFloat {
        guard let window = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return 0 }
        return window.screen.bounds.width
    }

    static var deviceHeight: CGFloat {
        guard let window = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return 0 }
        return window.screen.bounds.height
    }

    static var isSESize: Bool {
        return deviceWidth < 400
    }

    static var isiPadSize: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
}


