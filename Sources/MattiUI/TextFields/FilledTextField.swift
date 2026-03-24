//
//  FilledTextField.swift
//  MattiUI
//
//  Material Design 3 — Filled Text Field
//  Reference: https://m3.material.io/components/text-fields/specs#e4964192-72ad-414f-85b4-4b4357abb068

import SwiftUI

/// A Material Design 3 **Filled Text Field** — uses a filled container background.
///
/// Equivalent to `TextField` (default) in Jetpack Compose Material 3.
///
/// ```swift
/// @State private var text = ""
/// FilledTextField("Email", text: $text)
/// FilledTextField("Password", text: $text, isSecure: true)
/// FilledTextField("Search", text: $text, leadingIcon: Image(systemName: "magnifyingglass"))
/// ```
@available(iOS 15, macOS 12.0, *)
public struct FilledTextField: View {
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

    public var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ZStack(alignment: .leading) {
                // Background
                RoundedRectangle(cornerRadius: theme.shapes.extraSmall, style: .continuous)
                    .fill(isEnabled
                        ? theme.colorScheme.surfaceVariant
                        : theme.colorScheme.onSurface.opacity(0.04))
                    .overlay(alignment: .bottom) {
                        // Indicator line
                        Rectangle()
                            .fill(activeColor)
                            .frame(height: isFocused ? 2 : 1)
                    }

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
                            .offset(y: labelIsFloating ? -12 : 0)
                            .animation(.easeInOut(duration: 0.15), value: labelIsFloating)

                        // Input field
                        if isSecure {
                            SecureField("", text: $text)
                                .focused($isFocused)
                                .font(theme.typography.bodyLarge.font)
                                .foregroundColor(isEnabled ? theme.colorScheme.onSurface : theme.colorScheme.onSurface.opacity(0.38))
                                .offset(y: 8)
                        } else {
                            TextField("", text: $text)
                                .focused($isFocused)
                                .font(theme.typography.bodyLarge.font)
                                .foregroundColor(isEnabled ? theme.colorScheme.onSurface : theme.colorScheme.onSurface.opacity(0.38))
                                .offset(y: 8)
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
                .padding(.top, labelIsFloating ? 8 : 0)
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
struct FilledTextField_Previews: PreviewProvider {
    struct PreviewContainer: View {
        @State private var email = ""
        @State private var password = ""
        @State private var search = "SwiftUI"

        var body: some View {
            VStack(spacing: 16) {
                FilledTextField("Email address", text: $email,
                                leadingIcon: Image(systemName: "envelope"),
                                supportingText: "We'll never share your email")
                FilledTextField("Password", text: $password, isSecure: true,
                                trailingIcon: Image(systemName: "eye.slash"))
                FilledTextField("Search", text: $search,
                                leadingIcon: Image(systemName: "magnifyingglass"),
                                isError: true,
                                supportingText: "No results found")
            }
            .padding()
            .materialTheme(.light)
        }
    }

    static var previews: some View {
        PreviewContainer()
            .previewDisplayName("FilledTextField — Light")
    }
}
