//
//  MaterialColorScheme.swift
//  MattiUI
//
//  Material Design 3 (Material You) Color Scheme
//  Reference: https://m3.material.io/styles/color/the-color-system/color-roles

import SwiftUI

// MARK: - Hex Color Extension

extension Color {
    /// Initializes a Color from a hex string (e.g. "#6750A4" or "6750A4").
    public init(m3hex hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - MaterialColorScheme

/// The Material Design 3 color scheme containing all color roles.
///
/// Use `MaterialColorScheme.light` or `MaterialColorScheme.dark` for the baseline M3 purple scheme,
/// or create your own scheme with custom colors.
@available(iOS 15, macOS 12.0, *)
public struct MaterialColorScheme {
    // Primary
    public var primary: Color
    public var onPrimary: Color
    public var primaryContainer: Color
    public var onPrimaryContainer: Color

    // Secondary
    public var secondary: Color
    public var onSecondary: Color
    public var secondaryContainer: Color
    public var onSecondaryContainer: Color

    // Tertiary
    public var tertiary: Color
    public var onTertiary: Color
    public var tertiaryContainer: Color
    public var onTertiaryContainer: Color

    // Error
    public var error: Color
    public var onError: Color
    public var errorContainer: Color
    public var onErrorContainer: Color

    // Background / Surface
    public var background: Color
    public var onBackground: Color
    public var surface: Color
    public var onSurface: Color
    public var surfaceVariant: Color
    public var onSurfaceVariant: Color

    // Outline
    public var outline: Color
    public var outlineVariant: Color

    // Inverse
    public var inverseSurface: Color
    public var inverseOnSurface: Color
    public var inversePrimary: Color

    // Misc
    public var scrim: Color
    public var surfaceTint: Color

    public init(
        primary: Color, onPrimary: Color, primaryContainer: Color, onPrimaryContainer: Color,
        secondary: Color, onSecondary: Color, secondaryContainer: Color, onSecondaryContainer: Color,
        tertiary: Color, onTertiary: Color, tertiaryContainer: Color, onTertiaryContainer: Color,
        error: Color, onError: Color, errorContainer: Color, onErrorContainer: Color,
        background: Color, onBackground: Color,
        surface: Color, onSurface: Color,
        surfaceVariant: Color, onSurfaceVariant: Color,
        outline: Color, outlineVariant: Color,
        inverseSurface: Color, inverseOnSurface: Color, inversePrimary: Color,
        scrim: Color, surfaceTint: Color
    ) {
        self.primary = primary
        self.onPrimary = onPrimary
        self.primaryContainer = primaryContainer
        self.onPrimaryContainer = onPrimaryContainer
        self.secondary = secondary
        self.onSecondary = onSecondary
        self.secondaryContainer = secondaryContainer
        self.onSecondaryContainer = onSecondaryContainer
        self.tertiary = tertiary
        self.onTertiary = onTertiary
        self.tertiaryContainer = tertiaryContainer
        self.onTertiaryContainer = onTertiaryContainer
        self.error = error
        self.onError = onError
        self.errorContainer = errorContainer
        self.onErrorContainer = onErrorContainer
        self.background = background
        self.onBackground = onBackground
        self.surface = surface
        self.onSurface = onSurface
        self.surfaceVariant = surfaceVariant
        self.onSurfaceVariant = onSurfaceVariant
        self.outline = outline
        self.outlineVariant = outlineVariant
        self.inverseSurface = inverseSurface
        self.inverseOnSurface = inverseOnSurface
        self.inversePrimary = inversePrimary
        self.scrim = scrim
        self.surfaceTint = surfaceTint
    }

    // MARK: - Baseline M3 Light Scheme (Purple)

    /// The baseline Material Design 3 light color scheme using the M3 purple palette.
    public static let light = MaterialColorScheme(
        primary: Color(m3hex: "#6750A4"),
        onPrimary: Color(m3hex: "#FFFFFF"),
        primaryContainer: Color(m3hex: "#EADDFF"),
        onPrimaryContainer: Color(m3hex: "#21005D"),
        secondary: Color(m3hex: "#625B71"),
        onSecondary: Color(m3hex: "#FFFFFF"),
        secondaryContainer: Color(m3hex: "#E8DEF8"),
        onSecondaryContainer: Color(m3hex: "#1D192B"),
        tertiary: Color(m3hex: "#7D5260"),
        onTertiary: Color(m3hex: "#FFFFFF"),
        tertiaryContainer: Color(m3hex: "#FFD8E4"),
        onTertiaryContainer: Color(m3hex: "#31111D"),
        error: Color(m3hex: "#B3261E"),
        onError: Color(m3hex: "#FFFFFF"),
        errorContainer: Color(m3hex: "#F9DEDC"),
        onErrorContainer: Color(m3hex: "#410E0B"),
        background: Color(m3hex: "#FFFBFE"),
        onBackground: Color(m3hex: "#1C1B1F"),
        surface: Color(m3hex: "#FFFBFE"),
        onSurface: Color(m3hex: "#1C1B1F"),
        surfaceVariant: Color(m3hex: "#E7E0EC"),
        onSurfaceVariant: Color(m3hex: "#49454F"),
        outline: Color(m3hex: "#79747E"),
        outlineVariant: Color(m3hex: "#CAC4D0"),
        inverseSurface: Color(m3hex: "#313033"),
        inverseOnSurface: Color(m3hex: "#F4EFF4"),
        inversePrimary: Color(m3hex: "#D0BCFF"),
        scrim: Color(m3hex: "#000000"),
        surfaceTint: Color(m3hex: "#6750A4")
    )

    // MARK: - Baseline M3 Dark Scheme (Purple)

    /// The baseline Material Design 3 dark color scheme using the M3 purple palette.
    public static let dark = MaterialColorScheme(
        primary: Color(m3hex: "#D0BCFF"),
        onPrimary: Color(m3hex: "#381E72"),
        primaryContainer: Color(m3hex: "#4F378B"),
        onPrimaryContainer: Color(m3hex: "#EADDFF"),
        secondary: Color(m3hex: "#CCC2DC"),
        onSecondary: Color(m3hex: "#332D41"),
        secondaryContainer: Color(m3hex: "#4A4458"),
        onSecondaryContainer: Color(m3hex: "#E8DEF8"),
        tertiary: Color(m3hex: "#EFB8C8"),
        onTertiary: Color(m3hex: "#492532"),
        tertiaryContainer: Color(m3hex: "#633B48"),
        onTertiaryContainer: Color(m3hex: "#FFD8E4"),
        error: Color(m3hex: "#F2B8B5"),
        onError: Color(m3hex: "#601410"),
        errorContainer: Color(m3hex: "#8C1D18"),
        onErrorContainer: Color(m3hex: "#F9DEDC"),
        background: Color(m3hex: "#1C1B1F"),
        onBackground: Color(m3hex: "#E6E1E5"),
        surface: Color(m3hex: "#1C1B1F"),
        onSurface: Color(m3hex: "#E6E1E5"),
        surfaceVariant: Color(m3hex: "#49454F"),
        onSurfaceVariant: Color(m3hex: "#CAC4D0"),
        outline: Color(m3hex: "#938F99"),
        outlineVariant: Color(m3hex: "#49454F"),
        inverseSurface: Color(m3hex: "#E6E1E5"),
        inverseOnSurface: Color(m3hex: "#313033"),
        inversePrimary: Color(m3hex: "#6750A4"),
        scrim: Color(m3hex: "#000000"),
        surfaceTint: Color(m3hex: "#D0BCFF")
    )
}
