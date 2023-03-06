//
//  MaterialSlider.swift
//  swiftui material components proto
//
//  Created by Kristhian De Oliveira on 2/3/23.
//

import SwiftUI

//TODO: Add sticky ends to slider, instead of defaulting to 0 we should stop the slider at -100 and 100. Couldn't figure it out yet. Also the values should return

struct MaterialSlider: View {
    @State private var offset = CGSize.zero
    var color:Color = .blue
    @State var value:CGFloat
    var didChange: (_: CGFloat) -> Void
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 300)
                .frame(width: 200, height: 10)
                .foregroundColor(color)
                .opacity(0.6)
            RoundedRectangle(cornerRadius: 500)
                .frame(width: 30, height: 30)
                .foregroundColor(color)
                .rotationEffect(.degrees(Double(offset.width / 5)))
                .offset(x: offset.width < 100 && offset.width > -100 ? offset.width : offset.width == 100 || offset.width == -100 ? offset.width : 0, y: 0)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            offset = gesture.translation
                            didChange(offset.width)
                        }
                )
        }
        .onAppear {
            offset.width = value
        }
    }
}

struct MaterialSlider_Previews: PreviewProvider {
    static var previews: some View {
        MaterialSlider( value: 0, didChange: {value in })
    }
}
