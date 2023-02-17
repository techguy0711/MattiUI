//
//  FloatingButton.swift
//  swiftui material components proto
//
//  Created by Kristhian De Oliveira on 2/2/23.
//

import SwiftUI

@available(iOS 15, macOS 12.0, *)
public struct ContainerWithFloatingButton<ButtonContent, BodyContent> : View where ButtonContent: View, BodyContent: View {
    @ViewBuilder public var buttonContent: () -> ButtonContent
    public var backgroundColor:Color = .black
    @ViewBuilder public var bodyContent: () -> BodyContent
    public var action: () -> Void
    
    public init(@ViewBuilder buttonContent: @escaping () -> ButtonContent, backgroundColor: Color, @ViewBuilder bodyContent: @escaping () -> BodyContent, action: @escaping () -> Void) {
        self.buttonContent = buttonContent
        self.backgroundColor = backgroundColor
        self.bodyContent = bodyContent
        self.action = action
    }
    
    public var body: some View {
        ZStack {
            bodyContent()
            Button(action: action, label: {
                buttonContent()
                    .padding()
            })
            .background(backgroundColor)
            .cornerRadius(25)
            .padding(.top, 700)
            .padding(.leading, 250)
        }
    }
}
