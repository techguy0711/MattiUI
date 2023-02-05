//
//  MaterialToggle.swift
//  swiftui material components proto
//
//  Created by Kristhian De Oliveira on 2/2/23.
//

import SwiftUI

//TODO: Add animation for slider switch
@available(iOS 15, macOS 12.0, *)
public struct MaterialToggle: View {
    public var color:Color = .blue
    @State var isOn:Bool = false
    public var didChange: (_: Bool) -> Void
    
    public init(color: Color, isOn: Bool, didChange: @escaping (_: Bool) -> Void) {
        self.color = color
        self.isOn = isOn
        self.didChange = didChange
    }
    
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 500)
                .frame(width: 50, height: 15)
                .foregroundColor(color)
                .opacity(0.6)
            RoundedRectangle(cornerRadius: 500)
                .frame(width: 30, height: 30)
                .foregroundColor(color)
                .padding(isOn == true ? .leading : .trailing)
        }
        .onTapGesture {
            isOn.toggle()
            didChange(isOn)
        }
    }
}
