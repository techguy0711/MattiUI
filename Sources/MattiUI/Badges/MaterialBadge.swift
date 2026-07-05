//
//  MaterialBadge.swift
//
//
//  A small Material Design badge for notification counts or status dots.
//

import SwiftUI

/// A small badge showing either a count (capped at "99+") or, when no count
/// is supplied, a plain status dot. Typically overlaid on the corner of an
/// icon.
///
/// ```swift
/// Image(systemName: "bell")
///     .overlay(alignment: .topTrailing) {
///         MaterialBadge(count: 4)
///             .offset(x: 8, y: -8)
///     }
/// ```
@available(iOS 18, macOS 15.0, *)
public struct MaterialBadge: View {
    /// The count to display. Values over 99 are shown as "99+". A `nil` or
    /// zero count renders a plain dot instead of a number.
    public var count: Int?
    /// The badge's fill color. Defaults to `.red`.
    public var color: Color

    /// Creates a Material badge.
    /// - Parameters:
    ///   - count: The count to display, or `nil` for a plain status dot.
    ///   - color: The badge's fill color. Defaults to `.red`.
    public init(count: Int? = nil, color: Color = .red) {
        self.count = count
        self.color = color
    }

    public var body: some View {
        if let count, count > 0 {
            Text(count > 99 ? "99+" : "\(count)")
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(.white)
                .padding(.horizontal, count > 9 ? 5 : 0)
                .frame(minWidth: 16, minHeight: 16)
                .background(Circle().fill(color))
                .accessibilityLabel("\(count) \(count == 1 ? "notification" : "notifications")")
        } else {
            Circle()
                .fill(color)
                .frame(width: 8, height: 8)
                .accessibilityHidden(true)
        }
    }
}
