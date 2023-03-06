//
//  ContentView.swift
//  swiftui material components proto
//
//  Created by Kristhian De Oliveira on 2/1/23.
//

import SwiftUI
import MattiUI

struct ContentView: View {
    var body: some View {
        ContainerWithFloatingButton(buttonContent: {Text("Help")}, backgroundColor: .black, bodyContent: {
            VStack {
                Card(width: 300, height: 200) {
                    Rating(values: 4, starsSelected: { stars in
                        print("\(stars) stars")
                        
                    })
                }
                Card(width: 300, height: 200) {
                    MaterialDateTimePicker(month: 2, year: 2023, DaysSelected: [], onDateChange: {days in
                        print("days: \(days)")
                    }).padding()
                }
                Card(width: 200, height: 100, bodyContent: {
                    HStack {
                        Text("Face ID")
                        MaterialToggle(color: .green, isOn: true, didChange: {value in })
                    }
                })
                .padding()
                MaterialButton(tittle: "Cancel", shape: .rounded, style: .outline, action: {
                    
                }, backgroundColor: .red, textColor: .red, icon: {})
                MaterialButton(tittle: "Done", shape: .rounded, style: .fill, action: {
                    
                }, backgroundColor: .green, textColor: .white, icon: {})
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
