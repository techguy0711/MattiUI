//
//  TextButton.swift
//  MattiUI
//
//  Material Design 3 — Text Button
//  Reference: https://m3.material.io/components/buttons/specs#899b9107-0127-4a01-8f4c-87f19323a1b4

import SwiftUI

/// A Material Design 3 **Text** button — lowest emphasis, no container.
///
/// Equivalent to `TextButton` in Jetpack Compose.
///
/// ```swift
/// TextButton("Learn more") { /* action */ }
/// TextButton("Open", icon: Image(systemName: "arrow.right")) { /* action */ }
/// ```
@available(iOS 15, macOS 12.0, *)
public struct TextButton: View {
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
            .padding(.horizontal, icon != nil ? 12 : 12)
            .padding(.vertical, 10)
            .foregroundColor(isEnabled ? theme.colorScheme.primary : theme.colorScheme.onSurface.opacity(0.38))
        }
        .disabled(!isEnabled)
    }
}

@available(iOS 15, macOS 12.0, *)
struct TextButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 16) {
            TextButton("Text Button") {}
            TextButton("With Icon", icon: Image(systemName: "plus")) {}
            TextButton("Disabled") {}
                .disabled(true)
        }
        .padding()
        .materialTheme(.light)
        .previewDisplayName("TextButton — Light")
    }
}
