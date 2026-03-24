//
//  FilterChip.swift
//  MattiUI
//
//  Material Design 3 — Filter Chip
//  Reference: https://m3.material.io/components/chips/specs#68b1ae13-daa6-4e12-a9df-28f4c3f4e998

import SwiftUI

/// A Material Design 3 **Filter Chip** — allows the user to narrow down a set of results.
///
/// Equivalent to `FilterChip` in Jetpack Compose.
///
/// ```swift
/// @State private var selected = false
/// FilterChip("Sci-Fi", isSelected: $selected)
/// ```
@available(iOS 15, macOS 12.0, *)
public struct FilterChip: View {
    @Environment(\.materialTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    public var label: String
    @Binding public var isSelected: Bool

    public init(_ label: String, isSelected: Binding<Bool>) {
        self.label = label
        self._isSelected = isSelected
    }

    public var body: some View {
        Button(action: { if isEnabled { isSelected.toggle() } }) {
            HStack(spacing: 8) {
                if isSelected {
                    Image(systemName: "checkmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 14, height: 14)
                        .foregroundColor(isEnabled ? theme.colorScheme.onSecondaryContainer : theme.colorScheme.onSurface.opacity(0.38))
                }
                Text(label)
                    .font(theme.typography.labelLarge.font)
                    .kerning(theme.typography.labelLarge.letterSpacing)
                    .foregroundColor(isEnabled
                        ? (isSelected ? theme.colorScheme.onSecondaryContainer : theme.colorScheme.onSurfaceVariant)
                        : theme.colorScheme.onSurface.opacity(0.38))
            }
            .padding(.horizontal, 16)
            .frame(height: 32)
        }
        .background(
            RoundedRectangle(cornerRadius: theme.shapes.extraSmall, style: .continuous)
                .fill(isEnabled
                    ? (isSelected ? theme.colorScheme.secondaryContainer : .clear)
                    : theme.colorScheme.onSurface.opacity(0.12))
                .overlay(
                    RoundedRectangle(cornerRadius: theme.shapes.extraSmall, style: .continuous)
                        .strokeBorder(
                            isEnabled
                                ? (isSelected ? .clear : theme.colorScheme.outline)
                                : theme.colorScheme.onSurface.opacity(0.12),
                            lineWidth: 1
                        )
                )
        )
        .animation(.easeInOut(duration: 0.15), value: isSelected)
        .disabled(!isEnabled)
    }
}

@available(iOS 15, macOS 12.0, *)
struct FilterChip_Previews: PreviewProvider {
    struct PreviewContainer: View {
        @State private var sci = true
        @State private var drama = false
        @State private var comedy = false

        var body: some View {
            HStack(spacing: 8) {
                FilterChip("Sci-Fi", isSelected: $sci)
                FilterChip("Drama", isSelected: $drama)
                FilterChip("Comedy", isSelected: $comedy)
            }
            .padding()
            .materialTheme(.light)
        }
    }

    static var previews: some View {
        PreviewContainer()
            .previewDisplayName("FilterChip — Light")
    }
}
