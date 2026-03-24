//
//  ElevatedCard.swift
//  MattiUI
//
//  Material Design 3 — Elevated Card
//  Reference: https://m3.material.io/components/cards/specs#a012d40d-7a5c-4b07-8740-491dec79d58b

import SwiftUI

/// A Material Design 3 **Elevated Card** — a surface with a shadow to indicate elevation.
///
/// Equivalent to `ElevatedCard` in Jetpack Compose.
///
/// ```swift
/// ElevatedCard {
///     Text("Card content")
/// }
/// ```
@available(iOS 15, macOS 12.0, *)
public struct ElevatedCard<Content: View>: View {
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
                    .shadow(color: theme.colorScheme.scrim.opacity(0.15), radius: 1, x: 0, y: 1)
                    .shadow(color: theme.colorScheme.scrim.opacity(0.3), radius: 2, x: 0, y: 1)
            )
    }
}

@available(iOS 15, macOS 12.0, *)
struct ElevatedCard_Previews: PreviewProvider {
    static var previews: some View {
        ElevatedCard {
            VStack(alignment: .leading, spacing: 8) {
                Text("Elevated Card")
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
        .previewDisplayName("ElevatedCard — Light")
    }
}
