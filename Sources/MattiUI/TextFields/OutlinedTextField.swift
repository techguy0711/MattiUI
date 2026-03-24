//
//  OutlinedTextField.swift
//  MattiUI
//
//  Material Design 3 — Outlined Text Field
//  Reference: https://m3.material.io/components/text-fields/specs#68b1ae13-daa6-4e12-a9df-28f4c3f4e998

import SwiftUI

/// A Material Design 3 **Outlined Text Field** — uses a bordered container instead of a filled one.
///
/// Equivalent to `OutlinedTextField` in Jetpack Compose.
///
/// ```swift
/// @State private var username = ""
/// OutlinedTextField("Username", text: $username)
/// ```
@available(iOS 15, macOS 12.0, *)
public struct OutlinedTextField: View {
    @Environment(\.materialTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled
    @FocusState private var isFocused: Bool

    public var label: String
    @Binding public var text: String
    public var isSecure: Bool
    public var leadingIcon: Image?
    public var trailingIcon: Image?
    public var supportingText: String?
    public var isError: Bool

    public init(
        _ label: String,
        text: Binding<String>,
        isSecure: Bool = false,
        leadingIcon: Image? = nil,
        trailingIcon: Image? = nil,
        supportingText: String? = nil,
        isError: Bool = false
    ) {
        self.label = label
        self._text = text
        self.isSecure = isSecure
        self.leadingIcon = leadingIcon
        self.trailingIcon = trailingIcon
        self.supportingText = supportingText
        self.isError = isError
    }

    private var labelIsFloating: Bool { isFocused || !text.isEmpty }

    private var activeColor: Color {
        if !isEnabled { return theme.colorScheme.onSurface.opacity(0.38) }
        if isError { return theme.colorScheme.error }
        if isFocused { return theme.colorScheme.primary }
        return theme.colorScheme.onSurfaceVariant
    }

    private var borderWidth: CGFloat { isFocused || isError ? 2 : 1 }

    public var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ZStack(alignment: .leading) {
                // Border
                RoundedRectangle(cornerRadius: theme.shapes.extraSmall, style: .continuous)
                    .strokeBorder(
                        isEnabled
                            ? (labelIsFloating ? activeColor : theme.colorScheme.outline)
                            : theme.colorScheme.onSurface.opacity(0.12),
                        lineWidth: borderWidth
                    )

                HStack(spacing: 16) {
                    if let leadingIcon = leadingIcon {
                        leadingIcon
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(activeColor)
                    }

                    ZStack(alignment: .leading) {
                        // Floating label
                        Text(label)
                            .font(labelIsFloating
                                ? theme.typography.bodySmall.font
                                : theme.typography.bodyLarge.font)
                            .foregroundColor(activeColor)
                            .background(theme.colorScheme.surface)
                            .offset(y: labelIsFloating ? -28 : 0)
                            .animation(.easeInOut(duration: 0.15), value: labelIsFloating)

                        // Input field
                        if isSecure {
                            SecureField("", text: $text)
                                .focused($isFocused)
                                .font(theme.typography.bodyLarge.font)
                                .foregroundColor(isEnabled ? theme.colorScheme.onSurface : theme.colorScheme.onSurface.opacity(0.38))
                        } else {
                            TextField("", text: $text)
                                .focused($isFocused)
                                .font(theme.typography.bodyLarge.font)
                                .foregroundColor(isEnabled ? theme.colorScheme.onSurface : theme.colorScheme.onSurface.opacity(0.38))
                        }
                    }

                    if let trailingIcon = trailingIcon {
                        trailingIcon
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(activeColor)
                    }
                }
                .padding(.horizontal, 16)
            }
            .frame(height: 56)
            .disabled(!isEnabled)

            // Supporting text
            if let supportingText = supportingText {
                Text(supportingText)
                    .font(theme.typography.bodySmall.font)
                    .foregroundColor(isError ? theme.colorScheme.error : theme.colorScheme.onSurfaceVariant)
                    .padding(.horizontal, 16)
            }
        }
    }
}

@available(iOS 15, macOS 12.0, *)
struct OutlinedTextField_Previews: PreviewProvider {
    struct PreviewContainer: View {
        @State private var username = ""
        @State private var bio = "SwiftUI developer"

        var body: some View {
            VStack(spacing: 16) {
                OutlinedTextField("Username", text: $username,
                                  leadingIcon: Image(systemName: "person"),
                                  supportingText: "Required")
                OutlinedTextField("Bio", text: $bio)
                OutlinedTextField("Disabled field", text: .constant(""))
                    .disabled(true)
            }
            .padding()
            .materialTheme(.light)
        }
    }

    static var previews: some View {
        PreviewContainer()
            .previewDisplayName("OutlinedTextField — Light")
    }
}
