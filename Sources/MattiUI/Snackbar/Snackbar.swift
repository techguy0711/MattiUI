//
//  Snackbar.swift
//  MattiUI
//
//  Material Design 3 — Snackbar
//  Reference: https://m3.material.io/components/snackbar/specs

import SwiftUI

// MARK: - SnackbarData

/// Configuration data for a `Snackbar`.
@available(iOS 15, macOS 12.0, *)
public struct SnackbarData: Equatable {
    public var message: String
    public var actionLabel: String?
    public var duration: TimeInterval

    public init(message: String, actionLabel: String? = nil, duration: TimeInterval = 4.0) {
        self.message = message
        self.actionLabel = actionLabel
        self.duration = duration
    }
}

// MARK: - Snackbar

/// A Material Design 3 **Snackbar** — brief, non-intrusive messages at the bottom of the screen.
///
/// Equivalent to `Snackbar` in Jetpack Compose.
///
/// Use the `.snackbar(data:onAction:)` view modifier to show a snackbar from any view.
///
/// ```swift
/// @State private var snack: SnackbarData? = nil
///
/// MyView()
///     .snackbar(data: $snack, onAction: {
///         print("Action tapped")
///     })
/// ```
@available(iOS 15, macOS 12.0, *)
public struct Snackbar: View {
    @Environment(\.materialTheme) private var theme

    public var data: SnackbarData
    public var onAction: (() -> Void)?
    public var onDismiss: (() -> Void)?

    public init(data: SnackbarData, onAction: (() -> Void)? = nil, onDismiss: (() -> Void)? = nil) {
        self.data = data
        self.onAction = onAction
        self.onDismiss = onDismiss
    }

    public var body: some View {
        HStack(spacing: 8) {
            Text(data.message)
                .font(theme.typography.bodyMedium.font)
                .foregroundColor(theme.colorScheme.inverseOnSurface)
                .frame(maxWidth: .infinity, alignment: .leading)

            if let actionLabel = data.actionLabel {
                Button(action: {
                    onAction?()
                    onDismiss?()
                }) {
                    Text(actionLabel)
                        .font(theme.typography.labelLarge.font)
                        .foregroundColor(theme.colorScheme.inversePrimary)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(
            RoundedRectangle(cornerRadius: theme.shapes.extraSmall, style: .continuous)
                .fill(theme.colorScheme.inverseSurface)
        )
        .padding(.horizontal, 16)
    }
}

// MARK: - Snackbar View Modifier

@available(iOS 15, macOS 12.0, *)
extension View {
    /// Displays a snackbar overlay when `data` is non-nil.
    ///
    /// The snackbar auto-dismisses after `data.duration` seconds.
    public func snackbar(
        data: Binding<SnackbarData?>,
        onAction: (() -> Void)? = nil
    ) -> some View {
        self.modifier(SnackbarModifier(data: data, onAction: onAction))
    }
}

@available(iOS 15, macOS 12.0, *)
private struct SnackbarModifier: ViewModifier {
    @Environment(\.materialTheme) private var theme
    @Binding var data: SnackbarData?
    var onAction: (() -> Void)?
    @State private var isVisible = false

    func body(content: Content) -> some View {
        ZStack(alignment: .bottom) {
            content

            if let snack = data {
                Snackbar(
                    data: snack,
                    onAction: onAction,
                    onDismiss: { withAnimation { data = nil } }
                )
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + snack.duration) {
                        withAnimation { data = nil }
                    }
                }
            }
        }
        .animation(.easeInOut(duration: 0.25), value: data != nil)
    }
}

// MARK: - Previews

@available(iOS 15, macOS 12.0, *)
struct Snackbar_Previews: PreviewProvider {
    struct PreviewContainer: View {
        @State private var snack: SnackbarData? = SnackbarData(message: "Photo archived", actionLabel: "Undo")

        var body: some View {
            VStack {
                Spacer()
                Button("Show Snackbar") {
                    snack = SnackbarData(message: "Item deleted", actionLabel: "Undo")
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(m3hex: "#FFFBFE"))
            .snackbar(data: $snack, onAction: { print("Undo") })
            .materialTheme(.light)
        }
    }

    static var previews: some View {
        PreviewContainer()
            .previewDisplayName("Snackbar — Light")

        VStack(alignment: .leading, spacing: 12) {
            Snackbar(data: SnackbarData(message: "Connection restored"))
            Snackbar(data: SnackbarData(message: "Photo archived", actionLabel: "Undo"))
        }
        .padding()
        .background(Color(m3hex: "#FFFBFE"))
        .materialTheme(.light)
        .previewDisplayName("Snackbar static — Light")
    }
}
