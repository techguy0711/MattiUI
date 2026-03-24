//
//  BadgedBox.swift
//  MattiUI
//
//  Material Design 3 — Badge / BadgedBox
//  Reference: https://m3.material.io/components/badges/specs

import SwiftUI

// MARK: - Badge

/// A Material Design 3 **Badge** — a small status indicator showing a count or dot.
///
/// Equivalent to `Badge` in Jetpack Compose.
///
/// ```swift
/// Badge()               // dot badge
/// Badge(count: 3)       // numeric badge
/// Badge(count: 1000)    // shows "999+"
/// ```
@available(iOS 15, macOS 12.0, *)
public struct Badge: View {
    @Environment(\.materialTheme) private var theme

    public var count: Int?

    public init(count: Int? = nil) {
        self.count = count
    }

    private var displayText: String? {
        guard let count = count else { return nil }
        return count > 999 ? "999+" : "\(count)"
    }

    public var body: some View {
        Group {
            if let text = displayText {
                Text(text)
                    .font(theme.typography.labelSmall.font)
                    .foregroundColor(theme.colorScheme.onError)
                    .padding(.horizontal, 4)
                    .frame(minWidth: 16, minHeight: 16)
                    .background(
                        Capsule()
                            .fill(theme.colorScheme.error)
                    )
            } else {
                // Dot badge
                Circle()
                    .fill(theme.colorScheme.error)
                    .frame(width: 6, height: 6)
            }
        }
    }
}

// MARK: - BadgedBox

/// Wraps content with an optional `Badge` anchored to the top-trailing corner.
///
/// Equivalent to `BadgedBox` in Jetpack Compose.
///
/// ```swift
/// BadgedBox(badge: Badge(count: 5)) {
///     Image(systemName: "bell")
/// }
/// ```
@available(iOS 15, macOS 12.0, *)
public struct BadgedBox<Content: View>: View {
    public var badge: Badge
    public var content: () -> Content

    public init(badge: Badge, @ViewBuilder content: @escaping () -> Content) {
        self.badge = badge
        self.content = content
    }

    public var body: some View {
        ZStack(alignment: .topTrailing) {
            content()
            badge
                .offset(x: 6, y: -6)
        }
    }
}

// MARK: - Previews

@available(iOS 15, macOS 12.0, *)
struct Badge_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 32) {
            BadgedBox(badge: Badge()) {
                Image(systemName: "bell")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28, height: 28)
            }

            BadgedBox(badge: Badge(count: 3)) {
                Image(systemName: "envelope")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28, height: 28)
            }

            BadgedBox(badge: Badge(count: 1200)) {
                Image(systemName: "message")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28, height: 28)
            }
        }
        .padding()
        .materialTheme(.light)
        .previewDisplayName("Badge / BadgedBox — Light")
    }
}
