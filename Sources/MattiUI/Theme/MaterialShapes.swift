//
//  MaterialShapes.swift
//  MattiUI
//
//  Material Design 3 Shape Scale
//  Reference: https://m3.material.io/styles/shape/shape-scale-tokens

import SwiftUI

// MARK: - MaterialShapes

/// The Material Design 3 shape scale defining corner radii for components.
///
/// - SeeAlso: https://m3.material.io/styles/shape/shape-scale-tokens
@available(iOS 15, macOS 12.0, *)
public struct MaterialShapes {
    /// Extra-small components: 4 pt (e.g. chips, small text fields)
    public var extraSmall: CGFloat
    /// Small components: 8 pt (e.g. menu, snackbar)
    public var small: CGFloat
    /// Medium components: 12 pt (e.g. cards, medium dialogs)
    public var medium: CGFloat
    /// Large components: 16 pt (e.g. navigation drawer, large FAB)
    public var large: CGFloat
    /// Extra-large components: 28 pt (e.g. large dialogs, bottom sheets)
    public var extraLarge: CGFloat
    /// Full rounding: 50 pt (e.g. buttons, FAB)
    public var full: CGFloat

    public init(
        extraSmall: CGFloat = 4,
        small: CGFloat = 8,
        medium: CGFloat = 12,
        large: CGFloat = 16,
        extraLarge: CGFloat = 28,
        full: CGFloat = 50
    ) {
        self.extraSmall = extraSmall
        self.small = small
        self.medium = medium
        self.large = large
        self.extraLarge = extraLarge
        self.full = full
    }

    /// The default Material Design 3 shape scale.
    public static let `default` = MaterialShapes()
}
