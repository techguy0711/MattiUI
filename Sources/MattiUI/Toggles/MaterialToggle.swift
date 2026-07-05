//
//  MaterialToggle.swift
//  swiftui material components proto
//
//  Created by Kristhian De Oliveira on 2/2/23.
//

import SwiftUI

/// A Material Design-styled on/off switch.
///
/// ```swift
/// @State var isOn = false
/// MaterialToggle(color: .green, isOn: $isOn) { newValue in print(newValue) }
/// ```
@available(iOS 18, macOS 15.0, *)
public struct MaterialToggle: View {
    /// The track/thumb tint color.
    public var color: Color
    /// Previously `@State var isOn: Bool = false`, seeded once from `init`
    /// and disconnected from the parent afterward. `@Binding` makes the
    /// parent the source of truth so external state changes are reflected.
    @Binding public var isOn: Bool
    /// Called whenever the toggle is flipped.
    public var didChange: ((Bool) -> Void)?

    private let trackWidth: CGFloat = 50
    private let trackHeight: CGFloat = 30
    private let thumbDiameter: CGFloat = 26

    /// Creates a Material toggle switch.
    /// - Parameters:
    ///   - color: The track/thumb tint color. Defaults to `.accentColor`.
    ///   - isOn: A binding to the on/off state.
    ///   - didChange: Called whenever the toggle is flipped.
    public init(color: Color = .accentColor, isOn: Binding<Bool>, didChange: ((Bool) -> Void)? = nil) {
        self.color = color
        self._isOn = isOn
        self.didChange = didChange
    }

    public var body: some View {
        // Previously the track was 15pt tall with a 30pt-diameter thumb, so the
        // thumb always overflowed the track vertically, and the thumb was
        // positioned with `.padding(.leading)` / `.padding(.trailing)` using the
        // platform's default padding value — a number with no relationship to
        // the track/thumb geometry, so the thumb didn't reliably reach either
        // edge. Sizing the track to fit the thumb and using a calculated
        // `offset(x:)` fixes both.
        ZStack {
            Capsule()
                .frame(width: trackWidth, height: trackHeight)
                .foregroundColor(color)
                .opacity(isOn ? 0.6 : 0.3)
            Circle()
                .frame(width: thumbDiameter, height: thumbDiameter)
                .foregroundColor(color)
                .shadow(radius: 1)
                .offset(x: isOn ? (trackWidth - thumbDiameter) / 2 : -(trackWidth - thumbDiameter) / 2)
        }
        .animation(.spring(response: 0.25, dampingFraction: 0.75), value: isOn)
        .contentShape(Rectangle())
        .onTapGesture {
            isOn.toggle()
            didChange?(isOn)
        }
        .accessibilityAddTraits(.isButton)
        .accessibilityLabel("Toggle")
        .accessibilityValue(isOn ? "On" : "Off")
    }
}
