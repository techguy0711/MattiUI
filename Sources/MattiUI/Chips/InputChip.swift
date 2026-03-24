//
//  InputChip.swift
//  MattiUI
//
//  Material Design 3 — Input Chip
//  Reference: https://m3.material.io/components/chips/specs#facb7c02-74c4-4b81-bd5f-72d470f1e5b6

import SwiftUI

/// A Material Design 3 **Input Chip** — represents a discrete piece of information (e.g. a tag).
/// Includes a leading avatar/icon and a trailing dismiss button.
///
/// Equivalent to `InputChip` in Jetpack Compose.
///
/// ```swift
/// @State private var visible = true
/// if visible {
///     InputChip("Kotlin", icon: Image(systemName: "k.circle")) { visible = false }
/// }
/// ```
@available(iOS 15, macOS 12.0, *)
public struct InputChip: View {
    @Environment(\.materialTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    public var label: String
    public var icon: Image?
    public var onDismiss: () -> Void

    public init(_ label: String, icon: Image? = nil, onDismiss: @escaping () -> Void) {
        self.label = label
        self.icon = icon
        self.onDismiss = onDismiss
    }

    public var body: some View {
        HStack(spacing: 0) {
            if let icon = icon {
                icon
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18, height: 18)
                    .foregroundColor(isEnabled ? theme.colorScheme.onSurfaceVariant : theme.colorScheme.onSurface.opacity(0.38))
                    .padding(.leading, 4)
            } else {
                Spacer().frame(width: 12)
            }

            Text(label)
                .font(theme.typography.labelLarge.font)
                .kerning(theme.typography.labelLarge.letterSpacing)
                .foregroundColor(isEnabled ? theme.colorScheme.onSurfaceVariant : theme.colorScheme.onSurface.opacity(0.38))
                .padding(.horizontal, 8)

            // Dismiss button
            Button(action: onDismiss) {
                Image(systemName: "xmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 14, height: 14)
                    .foregroundColor(isEnabled ? theme.colorScheme.onSurfaceVariant : theme.colorScheme.onSurface.opacity(0.38))
            }
            .padding(.trailing, 8)
        }
        .frame(height: 32)
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
struct InputChip_Previews: PreviewProvider {
    struct PreviewContainer: View {
        @State private var chips = ["SwiftUI", "Kotlin", "Material"]

        var body: some View {
            HStack(spacing: 8) {
                ForEach(chips, id: \.self) { chip in
                    InputChip(chip, icon: Image(systemName: "tag")) {
                        chips.removeAll { $0 == chip }
                    }
                }
            }
            .padding()
            .materialTheme(.light)
        }
    }

    static var previews: some View {
        PreviewContainer()
            .previewDisplayName("InputChip — Light")
    }
}
