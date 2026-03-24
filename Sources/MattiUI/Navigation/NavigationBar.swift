//
//  NavigationBar.swift
//  MattiUI
//
//  Material Design 3 — Navigation Bar
//  Reference: https://m3.material.io/components/navigation-bar/specs

import SwiftUI

// MARK: - NavigationBarItem Model

/// Represents a single item in a `NavigationBar`.
@available(iOS 15, macOS 12.0, *)
public struct NavigationBarItem {
    public var icon: Image
    public var selectedIcon: Image?
    public var label: String

    public init(icon: Image, selectedIcon: Image? = nil, label: String) {
        self.icon = icon
        self.selectedIcon = selectedIcon
        self.label = label
    }
}

// MARK: - NavigationBar

/// A Material Design 3 **Navigation Bar** — bottom navigation for 3–5 primary destinations.
///
/// Equivalent to `NavigationBar` + `NavigationBarItem` in Jetpack Compose.
///
/// ```swift
/// @State private var selectedIndex = 0
/// NavigationBar(
///     items: [
///         NavigationBarItem(icon: Image(systemName: "house"), selectedIcon: Image(systemName: "house.fill"), label: "Home"),
///         NavigationBarItem(icon: Image(systemName: "magnifyingglass"), label: "Search"),
///     ],
///     selectedIndex: $selectedIndex
/// )
/// ```
@available(iOS 15, macOS 12.0, *)
public struct NavigationBar: View {
    @Environment(\.materialTheme) private var theme

    public var items: [NavigationBarItem]
    @Binding public var selectedIndex: Int

    public init(items: [NavigationBarItem], selectedIndex: Binding<Int>) {
        self.items = items
        self._selectedIndex = selectedIndex
    }

    public var body: some View {
        HStack(spacing: 0) {
            ForEach(items.indices, id: \.self) { index in
                let item = items[index]
                let isSelected = selectedIndex == index

                Button(action: { selectedIndex = index }) {
                    VStack(spacing: 4) {
                        ZStack {
                            // Active indicator pill
                            if isSelected {
                                RoundedRectangle(cornerRadius: theme.shapes.full, style: .continuous)
                                    .fill(theme.colorScheme.secondaryContainer)
                                    .frame(width: 64, height: 32)
                            }

                            // Icon
                            (isSelected ? (item.selectedIcon ?? item.icon) : item.icon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundColor(
                                    isSelected
                                        ? theme.colorScheme.onSecondaryContainer
                                        : theme.colorScheme.onSurfaceVariant
                                )
                        }

                        // Label
                        Text(item.label)
                            .font(theme.typography.labelMedium.font)
                            .foregroundColor(
                                isSelected
                                    ? theme.colorScheme.onSurface
                                    : theme.colorScheme.onSurfaceVariant
                            )
                            .fontWeight(isSelected ? .medium : .regular)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                }
                .buttonStyle(.plain)
            }
        }
        .background(theme.colorScheme.surface)
        .overlay(alignment: .top) {
            Divider()
                .background(theme.colorScheme.outlineVariant)
        }
    }
}

@available(iOS 15, macOS 12.0, *)
struct NavigationBar_Previews: PreviewProvider {
    struct PreviewContainer: View {
        @State private var selected = 0
        let items = [
            NavigationBarItem(icon: Image(systemName: "house"), selectedIcon: Image(systemName: "house.fill"), label: "Home"),
            NavigationBarItem(icon: Image(systemName: "magnifyingglass"), label: "Search"),
            NavigationBarItem(icon: Image(systemName: "heart"), selectedIcon: Image(systemName: "heart.fill"), label: "Favorites"),
            NavigationBarItem(icon: Image(systemName: "person"), selectedIcon: Image(systemName: "person.fill"), label: "Profile"),
        ]

        var body: some View {
            NavigationBar(items: items, selectedIndex: $selected)
                .materialTheme(.light)
        }
    }

    static var previews: some View {
        PreviewContainer()
            .previewDisplayName("NavigationBar — Light")
            .previewLayout(.sizeThatFits)
    }
}
