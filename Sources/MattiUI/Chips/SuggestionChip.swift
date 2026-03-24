//
//  SuggestionChip.swift
//  MattiUI
//
//  Material Design 3 — Suggestion Chip
//  Reference: https://m3.material.io/components/chips/specs#8e2e4a24-2d92-4cf5-ad90-7ac2c19e7bde

import SwiftUI

/// A Material Design 3 **Suggestion Chip** — presents dynamically generated suggestions.
///
/// Equivalent to `SuggestionChip` in Jetpack Compose.
///
/// ```swift
/// SuggestionChip("Reply", icon: Image(systemName: "arrowshape.turn.up.left")) { /* action */ }
/// ```
@available(iOS 15, macOS 12.0, *)
public struct SuggestionChip: View {
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
                        .foregroundColor(isEnabled ? theme.colorScheme.onSurfaceVariant : theme.colorScheme.onSurface.opacity(0.38))
                }
                Text(label)
                    .font(theme.typography.labelLarge.font)
                    .kerning(theme.typography.labelLarge.letterSpacing)
                    .foregroundColor(isEnabled ? theme.colorScheme.onSurfaceVariant : theme.colorScheme.onSurface.opacity(0.38))
            }
            .padding(.leading, icon != nil ? 8 : 16)
            .padding(.trailing, 16)
            .frame(height: 32)
        }
        .background(
            RoundedRectangle(cornerRadius: theme.shapes.extraSmall, style: .continuous)
                .fill(isEnabled ? theme.colorScheme.surface : theme.colorScheme.onSurface.opacity(0.12))
                .overlay(
                    RoundedRectangle(cornerRadius: theme.shapes.extraSmall, style: .continuous)
                        .strokeBorder(
                            isEnabled ? theme.colorScheme.outline : theme.colorScheme.onSurface.opacity(0.12),
                            lineWidth: 1
                        )
                )
        )
        .disabled(!isEnabled)
    }
}

@available(iOS 15, macOS 12.0, *)
struct SuggestionChip_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 8) {
            SuggestionChip("Reply all", icon: Image(systemName: "arrowshape.turn.up.left.2")) {}
            SuggestionChip("Forward") {}
            SuggestionChip("Snooze", icon: Image(systemName: "moon")) {}
        }
        .padding()
        .materialTheme(.light)
        .previewDisplayName("SuggestionChip — Light")
    }
}
