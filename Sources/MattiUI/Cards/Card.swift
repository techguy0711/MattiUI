//
//  File.swift
//  
//
//  Created by Kristhian De Oliveira on 2/19/23.
//

import SwiftUI

@available(iOS 15, macOS 12.0, *)
public struct Card <BodyContent> : View where  BodyContent: View {
    public var width:CGFloat
    public var height:CGFloat
    @ViewBuilder public var bodyContent: () -> BodyContent
    
    public init(width: CGFloat, height: CGFloat, @ViewBuilder bodyContent: @escaping () -> BodyContent) {
        self.bodyContent = bodyContent
        self.width = width
        self.height = height
    }
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(.white)
                .shadow(radius: 10)
            VStack {
                bodyContent()
            }
            .cornerRadius(25)
        }.frame(width: width, height: height)
    }
}
