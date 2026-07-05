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
    public var backgroundColor: Color
    @ViewBuilder public var bodyContent: () -> BodyContent
    public var action: () -> Void

    public init(
        @ViewBuilder buttonContent: @escaping () -> ButtonContent,
        backgroundColor: Color = .accentColor,
        @ViewBuilder bodyContent: @escaping () -> BodyContent,
        action: @escaping () -> Void
    ) {
        self.buttonContent = buttonContent
        self.backgroundColor = backgroundColor
        self.bodyContent = bodyContent
        self.action = action
    }

    public var body: some View {
        // Previously this pinned the FAB with `.padding(.top, 700).padding(.leading, 250)`,
        // hardcoded pixel offsets tuned to one specific screen size. On any other device
        // the button would land off-screen or overlap content. Anchoring the ZStack to
        // `.bottomTrailing` and padding by a fixed inset instead keeps the FAB in the
        // correct corner regardless of screen size, per the Material FAB spec.
        ZStack(alignment: .bottomTrailing) {
            bodyContent()
            Button(action: action) {
                buttonContent()
                    .padding()
            }
            .background(backgroundColor)
            .clipShape(Circle())
            .shadow(radius: 6, y: 3)
            .padding(16)
            .accessibilityAddTraits(.isButton)
        }
    }
}
