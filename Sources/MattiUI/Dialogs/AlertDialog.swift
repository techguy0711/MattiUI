//
//  AlertDialog.swift
//  MattiUI
//
//  Material Design 3 — Alert Dialog
//  Reference: https://m3.material.io/components/dialogs/specs

import SwiftUI

/// A Material Design 3 **Alert Dialog** — presents critical information requiring user acknowledgement.
///
/// Equivalent to `AlertDialog` in Jetpack Compose.
///
/// ```swift
/// @State private var showDialog = false
///
/// AlertDialog(
///     isPresented: $showDialog,
///     icon: Image(systemName: "exclamationmark.triangle"),
///     title: "Discard draft?",
///     text: "All unsaved changes will be lost.",
///     confirmButton: AlertDialogButton(label: "Discard", role: .destructive) { /* action */ },
///     dismissButton: AlertDialogButton(label: "Cancel") { showDialog = false }
/// )
/// ```
@available(iOS 15, macOS 12.0, *)
public struct AlertDialog: View {
    @Environment(\.materialTheme) private var theme

    @Binding public var isPresented: Bool
    public var icon: Image?
    public var title: String
    public var text: String
    public var confirmButton: AlertDialogButton
    public var dismissButton: AlertDialogButton?

    public init(
        isPresented: Binding<Bool>,
        icon: Image? = nil,
        title: String,
        text: String,
        confirmButton: AlertDialogButton,
        dismissButton: AlertDialogButton? = nil
    ) {
        self._isPresented = isPresented
        self.icon = icon
        self.title = title
        self.text = text
        self.confirmButton = confirmButton
        self.dismissButton = dismissButton
    }

    public var body: some View {
        if isPresented {
            ZStack {
                // Scrim
                theme.colorScheme.scrim.opacity(0.32)
                    .ignoresSafeArea()
                    .onTapGesture { isPresented = false }

                // Dialog surface
                VStack(alignment: .center, spacing: 0) {
                    if let icon = icon {
                        icon
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(theme.colorScheme.secondary)
                            .padding(.top, 24)
                            .padding(.bottom, 16)
                    } else {
                        Spacer().frame(height: 24)
                    }

                    Text(title)
                        .font(theme.typography.headlineSmall.font)
                        .foregroundColor(theme.colorScheme.onSurface)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)

                    Text(text)
                        .font(theme.typography.bodyMedium.font)
                        .foregroundColor(theme.colorScheme.onSurfaceVariant)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                        .padding(.top, 16)

                    HStack(spacing: 8) {
                        Spacer()
                        if let dismiss = dismissButton {
                            Button(action: dismiss.action) {
                                Text(dismiss.label)
                                    .font(theme.typography.labelLarge.font)
                                    .foregroundColor(theme.colorScheme.primary)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 10)
                            }
                        }

                        Button(action: confirmButton.action) {
                            Text(confirmButton.label)
                                .font(theme.typography.labelLarge.font)
                                .foregroundColor(
                                    confirmButton.role == .destructive
                                        ? theme.colorScheme.error
                                        : theme.colorScheme.primary
                                )
                                .padding(.horizontal, 12)
                                .padding(.vertical, 10)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 24)
                    .padding(.bottom, 24)
                }
                .background(
                    RoundedRectangle(cornerRadius: theme.shapes.extraLarge, style: .continuous)
                        .fill(theme.colorScheme.surface)
                )
                .frame(minWidth: 280, maxWidth: 560)
                .padding(.horizontal, 40)
            }
        }
    }
}

// MARK: - AlertDialogButton

/// A button configuration for use inside `AlertDialog`.
@available(iOS 15, macOS 12.0, *)
public struct AlertDialogButton {
    public enum Role { case `default`, destructive }

    public var label: String
    public var role: Role
    public var action: () -> Void

    public init(label: String, role: Role = .default, action: @escaping () -> Void) {
        self.label = label
        self.role = role
        self.action = action
    }
}

// MARK: - Previews

@available(iOS 15, macOS 12.0, *)
struct AlertDialog_Previews: PreviewProvider {
    struct PreviewContainer: View {
        @State private var showDialog = true

        var body: some View {
            ZStack {
                Color.gray.opacity(0.2).ignoresSafeArea()
                Button("Show Dialog") { showDialog = true }

                AlertDialog(
                    isPresented: $showDialog,
                    icon: Image(systemName: "trash"),
                    title: "Delete item?",
                    text: "This action cannot be undone. The item will be permanently removed.",
                    confirmButton: AlertDialogButton(label: "Delete", role: .destructive) { showDialog = false },
                    dismissButton: AlertDialogButton(label: "Cancel") { showDialog = false }
                )
            }
            .materialTheme(.light)
        }
    }

    static var previews: some View {
        PreviewContainer()
            .previewDisplayName("AlertDialog — Light")
    }
}
