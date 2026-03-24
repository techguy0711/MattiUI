//
//  ElevatedButton.swift
//  MattiUI
//
//  Material Design 3 — Elevated Button
//  Reference: https://m3.material.io/components/buttons/specs#fd9f6b5b-7c5b-4c83-91d5-69f70c9e3b5b

import SwiftUI

/// A Material Design 3 **Elevated** button — low emphasis with a shadow for distinction.
///
/// Equivalent to `ElevatedButton` in Jetpack Compose.
///
/// ```swift
/// ElevatedButton("Reply") { /* action */ }
/// ElevatedButton("Add Photo", icon: Image(systemName: "photo")) { /* action */ }
/// ```
@available(iOS 15, macOS 12.0, *)
public struct ElevatedButton: View {
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
                .fill(isEnabled ? theme.colorScheme.surface : theme.colorScheme.onSurface.opacity(0.12))
                .shadow(color: isEnabled ? theme.colorScheme.scrim.opacity(0.3) : .clear, radius: 1, x: 0, y: 1)
                .shadow(color: isEnabled ? theme.colorScheme.scrim.opacity(0.15) : .clear, radius: 2, x: 0, y: 2)
        )
        .disabled(!isEnabled)
    }
}

@available(iOS 15, macOS 12.0, *)
struct ElevatedButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 16) {
            ElevatedButton("Elevated Button") {}
            ElevatedButton("With Icon", icon: Image(systemName: "photo")) {}
            ElevatedButton("Disabled") {}
                .disabled(true)
        }
        .padding()
        .materialTheme(.light)
        .previewDisplayName("ElevatedButton — Light")
    }
}
