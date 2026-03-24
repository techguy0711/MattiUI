//
//  OutlinedCard.swift
//  MattiUI
//
//  Material Design 3 — Outlined Card
//  Reference: https://m3.material.io/components/cards/specs#6a7f2d06-e0ef-4580-a3b0-8a6d0f0aa7b6

import SwiftUI

/// A Material Design 3 **Outlined Card** — surface color with a visible border, no shadow.
///
/// Equivalent to `OutlinedCard` in Jetpack Compose.
///
/// ```swift
/// OutlinedCard {
///     Text("Card content")
/// }
/// ```
@available(iOS 15, macOS 12.0, *)
public struct OutlinedCard<Content: View>: View {
    @Environment(\.materialTheme) private var theme

    public var content: () -> Content

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        content()
            .background(
                RoundedRectangle(cornerRadius: theme.shapes.medium, style: .continuous)
                    .fill(theme.colorScheme.surface)
                    .overlay(
                        RoundedRectangle(cornerRadius: theme.shapes.medium, style: .continuous)
                            .strokeBorder(theme.colorScheme.outlineVariant, lineWidth: 1)
                    )
            )
    }
}

@available(iOS 15, macOS 12.0, *)
struct OutlinedCard_Previews: PreviewProvider {
    static var previews: some View {
        OutlinedCard {
            VStack(alignment: .leading, spacing: 8) {
                Text("Outlined Card")
                    .font(.headline)
                Text("Cards contain content and actions about a single subject.")
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            .padding()
            .frame(width: 300)
        }
        .padding()
        .materialTheme(.light)
        .previewDisplayName("OutlinedCard — Light")
    }
}
