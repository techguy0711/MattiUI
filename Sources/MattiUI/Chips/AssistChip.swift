//
//  AssistChip.swift
//  MattiUI
//
//  Material Design 3 — Assist Chip
//  Reference: https://m3.material.io/components/chips/specs#e900592e-41a7-4c3e-9eb9-d9ad8ec2f49e

import SwiftUI

/// A Material Design 3 **Assist Chip** — guides the user to complete a task.
///
/// Equivalent to `AssistChip` in Jetpack Compose.
///
/// ```swift
/// AssistChip("Set a reminder", icon: Image(systemName: "bell")) { /* action */ }
/// ```
@available(iOS 15, macOS 12.0, *)
public struct AssistChip: View {
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
                        .foregroundColor(isEnabled ? theme.colorScheme.primary : theme.colorScheme.onSurface.opacity(0.38))
                }
                Text(label)
                    .font(theme.typography.labelLarge.font)
                    .kerning(theme.typography.labelLarge.letterSpacing)
                    .foregroundColor(isEnabled ? theme.colorScheme.onSurface : theme.colorScheme.onSurface.opacity(0.38))
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
struct AssistChip_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 8) {
            AssistChip("Set reminder", icon: Image(systemName: "bell")) {}
            AssistChip("Directions") {}
            AssistChip("Disabled") {}.disabled(true)
        }
        .padding()
        .materialTheme(.light)
        .previewDisplayName("AssistChip — Light")
    }
}
