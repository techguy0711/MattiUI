//
//  MaterialDialog.swift
//
//
//  A Material Design modal confirmation dialog.
//

import SwiftUI

/// A Material Design modal dialog: a scrim backdrop behind a title, optional
/// message, and a row of caller-supplied action buttons.
///
/// You'll typically apply this via the ``SwiftUI/View/materialDialog(isPresented:title:message:actions:)``
/// modifier rather than constructing it directly:
///
/// ```swift
/// @State var showDialog = false
///
/// MyContent()
///     .materialDialog(isPresented: $showDialog, title: "Delete item?", message: "This can't be undone.") {
///         MaterialButton(title: "Cancel", style: .outline) { showDialog = false }
///         MaterialButton(title: "Delete", backgroundColor: .red) { delete() }
///     }
/// ```
///
/// The scrim intentionally does not dismiss the dialog on tap — Material
/// dialogs require an explicit action, unlike sheets. Wire dismissal into one
/// of your `actions` (as above).
@available(iOS 18, macOS 15.0, *)
public struct MaterialDialog<Actions: View>: View {
    /// The dialog's title.
    public var title: String
    /// Optional supporting message shown below the title.
    public var message: String?
    /// Controls presentation.
    @Binding public var isPresented: Bool
    /// A row of action buttons (e.g. Cancel / Confirm). Responsible for
    /// setting `isPresented` to `false` when an action should dismiss the dialog.
    @ViewBuilder public var actions: () -> Actions

    /// Creates a Material dialog.
    /// - Parameters:
    ///   - title: The dialog's title.
    ///   - message: Optional supporting message.
    ///   - isPresented: Controls presentation.
    ///   - actions: A row of action buttons.
    public init(
        title: String,
        message: String? = nil,
        isPresented: Binding<Bool>,
        @ViewBuilder actions: @escaping () -> Actions
    ) {
        self.title = title
        self.message = message
        self._isPresented = isPresented
        self.actions = actions
    }

    public var body: some View {
        if isPresented {
            ZStack {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()

                VStack(alignment: .leading, spacing: 16) {
                    Text(title)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .accessibilityAddTraits(.isHeader)

                    if let message {
                        Text(message)
                            .font(.body)
                            .foregroundColor(.secondary)
                    }

                    HStack(spacing: 12) {
                        Spacer(minLength: 0)
                        actions()
                    }
                }
                .padding(24)
                .background(Color.mattiSurface)
                .cornerRadius(16)
                .shadow(radius: 20)
                .padding(32)
                .frame(maxWidth: 420)
            }
            .transition(.opacity.combined(with: .scale(scale: 0.95)))
            .accessibilityAddTraits(.isModal)
            .zIndex(1)
        }
    }
}

@available(iOS 18, macOS 15.0, *)
public extension View {
    /// Presents a ``MaterialDialog`` as an overlay on top of this view
    /// whenever `isPresented` is `true`.
    /// - Parameters:
    ///   - isPresented: Controls presentation.
    ///   - title: The dialog's title.
    ///   - message: Optional supporting message.
    ///   - actions: A row of action buttons.
    func materialDialog<Actions: View>(
        isPresented: Binding<Bool>,
        title: String,
        message: String? = nil,
        @ViewBuilder actions: @escaping () -> Actions
    ) -> some View {
        overlay {
            MaterialDialog(title: title, message: message, isPresented: isPresented, actions: actions)
                .animation(.easeOut(duration: 0.2), value: isPresented.wrappedValue)
        }
    }
}
