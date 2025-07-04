//
//  ExModifier.swift
//  PrankMemo
//
//  Created by t&a on 2024/08/27.
//

import SwiftUI

/// 角丸 + 枠線 + 影
struct RoundedRectangleShadowBackView: ViewModifier {

    public var width: CGFloat
    public var height: CGFloat
    func body(content: Content) -> some View {
        content
            .padding()
                .frame(width: width, height: height)
                .background(.white)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                      .stroke(style: StrokeStyle(lineWidth: 2))
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .clipped()
                .shadow(color: .gray,radius: 3, x: 2, y: 2)
    }
}


extension View {
    /// 角丸 + 枠線 + 影
    func roundedRectangleShadowBackView(width: CGFloat = DeviceSizeUtility.deviceWidth - 40, height: CGFloat) -> some View {
        modifier(RoundedRectangleShadowBackView(width: width, height: height))
    }
    
}


/// フォントサイズ
struct FontSize: ViewModifier {
    public let size: CGFloat
    public let bold: Bool
    func body(content: Content) -> some View {
        content
            .font(.system(size: size))
            .fontWeight(bold ? .bold : .medium)
    }
}

extension View {
    /// 文字サイズ SSS `Size：10`
    func fontSSS(bold: Bool = false) -> some View {
        modifier(FontSize(size: 10, bold: bold))
    }

    /// 文字サイズ SS `Size：12`
    func fontSS(bold: Bool = false) -> some View {
        modifier(FontSize(size: 12, bold: bold))
    }

    /// 文字サイズ S `Size：14`
    func fontS(bold: Bool = false) -> some View {
        modifier(FontSize(size: 14, bold: bold))
    }

    /// 文字サイズ M `Size：17`
    func fontM(bold: Bool = false) -> some View {
        modifier(FontSize(size: 17, bold: bold))
    }

    /// 文字サイズ L `Size：20`
    func fontL(bold: Bool = false) -> some View {
        modifier(FontSize(size: 20, bold: bold))
    }

    /// 文字サイズ カスタム
    func fontCustom(size: CGFloat, bold: Bool = false) -> some View {
        modifier(FontSize(size: size, bold: bold))
    }
}


/// アラートを簡易的に呼び出すための拡張
extension View {
    func alert(
        isPresented: Binding<Bool>,
        title: String,
        message: String,
        positiveButtonTitle: String = "",
        negativeButtonTitle: String = "",
        positiveButtonRole: ButtonRole? = nil,
        negativeButtonRole: ButtonRole? = .cancel,
        positiveAction: @escaping () -> Void = {},
        negativeAction: @escaping () -> Void = {}
    ) -> some View {
        alert(title, isPresented: isPresented) {
            if !negativeButtonTitle.isEmpty && !positiveButtonTitle.isEmpty {
                Button(role: negativeButtonRole) {
                    negativeAction()
                } label: {
                    Text(negativeButtonTitle)
                }
            }

            if !positiveButtonTitle.isEmpty {
                Button(role: positiveButtonRole) {
                    positiveAction()
                } label: {
                    Text(positiveButtonTitle)
                }
            }
        } message: {
            Text(message)
        }
    }
}
