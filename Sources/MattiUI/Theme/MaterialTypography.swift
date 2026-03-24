//
//  MaterialTypography.swift
//  MattiUI
//
//  Material Design 3 Type Scale
//  Reference: https://m3.material.io/styles/typography/type-scale-tokens

import SwiftUI

// MARK: - MaterialTextStyle

/// Represents a single typographic style with font, line height, and letter spacing.
@available(iOS 15, macOS 12.0, *)
public struct MaterialTextStyle {
    public var font: Font
    public var lineHeight: CGFloat
    public var letterSpacing: CGFloat

    public init(font: Font, lineHeight: CGFloat, letterSpacing: CGFloat) {
        self.font = font
        self.lineHeight = lineHeight
        self.letterSpacing = letterSpacing
    }
}

// MARK: - MaterialTypography

/// The Material Design 3 type scale containing all typographic roles.
///
/// - SeeAlso: https://m3.material.io/styles/typography/type-scale-tokens
@available(iOS 15, macOS 12.0, *)
public struct MaterialTypography {
    // Display
    public var displayLarge: MaterialTextStyle
    public var displayMedium: MaterialTextStyle
    public var displaySmall: MaterialTextStyle

    // Headline
    public var headlineLarge: MaterialTextStyle
    public var headlineMedium: MaterialTextStyle
    public var headlineSmall: MaterialTextStyle

    // Title
    public var titleLarge: MaterialTextStyle
    public var titleMedium: MaterialTextStyle
    public var titleSmall: MaterialTextStyle

    // Body
    public var bodyLarge: MaterialTextStyle
    public var bodyMedium: MaterialTextStyle
    public var bodySmall: MaterialTextStyle

    // Label
    public var labelLarge: MaterialTextStyle
    public var labelMedium: MaterialTextStyle
    public var labelSmall: MaterialTextStyle

    public init(
        displayLarge: MaterialTextStyle, displayMedium: MaterialTextStyle, displaySmall: MaterialTextStyle,
        headlineLarge: MaterialTextStyle, headlineMedium: MaterialTextStyle, headlineSmall: MaterialTextStyle,
        titleLarge: MaterialTextStyle, titleMedium: MaterialTextStyle, titleSmall: MaterialTextStyle,
        bodyLarge: MaterialTextStyle, bodyMedium: MaterialTextStyle, bodySmall: MaterialTextStyle,
        labelLarge: MaterialTextStyle, labelMedium: MaterialTextStyle, labelSmall: MaterialTextStyle
    ) {
        self.displayLarge = displayLarge
        self.displayMedium = displayMedium
        self.displaySmall = displaySmall
        self.headlineLarge = headlineLarge
        self.headlineMedium = headlineMedium
        self.headlineSmall = headlineSmall
        self.titleLarge = titleLarge
        self.titleMedium = titleMedium
        self.titleSmall = titleSmall
        self.bodyLarge = bodyLarge
        self.bodyMedium = bodyMedium
        self.bodySmall = bodySmall
        self.labelLarge = labelLarge
        self.labelMedium = labelMedium
        self.labelSmall = labelSmall
    }

    // MARK: - Default M3 Type Scale

    /// The default Material Design 3 type scale.
    public static let `default` = MaterialTypography(
        displayLarge: MaterialTextStyle(font: .system(size: 57, weight: .regular), lineHeight: 64, letterSpacing: -0.25),
        displayMedium: MaterialTextStyle(font: .system(size: 45, weight: .regular), lineHeight: 52, letterSpacing: 0),
        displaySmall: MaterialTextStyle(font: .system(size: 36, weight: .regular), lineHeight: 44, letterSpacing: 0),
        headlineLarge: MaterialTextStyle(font: .system(size: 32, weight: .regular), lineHeight: 40, letterSpacing: 0),
        headlineMedium: MaterialTextStyle(font: .system(size: 28, weight: .regular), lineHeight: 36, letterSpacing: 0),
        headlineSmall: MaterialTextStyle(font: .system(size: 24, weight: .regular), lineHeight: 32, letterSpacing: 0),
        titleLarge: MaterialTextStyle(font: .system(size: 22, weight: .regular), lineHeight: 28, letterSpacing: 0),
        titleMedium: MaterialTextStyle(font: .system(size: 16, weight: .medium), lineHeight: 24, letterSpacing: 0.15),
        titleSmall: MaterialTextStyle(font: .system(size: 14, weight: .medium), lineHeight: 20, letterSpacing: 0.1),
        bodyLarge: MaterialTextStyle(font: .system(size: 16, weight: .regular), lineHeight: 24, letterSpacing: 0.5),
        bodyMedium: MaterialTextStyle(font: .system(size: 14, weight: .regular), lineHeight: 20, letterSpacing: 0.25),
        bodySmall: MaterialTextStyle(font: .system(size: 12, weight: .regular), lineHeight: 16, letterSpacing: 0.4),
        labelLarge: MaterialTextStyle(font: .system(size: 14, weight: .medium), lineHeight: 20, letterSpacing: 0.1),
        labelMedium: MaterialTextStyle(font: .system(size: 12, weight: .medium), lineHeight: 16, letterSpacing: 0.5),
        labelSmall: MaterialTextStyle(font: .system(size: 11, weight: .medium), lineHeight: 16, letterSpacing: 0.5)
    )
}

// MARK: - View Modifier for M3 Text Styles

@available(iOS 15, macOS 12.0, *)
extension View {
    /// Applies a Material Design 3 text style to the view.
    public func m3TextStyle(_ style: MaterialTextStyle) -> some View {
        self
            .font(style.font)
            .kerning(style.letterSpacing)
    }
}
