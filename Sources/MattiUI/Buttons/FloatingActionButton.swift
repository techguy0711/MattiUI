//
//  FloatingActionButton.swift
//  MattiUI
//
//  Material Design 3 — Floating Action Button variants
//  Reference: https://m3.material.io/components/floating-action-button/specs

import SwiftUI

// MARK: - FloatingActionButton

/// A Material Design 3 standard **Floating Action Button** (56×56 pt).
///
/// Equivalent to `FloatingActionButton` in Jetpack Compose.
///
/// ```swift
/// FloatingActionButton(icon: Image(systemName: "plus")) { /* action */ }
/// ```
@available(iOS 15, macOS 12.0, *)
public struct FloatingActionButton: View {
    @Environment(\.materialTheme) private var theme

    public var icon: Image
    public var action: () -> Void

    public init(icon: Image, action: @escaping () -> Void) {
        self.icon = icon
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            icon
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundColor(theme.colorScheme.onPrimaryContainer)
                .frame(width: 56, height: 56)
        }
        .background(
            RoundedRectangle(cornerRadius: theme.shapes.large, style: .continuous)
                .fill(theme.colorScheme.primaryContainer)
                .shadow(color: theme.colorScheme.scrim.opacity(0.3), radius: 3, x: 0, y: 1)
                .shadow(color: theme.colorScheme.scrim.opacity(0.15), radius: 8, x: 0, y: 3)
        )
    }
}

// MARK: - SmallFloatingActionButton

/// A Material Design 3 **Small FAB** (40×40 pt) — for less prominent actions.
///
/// Equivalent to `SmallFloatingActionButton` in Jetpack Compose.
@available(iOS 15, macOS 12.0, *)
public struct SmallFloatingActionButton: View {
    @Environment(\.materialTheme) private var theme

    public var icon: Image
    public var action: () -> Void

    public init(icon: Image, action: @escaping () -> Void) {
        self.icon = icon
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            icon
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundColor(theme.colorScheme.onPrimaryContainer)
                .frame(width: 40, height: 40)
        }
        .background(
            RoundedRectangle(cornerRadius: theme.shapes.medium, style: .continuous)
                .fill(theme.colorScheme.primaryContainer)
                .shadow(color: theme.colorScheme.scrim.opacity(0.3), radius: 3, x: 0, y: 1)
                .shadow(color: theme.colorScheme.scrim.opacity(0.15), radius: 8, x: 0, y: 3)
        )
    }
}

// MARK: - LargeFloatingActionButton

/// A Material Design 3 **Large FAB** (96×96 pt) — for the most prominent action on screen.
///
/// Equivalent to `LargeFloatingActionButton` in Jetpack Compose.
@available(iOS 15, macOS 12.0, *)
public struct LargeFloatingActionButton: View {
    @Environment(\.materialTheme) private var theme

    public var icon: Image
    public var action: () -> Void

    public init(icon: Image, action: @escaping () -> Void) {
        self.icon = icon
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            icon
                .resizable()
                .scaledToFit()
                .frame(width: 36, height: 36)
                .foregroundColor(theme.colorScheme.onPrimaryContainer)
                .frame(width: 96, height: 96)
        }
        .background(
            RoundedRectangle(cornerRadius: theme.shapes.extraLarge, style: .continuous)
                .fill(theme.colorScheme.primaryContainer)
                .shadow(color: theme.colorScheme.scrim.opacity(0.3), radius: 3, x: 0, y: 1)
                .shadow(color: theme.colorScheme.scrim.opacity(0.15), radius: 8, x: 0, y: 3)
        )
    }
}

// MARK: - ExtendedFloatingActionButton

/// A Material Design 3 **Extended FAB** — a wider FAB with an icon and a text label.
///
/// Equivalent to `ExtendedFloatingActionButton` in Jetpack Compose.
///
/// ```swift
/// ExtendedFloatingActionButton("New message", icon: Image(systemName: "plus")) { /* action */ }
/// ```
@available(iOS 15, macOS 12.0, *)
public struct ExtendedFloatingActionButton: View {
    @Environment(\.materialTheme) private var theme

    public var label: String
    public var icon: Image?
    public var action: () -> Void

    public init(_ label: String, icon: Image? = nil, action: @escaping () -> Void) {
        self.label = label
        self.icon = icon
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                if let icon = icon {
                    icon
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                }
                Text(label)
                    .font(theme.typography.labelLarge.font)
                    .kerning(theme.typography.labelLarge.letterSpacing)
            }
            .foregroundColor(theme.colorScheme.onPrimaryContainer)
            .padding(.horizontal, 16)
            .frame(height: 56)
        }
        .background(
            RoundedRectangle(cornerRadius: theme.shapes.large, style: .continuous)
                .fill(theme.colorScheme.primaryContainer)
                .shadow(color: theme.colorScheme.scrim.opacity(0.3), radius: 3, x: 0, y: 1)
                .shadow(color: theme.colorScheme.scrim.opacity(0.15), radius: 8, x: 0, y: 3)
        )
    }
}

// MARK: - Previews

@available(iOS 15, macOS 12.0, *)
struct FloatingActionButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 24) {
            HStack(spacing: 16) {
                SmallFloatingActionButton(icon: Image(systemName: "pencil")) {}
                FloatingActionButton(icon: Image(systemName: "plus")) {}
                LargeFloatingActionButton(icon: Image(systemName: "camera")) {}
            }
            ExtendedFloatingActionButton("Compose", icon: Image(systemName: "pencil")) {}
            ExtendedFloatingActionButton("New message") {}
        }
        .padding()
        .materialTheme(.light)
        .previewDisplayName("FAB variants — Light")
    }
}
