//
//  OutlinedButton.swift
//  MattiUI
//
//  Material Design 3 — Outlined Button
//  Reference: https://m3.material.io/components/buttons/specs#de72d8b1-ba16-4cd7-989e-e2ad3293cf63

import SwiftUI

/// A Material Design 3 **Outlined** button — medium emphasis, with a visible border.
///
/// Equivalent to `OutlinedButton` in Jetpack Compose.
///
/// ```swift
/// OutlinedButton("Cancel") { /* action */ }
/// OutlinedButton("Share", icon: Image(systemName: "square.and.arrow.up")) { /* action */ }
/// ```
@available(iOS 15, macOS 12.0, *)
public struct OutlinedButton: View {
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
            .foregroundColor(isEnabled ? theme.colorScheme.primary : theme.colorScheme.onSurface.opacity(0.38))
        }
        .background(
            RoundedRectangle(cornerRadius: theme.shapes.full, style: .continuous)
                .strokeBorder(
                    isEnabled ? theme.colorScheme.outline : theme.colorScheme.onSurface.opacity(0.12),
                    lineWidth: 1
                )
        )
        .disabled(!isEnabled)
    }
}

@available(iOS 15, macOS 12.0, *)
struct OutlinedButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 16) {
            OutlinedButton("Outlined Button") {}
            OutlinedButton("With Icon", icon: Image(systemName: "arrow.up")) {}
            OutlinedButton("Disabled") {}
                .disabled(true)
        }
        .padding()
        .materialTheme(.light)
        .previewDisplayName("OutlinedButton — Light")
    }
}
