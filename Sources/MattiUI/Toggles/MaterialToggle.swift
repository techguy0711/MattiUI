//
//  MaterialToggle.swift
//  swiftui material components proto
//
//  Created by Kristhian De Oliveira on 2/2/23.
//

import SwiftUI

@available(iOS 15, macOS 12.0, *)
public struct MaterialToggle: View {
    public var color: Color
    /// Previously `@State var isOn: Bool = false`, seeded once from `init`
    /// and disconnected from the parent afterward. `@Binding` makes the
    /// parent the source of truth so external state changes are reflected.
    @Binding public var isOn: Bool
    public var didChange: ((Bool) -> Void)?

    private let trackWidth: CGFloat = 50
    private let trackHeight: CGFloat = 30
    private let thumbDiameter: CGFloat = 26

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
