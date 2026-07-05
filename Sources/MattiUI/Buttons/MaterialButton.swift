//
//  Buttons.swift
//  swiftui material components proto
//
//  Created by Kristhian De Oliveira on 2/1/23.
//https://m2.material.io/design/material-theming/overview.html#material-theming

import SwiftUI

@available(iOS 15, macOS 12.0, *)
public enum MuiButtonShape {
    case rounded
    case rectangle
}

@available(iOS 15, macOS 12.0, *)
public enum MuiButtonStyle {
    case fill
    case outline
}

@available(iOS 15, macOS 12.0, *)
public struct MaterialButton<Content: View>: View {
    public var title: String
    public var shape: MuiButtonShape
    public var style: MuiButtonStyle
    public var action: () -> Void
    public var backgroundColor: Color
    public var textColor: Color
    @ViewBuilder public var icon: () -> Content

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

@available(iOS 15, macOS 12.0, *)
public extension MaterialButton where Content == EmptyView {
    /// Convenience initializer for buttons with no icon.
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
