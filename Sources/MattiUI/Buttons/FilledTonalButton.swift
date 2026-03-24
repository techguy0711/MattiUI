//
//  FilledTonalButton.swift
//  MattiUI
//
//  Material Design 3 — Filled Tonal Button
//  Reference: https://m3.material.io/components/buttons/specs#158f0a18-67fb-4ac4-9d22-cc4d1adc4579

import SwiftUI

/// A Material Design 3 **Filled Tonal** button — medium-high emphasis using secondary container color.
///
/// Equivalent to `FilledTonalButton` in Jetpack Compose.
///
/// ```swift
/// FilledTonalButton("Explore") { /* action */ }
/// FilledTonalButton("Location", icon: Image(systemName: "location.fill")) { /* action */ }
/// ```
@available(iOS 15, macOS 12.0, *)
public struct FilledTonalButton: View {
    @Environment(\.materialTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    public var label: String
    public var icon: Image?
    public var action: () -> Void

    public init(_ label: String, icon: Image? = nil, action: @escaping () -> Void) {
        self.label = label
        self.icon = icon
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if let icon = icon {
                    icon
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                }
                Text(label)
                    .font(theme.typography.labelLarge.font)
                    .kerning(theme.typography.labelLarge.letterSpacing)
            }
            .padding(.horizontal, icon != nil ? 16 : 24)
            .padding(.vertical, 10)
            .foregroundColor(isEnabled ? theme.colorScheme.onSecondaryContainer : theme.colorScheme.onSurface.opacity(0.38))
        }
        .background(
            RoundedRectangle(cornerRadius: theme.shapes.full, style: .continuous)
                .fill(isEnabled ? theme.colorScheme.secondaryContainer : theme.colorScheme.onSurface.opacity(0.12))
        )
        .disabled(!isEnabled)
    }
}

@available(iOS 15, macOS 12.0, *)
struct FilledTonalButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 16) {
            FilledTonalButton("Filled Tonal") {}
            FilledTonalButton("With Icon", icon: Image(systemName: "location.fill")) {}
            FilledTonalButton("Disabled") {}
                .disabled(true)
        }
        .padding()
        .materialTheme(.light)
        .previewDisplayName("FilledTonalButton — Light")
    }
}
