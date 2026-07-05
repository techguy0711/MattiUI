//
//  ContentView.swift
//  swiftui material components proto
//
//  Created by Kristhian De Oliveira on 2/1/23.
//

import SwiftUI
import MattiUI

struct ContentView: View {
    // Rating and MaterialToggle now take a `Binding` instead of a one-shot
    // initial value, so the demo needs real @State to bind to.
    @State private var rating = 4
    @State private var isFaceIDOn = true

    var body: some View {
        ContainerWithFloatingButton(buttonContent: { Text("Help")
        }, backgroundColor: .black, bodyContent: {
            VStack {
                Card(width: 300, height: 200) {
                    Rating(value: $rating, onChange: { stars in
                        print("\(stars) stars")
                    })
                }
                Card(width: 300, height: 200) {
                    MaterialDateTimePicker(month: 2, year: 2023, daysSelected: [], onDateChange: { days in
                        print("days: \(days)")
                    }).padding()
                }
                Card(width: 200, height: 100, bodyContent: {
                    HStack {
                        Text("Face ID")
                        MaterialToggle(color: .green, isOn: $isFaceIDOn, didChange: { value in })
                    }
                })
                .padding()
                MaterialButton(title: "Cancel", shape: .rounded, style: .outline, backgroundColor: .red, textColor: .red, action: {

                })
                MaterialButton(title: "Done", shape: .rounded, style: .fill, backgroundColor: .green, textColor: .white, action: {

                })
            }
            .padding()
        }) {

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
