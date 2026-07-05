//
//  Buttons.swift
//  swiftui material components proto
//
//  Created by Kristhian De Oliveira on 2/1/23.
//https://m2.material.io/design/material-theming/overview.html#material-theming

import SwiftUI

/// The corner treatment of a ``MaterialButton``.
@available(iOS 18, macOS 15.0, *)
public enum MuiButtonShape {
    /// Fully rounded (pill-shaped) corners.
    case rounded
    /// Square corners.
    case rectangle
}

/// The fill treatment of a ``MaterialButton``.
@available(iOS 18, macOS 15.0, *)
public enum MuiButtonStyle {
    /// Solid background using `backgroundColor`.
    case fill
    /// Transparent background with a `backgroundColor`-colored border; text/icon
    /// also use `backgroundColor` so they remain legible against any background.
    case outline
}

/// A Material Design-styled button with an optional leading icon.
///
/// ```swift
/// MaterialButton(title: "Done", style: .fill, backgroundColor: .green) {
///     // action
/// }
/// ```
@available(iOS 18, macOS 15.0, *)
public struct MaterialButton<Content: View>: View {
    /// The button's label text.
    public var title: String
    /// Corner treatment. Defaults to `.rounded`.
    public var shape: MuiButtonShape
    /// Fill treatment. Defaults to `.fill`.
    public var style: MuiButtonStyle
    /// Called when the button is tapped.
    public var action: () -> Void
    /// The button's background color in `.fill` style, or border/text color in `.outline` style.
    public var backgroundColor: Color
    /// The label/icon color in `.fill` style. Ignored in `.outline` style (uses `backgroundColor` instead).
    public var textColor: Color
    /// An optional leading icon shown before the title. Use the convenience
    /// initializer (below) to omit this entirely.
    @ViewBuilder public var icon: () -> Content

    /// Creates a Material button with an explicit icon builder.
    /// - Parameters:
    ///   - title: The button's label text.
    ///   - shape: Corner treatment. Defaults to `.rounded`.
    ///   - style: Fill treatment. Defaults to `.fill`.
    ///   - backgroundColor: Fill/border/text-accent color. Defaults to `.accentColor`.
    ///   - textColor: Label color for `.fill` style. Defaults to `.white`.
    ///   - action: Called when tapped.
    ///   - icon: A view builder producing a leading icon.
    public init(
        title: String,
        shape: MuiButtonShape = .rounded,
        style: MuiButtonStyle = .fill,
        backgroundColor: Color = .accentColor,
        textColor: Color = .white,
        action: @escaping () -> Void,
        @ViewBuilder icon: @escaping () -> Content
    ) {
        self.title = title
        self.shape = shape
        self.style = style
        self.action = action
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.icon = icon
    }

    /// The color used for the label/icon. For `.outline` style this is always
    /// `backgroundColor`, since that's the only color drawn (there's no fill
    /// to contrast against) — previously this defaulted to `textColor` (red)
    /// regardless of style, which produced illegible outline buttons.
    private var contentColor: Color {
        style == .outline ? backgroundColor : textColor
    }

    public var body: some View {
        Button(action: action) {
            HStack {
                icon()
                    .foregroundColor(contentColor)
                Text(title)
                    .foregroundColor(contentColor)
                    .padding(.vertical)
                    .padding(.trailing)
            }
            .padding(.leading)
        }
        .background(style == .fill ? backgroundColor : Color.clear)
        .overlay(
            RoundedRectangle(cornerRadius: shape == .rounded ? 25 : 4)
                .stroke(style == .outline ? backgroundColor : Color.clear, lineWidth: 2)
        )
        .cornerRadius(shape == .rounded ? 25 : 4)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(title)
        .accessibilityAddTraits(.isButton)
        //TODO: add shadow to match Android mui guidelines
    }
}

@available(iOS 18, macOS 15.0, *)
public extension MaterialButton where Content == EmptyView {
    /// Creates a Material button with no icon.
    /// - Parameters:
    ///   - title: The button's label text.
    ///   - shape: Corner treatment. Defaults to `.rounded`.
    ///   - style: Fill treatment. Defaults to `.fill`.
    ///   - backgroundColor: Fill/border/text-accent color. Defaults to `.accentColor`.
    ///   - textColor: Label color for `.fill` style. Defaults to `.white`.
    ///   - action: Called when tapped.
    init(
        title: String,
        shape: MuiButtonShape = .rounded,
        style: MuiButtonStyle = .fill,
        backgroundColor: Color = .accentColor,
        textColor: Color = .white,
        action: @escaping () -> Void
    ) {
        self.init(
            title: title,
            shape: shape,
            style: style,
            backgroundColor: backgroundColor,
            textColor: textColor,
            action: action,
            icon: { EmptyView() }
        )
    }
}
