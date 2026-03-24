//
//  MaterialDivider.swift
//  MattiUI
//
//  Material Design 3 — Divider
//  Reference: https://m3.material.io/components/divider/specs

import SwiftUI

/// A Material Design 3 **Divider** — a thin line separating content.
///
/// Equivalent to `Divider` / `HorizontalDivider` / `VerticalDivider` in Jetpack Compose.
///
/// ```swift
/// MaterialDivider()            // full-width horizontal divider
/// MaterialDivider(inset: 16)   // inset divider
/// MaterialDivider(isVertical: true, length: 40) // vertical divider
/// ```
@available(iOS 15, macOS 12.0, *)
public struct MaterialDivider: View {
    @Environment(\.materialTheme) private var theme

    public var isVertical: Bool
    public var inset: CGFloat
    public var length: CGFloat?

    public init(isVertical: Bool = false, inset: CGFloat = 0, length: CGFloat? = nil) {
        self.isVertical = isVertical
        self.inset = inset
        self.length = length
    }

    public var body: some View {
        if isVertical {
            Rectangle()
                .fill(theme.colorScheme.outlineVariant)
                .frame(width: 1, height: length)
        } else {
            Rectangle()
                .fill(theme.colorScheme.outlineVariant)
                .frame(height: 1)
                .padding(.leading, inset)
        }
    }
}

@available(iOS 15, macOS 12.0, *)
struct MaterialDivider_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 24) {
            // Full-width divider
            VStack(spacing: 16) {
                Text("Item 1").frame(maxWidth: .infinity, alignment: .leading)
                MaterialDivider()
                Text("Item 2").frame(maxWidth: .infinity, alignment: .leading)
                MaterialDivider(inset: 16)
                Text("Item 3").frame(maxWidth: .infinity, alignment: .leading)
            }

            // Vertical divider
            HStack(spacing: 16) {
                Text("Left")
                MaterialDivider(isVertical: true, length: 40)
                Text("Right")
            }
        }
        .padding()
        .materialTheme(.light)
        .previewDisplayName("MaterialDivider — Light")
    }
}
