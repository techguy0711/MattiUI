//
//  TopAppBar.swift
//  MattiUI
//
//  Material Design 3 — Top App Bar variants
//  Reference: https://m3.material.io/components/top-app-bar/specs

import SwiftUI

// MARK: - TopAppBar (Small / Default)

/// A Material Design 3 **Top App Bar** (small, 64 pt tall).
///
/// Equivalent to `TopAppBar` / `SmallTopAppBar` in Jetpack Compose.
///
/// ```swift
/// TopAppBar(title: "Inbox")
/// TopAppBar(title: "Settings", navigationIcon: Image(systemName: "chevron.left")) { /* back */ }
/// ```
@available(iOS 15, macOS 12.0, *)
public struct TopAppBar: View {
    @Environment(\.materialTheme) private var theme

    public var title: String
    public var navigationIcon: Image?
    public var navigationAction: (() -> Void)?
    public var actions: [TopAppBarAction]

    public init(
        title: String,
        navigationIcon: Image? = nil,
        navigationAction: (() -> Void)? = nil,
        actions: [TopAppBarAction] = []
    ) {
        self.title = title
        self.navigationIcon = navigationIcon
        self.navigationAction = navigationAction
        self.actions = actions
    }

    public var body: some View {
        HStack(spacing: 4) {
            if let navIcon = navigationIcon {
                Button(action: { navigationAction?() }) {
                    navIcon
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(theme.colorScheme.onSurface)
                        .padding(8)
                }
            }

            Text(title)
                .font(theme.typography.titleLarge.font)
                .foregroundColor(theme.colorScheme.onSurface)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, navigationIcon == nil ? 16 : 4)

            ForEach(actions.indices, id: \.self) { i in
                Button(action: actions[i].action) {
                    actions[i].icon
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(theme.colorScheme.onSurfaceVariant)
                        .padding(8)
                }
            }
        }
        .frame(height: 64)
        .padding(.horizontal, 4)
        .background(theme.colorScheme.surface)
    }
}

// MARK: - CenterAlignedTopAppBar

/// A Material Design 3 **Center-Aligned Top App Bar** — title centered.
///
/// Equivalent to `CenterAlignedTopAppBar` in Jetpack Compose.
@available(iOS 15, macOS 12.0, *)
public struct CenterAlignedTopAppBar: View {
    @Environment(\.materialTheme) private var theme

    public var title: String
    public var navigationIcon: Image?
    public var navigationAction: (() -> Void)?
    public var actions: [TopAppBarAction]

    public init(
        title: String,
        navigationIcon: Image? = nil,
        navigationAction: (() -> Void)? = nil,
        actions: [TopAppBarAction] = []
    ) {
        self.title = title
        self.navigationIcon = navigationIcon
        self.navigationAction = navigationAction
        self.actions = actions
    }

    public var body: some View {
        ZStack {
            Text(title)
                .font(theme.typography.titleLarge.font)
                .foregroundColor(theme.colorScheme.onSurface)

            HStack {
                if let navIcon = navigationIcon {
                    Button(action: { navigationAction?() }) {
                        navIcon
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(theme.colorScheme.onSurface)
                            .padding(8)
                    }
                }
                Spacer()
                ForEach(actions.indices, id: \.self) { i in
                    Button(action: actions[i].action) {
                        actions[i].icon
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(theme.colorScheme.onSurfaceVariant)
                            .padding(8)
                    }
                }
            }
            .padding(.horizontal, 4)
        }
        .frame(height: 64)
        .background(theme.colorScheme.surface)
    }
}

// MARK: - MediumTopAppBar

/// A Material Design 3 **Medium Top App Bar** (112 pt tall) — title in a second row, larger.
///
/// Equivalent to `MediumTopAppBar` in Jetpack Compose.
@available(iOS 15, macOS 12.0, *)
public struct MediumTopAppBar: View {
    @Environment(\.materialTheme) private var theme

    public var title: String
    public var navigationIcon: Image?
    public var navigationAction: (() -> Void)?
    public var actions: [TopAppBarAction]

    public init(
        title: String,
        navigationIcon: Image? = nil,
        navigationAction: (() -> Void)? = nil,
        actions: [TopAppBarAction] = []
    ) {
        self.title = title
        self.navigationIcon = navigationIcon
        self.navigationAction = navigationAction
        self.actions = actions
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 4) {
                if let navIcon = navigationIcon {
                    Button(action: { navigationAction?() }) {
                        navIcon
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(theme.colorScheme.onSurface)
                            .padding(8)
                    }
                }
                Spacer()
                ForEach(actions.indices, id: \.self) { i in
                    Button(action: actions[i].action) {
                        actions[i].icon
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(theme.colorScheme.onSurfaceVariant)
                            .padding(8)
                    }
                }
            }
            .frame(height: 64)
            .padding(.horizontal, 4)

            Text(title)
                .font(theme.typography.headlineSmall.font)
                .foregroundColor(theme.colorScheme.onSurface)
                .padding(.horizontal, 16)
                .padding(.bottom, 24)
        }
        .background(theme.colorScheme.surface)
    }
}

// MARK: - LargeTopAppBar

/// A Material Design 3 **Large Top App Bar** (152 pt tall) — prominent headline title.
///
/// Equivalent to `LargeTopAppBar` in Jetpack Compose.
@available(iOS 15, macOS 12.0, *)
public struct LargeTopAppBar: View {
    @Environment(\.materialTheme) private var theme

    public var title: String
    public var navigationIcon: Image?
    public var navigationAction: (() -> Void)?
    public var actions: [TopAppBarAction]

    public init(
        title: String,
        navigationIcon: Image? = nil,
        navigationAction: (() -> Void)? = nil,
        actions: [TopAppBarAction] = []
    ) {
        self.title = title
        self.navigationIcon = navigationIcon
        self.navigationAction = navigationAction
        self.actions = actions
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 4) {
                if let navIcon = navigationIcon {
                    Button(action: { navigationAction?() }) {
                        navIcon
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(theme.colorScheme.onSurface)
                            .padding(8)
                    }
                }
                Spacer()
                ForEach(actions.indices, id: \.self) { i in
                    Button(action: actions[i].action) {
                        actions[i].icon
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(theme.colorScheme.onSurfaceVariant)
                            .padding(8)
                    }
                }
            }
            .frame(height: 64)
            .padding(.horizontal, 4)

            Text(title)
                .font(theme.typography.headlineMedium.font)
                .foregroundColor(theme.colorScheme.onSurface)
                .padding(.horizontal, 16)
                .padding(.bottom, 28)
        }
        .background(theme.colorScheme.surface)
    }
}

// MARK: - TopAppBarAction

/// An action button placed in the top app bar's trailing area.
@available(iOS 15, macOS 12.0, *)
public struct TopAppBarAction {
    public var icon: Image
    public var action: () -> Void

    public init(icon: Image, action: @escaping () -> Void) {
        self.icon = icon
        self.action = action
    }
}

// MARK: - Previews

@available(iOS 15, macOS 12.0, *)
struct TopAppBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 2) {
            TopAppBar(
                title: "Top App Bar",
                navigationIcon: Image(systemName: "chevron.left"),
                actions: [
                    TopAppBarAction(icon: Image(systemName: "heart"), action: {}),
                    TopAppBarAction(icon: Image(systemName: "ellipsis.circle"), action: {})
                ]
            )

            CenterAlignedTopAppBar(
                title: "Centered",
                navigationIcon: Image(systemName: "chevron.left"),
                actions: [TopAppBarAction(icon: Image(systemName: "ellipsis.circle"), action: {})]
            )

            MediumTopAppBar(title: "Medium App Bar",
                            navigationIcon: Image(systemName: "chevron.left"),
                            actions: [TopAppBarAction(icon: Image(systemName: "magnifyingglass"), action: {})])

            LargeTopAppBar(title: "Large App Bar",
                           navigationIcon: Image(systemName: "chevron.left"))
        }
        .materialTheme(.light)
        .previewDisplayName("TopAppBar variants — Light")
    }
}
