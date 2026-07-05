//
//  MaterialChip.swift
//
//
//  A Material Design chip: a small, tappable, optionally-selectable pill.
//

import SwiftUI

/// The fill treatment of a ``MaterialChip``.
@available(iOS 18, macOS 15.0, *)
public enum MuiChipStyle {
    /// Tinted background, no border.
    case filled
    /// Transparent/lightly-tinted background with a colored border.
    case outlined
}

/// A small, tappable, optionally-selectable pill — used for filter chips,
/// input chips, and similar compact selections (e.g. in a horizontal list of
/// filters).
///
/// ```swift
/// MaterialChip(label: "Vegetarian", isSelected: isVegOnly) {
///     isVegOnly.toggle()
/// }
/// ```
@available(iOS 18, macOS 15.0, *)
public struct MaterialChip: View {
    /// The chip's label text.
    public var label: String
    /// Whether the chip is in its selected/active state.
    public var isSelected: Bool
    /// Filled or outlined treatment. Defaults to `.filled`.
    public var style: MuiChipStyle
    /// The chip's tint color. Defaults to `.accentColor`.
    public var color: Color
    /// Called when the chip itself is tapped.
    public var onTap: (() -> Void)?
    /// When non-nil, shows a trailing remove ("x") button that calls this closure.
    public var onRemove: (() -> Void)?

    /// Creates a Material chip.
    /// - Parameters:
    ///   - label: The chip's label text.
    ///   - isSelected: Whether the chip is selected. Defaults to `false`.
    ///   - style: Filled or outlined treatment. Defaults to `.filled`.
    ///   - color: The chip's tint color. Defaults to `.accentColor`.
    ///   - onTap: Called when the chip itself is tapped.
    ///   - onRemove: When non-nil, shows a trailing remove button.
    public init(
        label: String,
        isSelected: Bool = false,
        style: MuiChipStyle = .filled,
        color: Color = .accentColor,
        onTap: (() -> Void)? = nil,
        onRemove: (() -> Void)? = nil
    ) {
        self.label = label
        self.isSelected = isSelected
        self.style = style
        self.color = color
        self.onTap = onTap
        self.onRemove = onRemove
    }

    private var foregroundColor: Color {
        switch style {
        case .filled: return isSelected ? .white : color
        case .outlined: return color
        }
    }

    private var fillColor: Color {
        switch style {
        case .filled: return isSelected ? color : color.opacity(0.15)
        case .outlined: return isSelected ? color.opacity(0.15) : Color.clear
        }
    }

    public var body: some View {
        HStack(spacing: 6) {
            Text(label)
                .font(.footnote)
                .lineLimit(1)

            if let onRemove {
                Button(action: onRemove) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.footnote)
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Remove \(label)")
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .foregroundColor(foregroundColor)
        .background(fillColor)
        .overlay(
            Capsule().stroke(style == .outlined ? color : Color.clear, lineWidth: 1)
        )
        .clipShape(Capsule())
        .contentShape(Capsule())
        .onTapGesture { onTap?() }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(label)
        .accessibilityAddTraits(isSelected ? [.isButton, .isSelected] : [.isButton])
    }
}
