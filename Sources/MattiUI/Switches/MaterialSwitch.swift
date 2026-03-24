//
//  MaterialSwitch.swift
//  MattiUI
//
//  Material Design 3 — Switch
//  Reference: https://m3.material.io/components/switch/specs

import SwiftUI

/// A Material Design 3 **Switch** — a two-state toggle control.
///
/// Equivalent to `Switch` in Jetpack Compose.
///
/// ```swift
/// @State private var isOn = false
/// MaterialSwitch(isOn: $isOn)
/// MaterialSwitch(isOn: $isOn, thumbIcon: Image(systemName: "checkmark"))
/// ```
@available(iOS 15, macOS 12.0, *)
public struct MaterialSwitch: View {
    @Environment(\.materialTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    @Binding public var isOn: Bool
    public var thumbIcon: Image?

    public init(isOn: Binding<Bool>, thumbIcon: Image? = nil) {
        self._isOn = isOn
        self.thumbIcon = thumbIcon
    }

    // M3 Switch dimensions
    private let trackWidth: CGFloat = 52
    private let trackHeight: CGFloat = 32
    private let thumbSize: CGFloat = 24
    private let thumbSizeSelected: CGFloat = 24

    private var trackColor: Color {
        guard isEnabled else {
            return isOn
                ? theme.colorScheme.onSurface.opacity(0.12)
                : theme.colorScheme.surfaceVariant.opacity(0.12)
        }
        return isOn ? theme.colorScheme.primary : theme.colorScheme.surfaceVariant
    }

    private var thumbColor: Color {
        guard isEnabled else {
            return isOn
                ? theme.colorScheme.surface.opacity(0.38)
                : theme.colorScheme.onSurface.opacity(0.38)
        }
        return isOn ? theme.colorScheme.onPrimary : theme.colorScheme.outline
    }

    private var borderColor: Color {
        guard isEnabled else { return theme.colorScheme.onSurface.opacity(0.12) }
        return isOn ? .clear : theme.colorScheme.outline
    }

    public var body: some View {
        ZStack {
            // Track
            RoundedRectangle(cornerRadius: trackHeight / 2, style: .continuous)
                .fill(trackColor)
                .overlay(
                    RoundedRectangle(cornerRadius: trackHeight / 2, style: .continuous)
                        .strokeBorder(borderColor, lineWidth: 2)
                )
                .frame(width: trackWidth, height: trackHeight)

            // Thumb
            ZStack {
                Circle()
                    .fill(thumbColor)
                    .frame(width: isOn ? thumbSizeSelected : 16, height: isOn ? thumbSizeSelected : 16)

                if isOn, let icon = thumbIcon {
                    icon
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(theme.colorScheme.onPrimaryContainer)
                        .frame(width: 14, height: 14)
                }
            }
            .offset(x: isOn ? 10 : -10)
            .animation(.spring(response: 0.25, dampingFraction: 0.8), value: isOn)
        }
        .onTapGesture {
            if isEnabled {
                isOn.toggle()
            }
        }
    }
}

@available(iOS 15, macOS 12.0, *)
struct MaterialSwitch_Previews: PreviewProvider {
    struct PreviewContainer: View {
        @State private var isOn1 = true
        @State private var isOn2 = false
        @State private var isOn3 = true

        var body: some View {
            VStack(spacing: 20) {
                HStack(spacing: 20) {
                    Text("With icon (on)")
                    MaterialSwitch(isOn: $isOn1, thumbIcon: Image(systemName: "checkmark"))
                }
                HStack(spacing: 20) {
                    Text("Without icon (off)")
                    MaterialSwitch(isOn: $isOn2)
                }
                HStack(spacing: 20) {
                    Text("Disabled (on)")
                    MaterialSwitch(isOn: $isOn3)
                        .disabled(true)
                }
            }
            .padding()
            .materialTheme(.light)
        }
    }

    static var previews: some View {
        PreviewContainer()
            .previewDisplayName("MaterialSwitch — Light")
    }
}
