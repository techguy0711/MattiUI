//
//  MaterialTextField.swift
//
//
//  A Material Design-styled text input with a floating label.
//

import SwiftUI

/// The container treatment of a ``MaterialTextField``.
@available(iOS 18, macOS 15.0, *)
public enum MuiTextFieldStyle {
    /// A bordered outline that thickens and tints when focused.
    case outlined
    /// A tinted, borderless fill.
    case filled
}

/// A Material Design-styled text field with a floating label: the label sits
/// inside the field as a placeholder until the field is focused or has
/// content, at which point it shrinks and moves above the input.
///
/// ```swift
/// @State var email = ""
/// MaterialTextField(label: "Email", text: $email)
/// ```
///
/// Uses a single, persistent `TextField` under the hood (the floating label
/// is a non-interactive overlay) so `@FocusState` isn't disrupted by the
/// label animation — an earlier draft swapped between two `TextField`
/// instances depending on focus state, which caused the keyboard/focus to
/// drop on every transition.
@available(iOS 18, macOS 15.0, *)
public struct MaterialTextField: View {
    /// The floating label / placeholder text.
    public var label: String
    /// The current text content.
    @Binding public var text: String
    /// Outlined or filled container treatment. Defaults to `.outlined`.
    public var style: MuiTextFieldStyle
    /// The tint used for the focused border/label. Defaults to `.accentColor`.
    public var accentColor: Color
    /// Optional error message shown below the field; also tints the field red.
    public var errorText: String?

    @FocusState private var isFocused: Bool

    /// Creates a Material text field.
    /// - Parameters:
    ///   - label: The floating label / placeholder text.
    ///   - text: A binding to the field's text content.
    ///   - style: Outlined or filled container treatment. Defaults to `.outlined`.
    ///   - accentColor: The tint used for the focused border/label. Defaults to `.accentColor`.
    ///   - errorText: Optional error message shown below the field.
    public init(
        label: String,
        text: Binding<String>,
        style: MuiTextFieldStyle = .outlined,
        accentColor: Color = .accentColor,
        errorText: String? = nil
    ) {
        self.label = label
        self._text = text
        self.style = style
        self.accentColor = accentColor
        self.errorText = errorText
    }

    /// True once the label should be shown in its small, elevated position:
    /// either the field is focused, or it already has content.
    private var isElevated: Bool {
        isFocused || !text.isEmpty
    }

    private var activeColor: Color {
        if errorText != nil { return .red }
        return isFocused ? accentColor : Color.gray.opacity(0.6)
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ZStack(alignment: .leading) {
                background

                TextField("", text: $text)
                    .focused($isFocused)
                    .padding(.horizontal, 12)
                    .padding(.top, isElevated ? 12 : 0)

                Text(label)
                    .font(isElevated ? .caption : .body)
                    .foregroundColor(isElevated ? activeColor : .secondary)
                    .padding(.horizontal, 12)
                    .offset(y: isElevated ? -14 : 0)
                    .allowsHitTesting(false)
                    .animation(.easeOut(duration: 0.15), value: isElevated)
            }
            .frame(height: 52)

            if let errorText {
                Text(errorText)
                    .font(.caption)
                    .foregroundColor(.red)
                    .padding(.leading, 12)
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(label)
        .accessibilityValue(text)
    }

    @ViewBuilder
    private var background: some View {
        switch style {
        case .filled:
            RoundedRectangle(cornerRadius: 8)
                .fill(activeColor.opacity(0.08))
        case .outlined:
            RoundedRectangle(cornerRadius: 8)
                .stroke(activeColor, lineWidth: isFocused ? 2 : 1)
        }
    }
}
