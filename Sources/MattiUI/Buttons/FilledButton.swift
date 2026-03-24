//
//  FilledButton.swift
//  MattiUI
//
//  Material Design 3 — Filled Button
//  Reference: https://m3.material.io/components/buttons/specs#0b1b7bd2-3de8-431a-afa1-d692e2e18b0d

import SwiftUI

/// A Material Design 3 **Filled** button — the highest emphasis button.
///
/// Equivalent to `Button` with a `ButtonDefaults.filledButtonColors()` style in Jetpack Compose.
///
/// ```swift
/// FilledButton("Save") { /* action */ }
/// FilledButton("Upload", icon: Image(systemName: "arrow.up")) { /* action */ }
/// ```
@available(iOS 15, macOS 12.0, *)
public struct FilledButton: View {
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
            .foregroundColor(isEnabled ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface.opacity(0.38))
        }
        .background(
            RoundedRectangle(cornerRadius: theme.shapes.full, style: .continuous)
                .fill(isEnabled ? theme.colorScheme.primary : theme.colorScheme.onSurface.opacity(0.12))
        )
        .disabled(!isEnabled)
    }
}

@available(iOS 15, macOS 12.0, *)
struct FilledButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 16) {
            FilledButton("Filled Button") {}
            FilledButton("With Icon", icon: Image(systemName: "star.fill")) {}
            FilledButton("Disabled") {}
                .disabled(true)
        }
        .padding()
        .materialTheme(.light)
        .previewDisplayName("FilledButton — Light")

        VStack(spacing: 16) {
            FilledButton("Filled Button") {}
            FilledButton("With Icon", icon: Image(systemName: "star.fill")) {}
        }
        .padding()
        .background(Color(m3hex: "#1C1B1F"))
        .materialTheme(.dark)
        .previewDisplayName("FilledButton — Dark")
    }
}
