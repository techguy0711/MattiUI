//
//  MaterialRadioButton.swift
//  MattiUI
//
//  Material Design 3 — Radio Button
//  Reference: https://m3.material.io/components/radio-button/specs

import SwiftUI

/// A Material Design 3 **Radio Button** — a circular selection control for mutually exclusive options.
///
/// Equivalent to `RadioButton` in Jetpack Compose.
///
/// ```swift
/// @State private var selected = "Option A"
/// MaterialRadioButton(isSelected: selected == "Option A") { selected = "Option A" }
/// ```
@available(iOS 15, macOS 12.0, *)
public struct MaterialRadioButton: View {
    @Environment(\.materialTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    public var isSelected: Bool
    public var onSelect: () -> Void

    public init(isSelected: Bool, onSelect: @escaping () -> Void) {
        self.isSelected = isSelected
        self.onSelect = onSelect
    }

    private var ringColor: Color {
        if !isEnabled { return theme.colorScheme.onSurface.opacity(0.38) }
        return isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant
    }

    public var body: some View {
        ZStack {
            Circle()
                .strokeBorder(ringColor, lineWidth: 2)
                .frame(width: 20, height: 20)

            if isSelected {
                Circle()
                    .fill(ringColor)
                    .frame(width: 10, height: 10)
            }
        }
        .frame(width: 40, height: 40)
        .contentShape(Circle())
        .animation(.easeInOut(duration: 0.1), value: isSelected)
        .onTapGesture {
            if isEnabled && !isSelected {
                onSelect()
            }
        }
    }
}

// MARK: - MaterialRadioGroup

/// Convenience wrapper for a group of radio buttons with a shared selection binding.
@available(iOS 15, macOS 12.0, *)
public struct MaterialRadioGroup<T: Hashable>: View {
    public var options: [T]
    @Binding public var selection: T
    public var label: (T) -> String

    public init(options: [T], selection: Binding<T>, label: @escaping (T) -> String) {
        self.options = options
        self._selection = selection
        self.label = label
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ForEach(options, id: \.self) { option in
                HStack(spacing: 0) {
                    MaterialRadioButton(isSelected: selection == option) {
                        selection = option
                    }
                    Text(label(option))
                        .font(.body)
                }
            }
        }
    }
}

@available(iOS 15, macOS 12.0, *)
struct MaterialRadioButton_Previews: PreviewProvider {
    struct PreviewContainer: View {
        @State private var selection = "Option A"
        let options = ["Option A", "Option B", "Option C"]

        var body: some View {
            MaterialRadioGroup(options: options, selection: $selection) { $0 }
                .padding()
                .materialTheme(.light)
        }
    }

    static var previews: some View {
        PreviewContainer()
            .previewDisplayName("MaterialRadioButton — Light")
    }
}
