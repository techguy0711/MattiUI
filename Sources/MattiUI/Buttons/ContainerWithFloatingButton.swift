//
//  FloatingButton.swift
//  swiftui material components proto
//
//  Created by Kristhian De Oliveira on 2/2/23.
//

import SwiftUI

/// Wraps arbitrary content in a screen-level container with a Material
/// Floating Action Button anchored to the bottom-trailing corner.
///
/// ```swift
/// ContainerWithFloatingButton(buttonContent: { Image(systemName: "plus") }, bodyContent: {
///     MyScreenContent()
/// }) {
///     // FAB tapped
/// }
/// ```
@available(iOS 18, macOS 15.0, *)
public struct ContainerWithFloatingButton<ButtonContent, BodyContent> : View where ButtonContent: View, BodyContent: View {
    /// Content shown inside the circular FAB (typically an SF Symbol `Image`).
    @ViewBuilder public var buttonContent: () -> ButtonContent
    /// The FAB's fill color. Defaults to `.accentColor`.
    public var backgroundColor: Color
    /// The main screen content the FAB floats above.
    @ViewBuilder public var bodyContent: () -> BodyContent
    /// Called when the FAB is tapped.
    public var action: () -> Void

    /// Creates a container with a floating action button.
    /// - Parameters:
    ///   - buttonContent: Content shown inside the circular FAB.
    ///   - backgroundColor: The FAB's fill color. Defaults to `.accentColor`.
    ///   - bodyContent: The main screen content.
    ///   - action: Called when the FAB is tapped.
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
