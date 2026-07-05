//
//  File.swift
//
//
//  Created by Kristhian De Oliveira on 3/5/23.
//

import SwiftUI

/// A row of tappable stars for capturing a 1-to-`maximum` rating.
///
/// ```swift
/// @State var rating = 0
/// Rating(value: $rating) { stars in print("\(stars) stars") }
/// ```
///
/// Also supports VoiceOver's adjustable action (swipe up/down) to change the
/// value without needing to target an individual star.
@available(iOS 18, macOS 15.0, *)
public struct Rating: View {
    /// Previously this was `@State public var values: Int = 0`, seeded once
    /// from `init` and never able to reflect changes made by the parent
    /// afterward (SwiftUI only applies an `@State` initial value once, on
    /// first creation of the view). Using `@Binding` makes the parent's
    /// value the single source of truth, as it should be for a control like
    /// this.
    @Binding public var value: Int
    /// The number of stars shown. Defaults to 5.
    public var maximum: Int
    /// Called whenever the selected value changes.
    public var onChange: ((Int) -> Void)?

    /// Creates a star rating control.
    /// - Parameters:
    ///   - value: A binding to the current rating (0...`maximum`).
    ///   - maximum: The number of stars shown. Defaults to 5.
    ///   - onChange: Called whenever the selected value changes.
    public init(value: Binding<Int>, maximum: Int = 5, onChange: ((Int) -> Void)? = nil) {
        self._value = value
        self.maximum = maximum
        self.onChange = onChange
    }

    public var body: some View {
        HStack {
            // Previously this was 5 near-identical copy-pasted Image blocks,
            // one per star. Collapsed into a single ForEach driven by `maximum`
            // so the star count is no longer hardcoded to 5.
            ForEach(1...max(maximum, 1), id: \.self) { star in
                Image(systemName: value >= star ? "star.fill" : "star")
                    .foregroundColor(.yellow)
                    .onTapGesture {
                        value = star
                        onChange?(star)
                    }
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Rating")
        .accessibilityValue("\(value) out of \(maximum) stars")
        .accessibilityAddTraits(.isButton)
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment:
                value = min(value + 1, maximum)
            case .decrement:
                value = max(value - 1, 0)
            @unknown default:
                break
            }
            onChange?(value)
        }
    }
}
