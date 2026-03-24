//
//  CircularProgressIndicator.swift
//  MattiUI
//
//  Material Design 3 — Circular Progress Indicator
//  Reference: https://m3.material.io/components/progress-indicators/specs

import SwiftUI

/// A Material Design 3 **Circular Progress Indicator**.
///
/// Use `progress = nil` for an indeterminate (spinning) indicator.
/// Use a value between 0.0 and 1.0 for a determinate indicator.
///
/// Equivalent to `CircularProgressIndicator` in Jetpack Compose.
///
/// ```swift
/// CircularProgressIndicator()               // indeterminate
/// CircularProgressIndicator(progress: 0.5) // 50% complete
/// ```
@available(iOS 15, macOS 12.0, *)
public struct CircularProgressIndicator: View {
    @Environment(\.materialTheme) private var theme

    public var progress: Double?
    public var size: CGFloat
    public var strokeWidth: CGFloat

    @State private var rotation: Double = 0
    @State private var trimEnd: Double = 0.75

    public init(progress: Double? = nil, size: CGFloat = 48, strokeWidth: CGFloat = 4) {
        self.progress = progress
        self.size = size
        self.strokeWidth = strokeWidth
    }

    public var body: some View {
        ZStack {
            // Track circle
            Circle()
                .stroke(theme.colorScheme.secondaryContainer, lineWidth: strokeWidth)

            if let progress = progress {
                // Determinate
                Circle()
                    .trim(from: 0, to: CGFloat(max(0, min(1, progress))))
                    .stroke(
                        theme.colorScheme.primary,
                        style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut(duration: 0.3), value: progress)
            } else {
                // Indeterminate
                Circle()
                    .trim(from: 0, to: 0.75)
                    .stroke(
                        theme.colorScheme.primary,
                        style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round)
                    )
                    .rotationEffect(.degrees(rotation))
                    .onAppear {
                        withAnimation(.linear(duration: 1.0).repeatForever(autoreverses: false)) {
                            rotation = 360
                        }
                    }
            }
        }
        .frame(width: size, height: size)
    }
}

@available(iOS 15, macOS 12.0, *)
struct CircularProgressIndicator_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 32) {
            CircularProgressIndicator()
            CircularProgressIndicator(progress: 0.35)
            CircularProgressIndicator(progress: 0.75, size: 64, strokeWidth: 6)
        }
        .padding()
        .materialTheme(.light)
        .previewDisplayName("CircularProgressIndicator — Light")
    }
}
