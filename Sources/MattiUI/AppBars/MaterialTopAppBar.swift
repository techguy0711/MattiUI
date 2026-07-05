//
//  MaterialTopAppBar.swift
//
//
//  A Material Design top app bar with optional leading/trailing actions.
//

import SwiftUI

/// A Material Design top app bar: a fixed-height header with a title and
/// optional leading/trailing action slots.
///
/// ```swift
/// MaterialTopAppBar(title: "Settings")
///
/// MaterialTopAppBar(title: "Settings") {
///     Button(action: back) { Image(systemName: "chevron.left") }
/// } trailing: {
///     Button(action: share) { Image(systemName: "square.and.arrow.up") }
/// }
/// ```
///
/// This is a plain view, not a `NavigationView` replacement — place it at the
/// top of your own layout (e.g. in a `VStack`) rather than inside a
/// `NavigationView`'s toolbar.
@available(iOS 18, macOS 15.0, *)
public struct MaterialTopAppBar<Leading: View, Trailing: View>: View {
    /// The bar's title text.
    public var title: String
    /// The bar's fill color. Defaults to `.accentColor`.
    public var backgroundColor: Color
    /// The title/action tint color. Defaults to `.white`.
    public var foregroundColor: Color
    /// Leading slot, typically a back button.
    @ViewBuilder public var leading: () -> Leading
    /// Trailing slot, typically one or more actions.
    @ViewBuilder public var trailing: () -> Trailing

    /// Creates a top app bar with both leading and trailing slots.
    /// - Parameters:
    ///   - title: The bar's title text.
    ///   - backgroundColor: The bar's fill color. Defaults to `.accentColor`.
    ///   - foregroundColor: The title/action tint color. Defaults to `.white`.
    ///   - leading: Leading slot, typically a back button.
    ///   - trailing: Trailing slot, typically one or more actions.
    public init(
        title: String,
        backgroundColor: Color = .accentColor,
        foregroundColor: Color = .white,
        @ViewBuilder leading: @escaping () -> Leading,
        @ViewBuilder trailing: @escaping () -> Trailing
    ) {
        self.title = title
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.leading = leading
        self.trailing = trailing
    }

    public var body: some View {
        HStack(spacing: 12) {
            leading()
            Text(title)
                .font(.headline)
                .lineLimit(1)
                .accessibilityAddTraits(.isHeader)
            Spacer(minLength: 0)
            trailing()
        }
        .padding(.horizontal, 16)
        .frame(height: 56)
        .foregroundColor(foregroundColor)
        .background(backgroundColor)
    }
}

@available(iOS 18, macOS 15.0, *)
public extension MaterialTopAppBar where Leading == EmptyView, Trailing == EmptyView {
    /// Creates a top app bar with just a title, no leading/trailing slots.
    init(title: String, backgroundColor: Color = .accentColor, foregroundColor: Color = .white) {
        self.init(
            title: title,
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            leading: { EmptyView() },
            trailing: { EmptyView() }
        )
    }
}

@available(iOS 18, macOS 15.0, *)
public extension MaterialTopAppBar where Leading == EmptyView {
    /// Creates a top app bar with a trailing slot only.
    init(
        title: String,
        backgroundColor: Color = .accentColor,
        foregroundColor: Color = .white,
        @ViewBuilder trailing: @escaping () -> Trailing
    ) {
        self.init(
            title: title,
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            leading: { EmptyView() },
            trailing: trailing
        )
    }
}

@available(iOS 18, macOS 15.0, *)
public extension MaterialTopAppBar where Trailing == EmptyView {
    /// Creates a top app bar with a leading slot only.
    init(
        title: String,
        backgroundColor: Color = .accentColor,
        foregroundColor: Color = .white,
        @ViewBuilder leading: @escaping () -> Leading
    ) {
        self.init(
            title: title,
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            leading: leading,
            trailing: { EmptyView() }
        )
    }
}
