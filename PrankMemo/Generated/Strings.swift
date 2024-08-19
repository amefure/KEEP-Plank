// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// キャンセル
  internal static let dialogButtonCancel = L10n.tr("Localizable", "dialog_button_cancel", fallback: "キャンセル")
  /// OK
  internal static let dialogButtonOk = L10n.tr("Localizable", "dialog_button_ok", fallback: "OK")
  /// エラー
  internal static let dialogErrorTitle = L10n.tr("Localizable", "dialog_error_title", fallback: "エラー")
  /// Localizable.strings
  ///   PrankMemo
  /// 
  ///   Created by t&a on 2024/08/19.
  internal static let dialogTitle = L10n.tr("Localizable", "dialog_title", fallback: "お知らせ")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
