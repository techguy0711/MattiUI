//
//  LinearProgressIndicator.swift
//  MattiUI
//
//  Material Design 3 — Linear Progress Indicator
//  Reference: https://m3.material.io/components/progress-indicators/specs

import SwiftUI

/// A Material Design 3 **Linear Progress Indicator**.
///
/// Use `progress = nil` for an indeterminate (animated) indicator.
/// Use a value between 0.0 and 1.0 for a determinate indicator.
///
/// Equivalent to `LinearProgressIndicator` in Jetpack Compose.
///
/// ```swift
/// LinearProgressIndicator()                // indeterminate
/// LinearProgressIndicator(progress: 0.65) // 65% complete
/// ```
@available(iOS 15, macOS 12.0, *)
public struct LinearProgressIndicator: View {
    @Environment(\.materialTheme) private var theme

    public var progress: Double?
    @State private var animationOffset: CGFloat = -1.0

    public init(progress: Double? = nil) {
        self.progress = progress
    }

    public var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                // Track
                Capsule()
                    .fill(theme.colorScheme.secondaryContainer)
                    .frame(height: 4)

                if let progress = progress {
                    // Determinate
                    Capsule()
                        .fill(theme.colorScheme.primary)
                        .frame(width: geo.size.width * max(0, min(1, progress)), height: 4)
                        .animation(.easeInOut(duration: 0.3), value: progress)
                } else {
                    // Indeterminate
                    Capsule()
                        .fill(theme.colorScheme.primary)
                        .frame(width: geo.size.width * 0.4, height: 4)
                        .offset(x: animationOffset * geo.size.width)
                        .onAppear {
                            withAnimation(
                                .linear(duration: 1.2)
                                .repeatForever(autoreverses: false)
                            ) {
                                animationOffset = 1.6
                            }
                        }
                        .clipped()
                }
            }
        }
        .frame(height: 4)
    }
}

@available(iOS 15, macOS 12.0, *)
struct LinearProgressIndicator_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 24) {
            LinearProgressIndicator()
            LinearProgressIndicator(progress: 0.35)
            LinearProgressIndicator(progress: 0.7)
        }
        .padding()
        .frame(width: 300)
        .materialTheme(.light)
        .previewDisplayName("LinearProgressIndicator — Light")
    }
}
