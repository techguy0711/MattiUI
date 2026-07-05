//
//  File.swift
//
//
//  Created by Kristhian De Oliveira on 3/5/23.
//

import SwiftUI

@available(iOS 15, macOS 12.0, *)
public struct Rating: View {
    /// Previously this was `@State public var values: Int = 0`, seeded once
    /// from `init` and never able to reflect changes made by the parent
    /// afterward (SwiftUI only applies an `@State` initial value once, on
    /// first creation of the view). Using `@Binding` makes the parent's
    /// value the single source of truth, as it should be for a control like
    /// this.
    @Binding public var value: Int
    public var maximum: Int
    public var onChange: ((Int) -> Void)?

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
