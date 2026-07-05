//
//  MaterialSnackbar.swift
//
//
//  A Material Design transient bottom message with an optional action.
//

import SwiftUI

/// A transient, bottom-anchored message with an optional action button and
/// an auto-dismiss timer, matching the Material Design Snackbar spec.
///
/// You'll typically apply this via the ``SwiftUI/View/materialSnackbar(isPresented:message:actionTitle:duration:onAction:)``
/// modifier rather than constructing it directly:
///
/// ```swift
/// @State var showSnackbar = false
///
/// MyContent()
///     .materialSnackbar(isPresented: $showSnackbar, message: "Saved", actionTitle: "Undo") {
///         // undo action
///     }
/// ```
@available(iOS 18, macOS 15.0, *)
public struct MaterialSnackbar: View {
    /// The message text.
    public var message: String
    /// Optional trailing action button title (e.g. "Undo").
    public var actionTitle: String?
    /// Controls presentation; the snackbar sets this back to `false` when
    /// dismissed (by timeout or action tap).
    @Binding public var isPresented: Bool
    /// How long the snackbar stays visible before auto-dismissing. Defaults to 3 seconds.
    public var duration: TimeInterval
    /// Called when the action button is tapped, before dismissal.
    public var onAction: (() -> Void)?

    /// Creates a Material snackbar.
    /// - Parameters:
    ///   - message: The message text.
    ///   - actionTitle: Optional trailing action button title.
    ///   - isPresented: Controls presentation.
    ///   - duration: How long the snackbar stays visible. Defaults to 3 seconds.
    ///   - onAction: Called when the action button is tapped, before dismissal.
    public init(
        message: String,
        actionTitle: String? = nil,
        isPresented: Binding<Bool>,
        duration: TimeInterval = 3,
        onAction: (() -> Void)? = nil
    ) {
        self.message = message
        self.actionTitle = actionTitle
        self._isPresented = isPresented
        self.duration = duration
        self.onAction = onAction
    }

    public var body: some View {
        if isPresented {
            HStack(spacing: 16) {
                Text(message)
                    .foregroundColor(.white)
                    .lineLimit(2)

                Spacer(minLength: 0)

                if let actionTitle {
                    Button(actionTitle) {
                        onAction?()
                        isPresented = false
                    }
                    .foregroundColor(.yellow)
                    .fontWeight(.semibold)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(Color.black.opacity(0.9))
            .cornerRadius(8)
            .shadow(radius: 8, y: 2)
            .padding(.horizontal, 16)
            .transition(.move(edge: .bottom).combined(with: .opacity))
            .accessibilityElement(children: .combine)
            .accessibilityAddTraits(.updatesFrequently)
            .task(id: isPresented) {
                guard isPresented else { return }
                try? await Task.sleep(nanoseconds: UInt64(duration * 1_000_000_000))
                if !Task.isCancelled {
                    isPresented = false
                }
            }
        }
    }
}

@available(iOS 18, macOS 15.0, *)
public extension View {
    /// Presents a ``MaterialSnackbar`` anchored to the bottom of this view
    /// whenever `isPresented` is `true`, auto-dismissing after `duration`.
    /// - Parameters:
    ///   - isPresented: Controls presentation.
    ///   - message: The message text.
    ///   - actionTitle: Optional trailing action button title.
    ///   - duration: How long the snackbar stays visible. Defaults to 3 seconds.
    ///   - onAction: Called when the action button is tapped, before dismissal.
    func materialSnackbar(
        isPresented: Binding<Bool>,
        message: String,
        actionTitle: String? = nil,
        duration: TimeInterval = 3,
        onAction: (() -> Void)? = nil
    ) -> some View {
        overlay(alignment: .bottom) {
            MaterialSnackbar(
                message: message,
                actionTitle: actionTitle,
                isPresented: isPresented,
                duration: duration,
                onAction: onAction
            )
            .animation(.easeInOut(duration: 0.25), value: isPresented.wrappedValue)
        }
    }
}
