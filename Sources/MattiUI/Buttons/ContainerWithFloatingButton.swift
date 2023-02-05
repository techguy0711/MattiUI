//
//  FloatingButton.swift
//  swiftui material components proto
//
//  Created by Kristhian De Oliveira on 2/2/23.
//

import SwiftUI

@available(iOS 15, macOS 12.0, *)
public struct ContainerWithFloatingButton: View {
    public var buttonContent:AnyView
    public var backgroundColor:Color = .black
    public var bodyContent: AnyView
    public var action: () -> Void
    
    public var body: some View {
        ZStack {
            bodyContent
            Button(action: action, label: {
                buttonContent
                    .padding()
            })
            .background(backgroundColor)
            .cornerRadius(25)
            .padding(.top, 700)
            .padding(.leading, 250)
        }
    }
}
