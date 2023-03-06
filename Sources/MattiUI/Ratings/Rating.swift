//
//  File.swift
//  
//
//  Created by Kristhian De Oliveira on 3/5/23.
//

import SwiftUI

@available(iOS 15, macOS 12.0, *)
public struct Rating: View {
    @State public var values:Int = 0
    @State public var starsSelected: (_: Int) -> Void
    public init(values: Int, starsSelected: @escaping (_: Int) -> Void) {
        self.values = values
        self.starsSelected = starsSelected
    }
    public var body: some View {
        HStack {
            Image(systemName: values >= 1 ? "star.fill" : "star")
                .foregroundColor(.yellow)
                .onTapGesture {
                    values = 1
                    starsSelected(values)
                }
            Image(systemName: values >= 2 ? "star.fill" : "star")
                .foregroundColor(.yellow)
                .onTapGesture {
                    values = 2
                    starsSelected(values)
                }
            Image(systemName: values >= 3 ? "star.fill" : "star")
                .foregroundColor(.yellow)
                .onTapGesture {
                    values = 3
                    starsSelected(values)
                }
            Image(systemName: values >= 4 ? "star.fill" : "star")
                .foregroundColor(.yellow)
                .onTapGesture {
                    values = 4
                    starsSelected(values)
                }
            Image(systemName: values >= 5 ? "star.fill" : "star")
                .foregroundColor(.yellow)
                .onTapGesture {
                    values = 5
                    starsSelected(values)
                }
        }
    }
}
