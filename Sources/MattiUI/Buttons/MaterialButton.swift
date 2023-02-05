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
public enum MuiButtonStyle {
    case fill
    case outline
}
@available(iOS 15, macOS 12.0, *)
public struct MaterialButton: View {
    public var tittle:String
    public var shape:MuiButtonShape = .rounded
    public var style:MuiButtonStyle = .fill
    public var action: () -> Void
    public var backgroundColor:Color = .black
    public var textColor:Color = .red
    public var icon: AnyView?
    public var body: some View {
        Button(action: action, label: {
            HStack {
                AnyView(icon.foregroundColor(textColor))
                    .padding(.leading)
                Text(tittle)
                    .padding()
                    .foregroundColor(textColor)
            }.overlay(
                    RoundedRectangle(cornerRadius: shape == .rounded ? 25 : 0)
                        .stroke(style == .outline ?backgroundColor : Color.clear, lineWidth: 5)
                )
        })
        .background(style == .fill ? backgroundColor : Color.clear)
        .cornerRadius(shape == .rounded ? 25 : 0)
        //TODO: add shadow to match Android mui guidelines
    }
}
