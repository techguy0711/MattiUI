//
//  PlatformColor.swift
//
//
//  Shared cross-platform adaptive colors for MattiUI components.
//

import SwiftUI

@available(iOS 18, macOS 15.0, *)
extension Color {
    /// A surface/background color that adapts to light/dark mode on both
    /// iOS and macOS. Components should use this instead of hardcoding
    /// `.white`, which looks broken (a bright white card) in dark mode.
    static var mattiSurface: Color {
        #if os(iOS) || os(tvOS)
        return Color(uiColor: .systemBackground)
        #elseif os(macOS)
        return Color(nsColor: .windowBackgroundColor)
        #else
        return Color.white
        #endif
    }
}
