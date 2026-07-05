//
//  File.swift
//  
//
//  Created by Kristhian De Oliveira on 2/19/23.
//

import SwiftUI

/// A Material Design elevated card: a rounded, shadowed surface that adapts
/// to light/dark mode, containing arbitrary content.
@available(iOS 18, macOS 15.0, *)
public struct Card <BodyContent> : View where  BodyContent: View {
    /// The card's fixed width.
    public var width:CGFloat
    /// The card's fixed height.
    public var height:CGFloat
    /// The card's content.
    @ViewBuilder public var bodyContent: () -> BodyContent

    /// Creates a card of a fixed size.
    /// - Parameters:
    ///   - width: The card's width.
    ///   - height: The card's height.
    ///   - bodyContent: The card's content.
    public init(width: CGFloat, height: CGFloat, @ViewBuilder bodyContent: @escaping () -> BodyContent) {
        self.bodyContent = bodyContent
        self.width = width
        self.height = height
    }
    public var body: some View {
        ZStack {
            // Previously hardcoded `.fill(.white)`, which produced a bright
            // white card even in dark mode. `.mattiSurface` adapts per
            // platform and color scheme.
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.mattiSurface)
                .shadow(radius: 10)
            VStack {
                bodyContent()
            }
            .cornerRadius(25)
        }.frame(width: width, height: height)
    }
}
