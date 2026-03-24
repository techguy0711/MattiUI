//
//  MaterialCheckbox.swift
//  MattiUI
//
//  Material Design 3 — Checkbox
//  Reference: https://m3.material.io/components/checkbox/specs

import SwiftUI

/// A Material Design 3 **Checkbox** — a square selection control.
///
/// Equivalent to `Checkbox` in Jetpack Compose.
///
/// ```swift
/// @State private var checked = false
/// MaterialCheckbox(isChecked: $checked)
/// ```
@available(iOS 15, macOS 12.0, *)
public struct MaterialCheckbox: View {
    @Environment(\.materialTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    @Binding public var isChecked: Bool

    public init(isChecked: Binding<Bool>) {
        self._isChecked = isChecked
    }

    private var boxColor: Color {
        if !isEnabled { return isChecked ? theme.colorScheme.onSurface.opacity(0.38) : .clear }
        return isChecked ? theme.colorScheme.primary : .clear
    }

    private var borderColor: Color {
        if !isEnabled { return theme.colorScheme.onSurface.opacity(0.38) }
        return isChecked ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant
    }

    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 2, style: .continuous)
                .fill(boxColor)
                .overlay(
                    RoundedRectangle(cornerRadius: 2, style: .continuous)
                        .strokeBorder(borderColor, lineWidth: 2)
                )
                .frame(width: 18, height: 18)

            if isChecked {
                Image(systemName: "checkmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 10, height: 10)
                    .foregroundColor(isEnabled ? theme.colorScheme.onPrimary : theme.colorScheme.surface)
                    .fontWeight(.bold)
            }
        }
        .frame(width: 40, height: 40)
        .contentShape(Rectangle())
        .onTapGesture {
            if isEnabled {
                withAnimation(.easeInOut(duration: 0.1)) {
                    isChecked.toggle()
                }
            }
        }
    }
}

@available(iOS 15, macOS 12.0, *)
struct MaterialCheckbox_Previews: PreviewProvider {
    struct PreviewContainer: View {
        @State private var a = true
        @State private var b = false
        @State private var c = true

        var body: some View {
            VStack(alignment: .leading, spacing: 4) {
                HStack { MaterialCheckbox(isChecked: $a); Text("Option A") }
                HStack { MaterialCheckbox(isChecked: $b); Text("Option B") }
                HStack { MaterialCheckbox(isChecked: $c).disabled(true); Text("Disabled (checked)") }
            }
            .padding()
            .materialTheme(.light)
        }
    }

    static var previews: some View {
        PreviewContainer()
            .previewDisplayName("MaterialCheckbox — Light")
    }
}
