//
//  MaterialTheme.swift
//  MattiUI
//
//  Material Design 3 Theme — environment-based theming for SwiftUI.
//  Reference: https://m3.material.io/foundations/design-tokens/overview

import SwiftUI

// MARK: - MaterialTheme

/// The top-level Material Design 3 theme object.
///
/// Inject it into the environment using `.materialTheme(...)` and
/// read it with `@Environment(\.materialTheme)`.
///
/// ```swift
/// MyRootView()
///     .materialTheme(.init(colorScheme: .light))
/// ```
@available(iOS 15, macOS 12.0, *)
public struct MaterialTheme {
    public var colorScheme: MaterialColorScheme
    public var typography: MaterialTypography
    public var shapes: MaterialShapes

    public init(
        colorScheme: MaterialColorScheme = .light,
        typography: MaterialTypography = .default,
        shapes: MaterialShapes = .default
    ) {
        self.colorScheme = colorScheme
        self.typography = typography
        self.shapes = shapes
    }

    /// A light theme using the baseline M3 purple palette.
    public static let light = MaterialTheme(colorScheme: .light)

    /// A dark theme using the baseline M3 purple palette.
    public static let dark = MaterialTheme(colorScheme: .dark)
}

// MARK: - Environment Key

@available(iOS 15, macOS 12.0, *)
private struct MaterialThemeKey: EnvironmentKey {
    static let defaultValue: MaterialTheme = .light
}

@available(iOS 15, macOS 12.0, *)
extension EnvironmentValues {
    /// The current Material Design 3 theme.
    public var materialTheme: MaterialTheme {
        get { self[MaterialThemeKey.self] }
        set { self[MaterialThemeKey.self] = newValue }
    }
}

// MARK: - View Extension

@available(iOS 15, macOS 12.0, *)
extension View {
    /// Applies a Material Design 3 theme to this view and all of its children.
    ///
    /// - Parameter theme: The `MaterialTheme` to inject into the environment.
    public func materialTheme(_ theme: MaterialTheme) -> some View {
        self.environment(\.materialTheme, theme)
    }
}
