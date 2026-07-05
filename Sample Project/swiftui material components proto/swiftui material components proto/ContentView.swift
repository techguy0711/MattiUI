//
//  ContentView.swift
//  swiftui material components proto
//
//  Created by Kristhian De Oliveira on 2/1/23.
//

import SwiftUI
import MattiUI

struct ContentView: View {
    // Rating and MaterialToggle take a `Binding` instead of a one-shot
    // initial value, so the demo needs real @State to bind to.
    @State private var rating = 4
    @State private var isFaceIDOn = true
    @State private var name = ""
    @State private var isVegOnly = false
    @State private var isSpicy = true
    @State private var showDeleteDialog = false
    @State private var showSnackbar = false

    var body: some View {
        VStack(spacing: 0) {
            MaterialTopAppBar(title: "MattiUI Demo", trailing: {
                Image(systemName: "bell")
                    .overlay(alignment: .topTrailing) {
                        MaterialBadge(count: 3)
                            .offset(x: 8, y: -6)
                    }
            })

            ContainerWithFloatingButton(buttonContent: { Text("Help")
            }, backgroundColor: .black, bodyContent: {
                ScrollView {
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

                        MaterialTextField(label: "Name", text: $name)
                            .padding(.horizontal)

                        HStack {
                            MaterialChip(label: "Vegetarian", isSelected: isVegOnly, onTap: {
                                isVegOnly.toggle()
                            })
                            MaterialChip(label: "Spicy", isSelected: isSpicy, style: .outlined, color: .orange, onTap: {
                                isSpicy.toggle()
                            })
                        }
                        .padding(.horizontal)

                        MaterialButton(title: "Cancel", shape: .rounded, style: .outline, backgroundColor: .red, textColor: .red, action: {

                        })
                        MaterialButton(title: "Done", shape: .rounded, style: .fill, backgroundColor: .green, textColor: .white, action: {

                        })
                        MaterialButton(title: "Delete Item", style: .fill, backgroundColor: .red, textColor: .white, action: {
                            showDeleteDialog = true
                        })
                        MaterialButton(title: "Show Snackbar", style: .outline, backgroundColor: .blue, textColor: .blue, action: {
                            showSnackbar = true
                        })
                    }
                    .padding()
                }
            }) {

            }
        }
        .materialDialog(isPresented: $showDeleteDialog, title: "Delete item?", message: "This can't be undone.") {
            MaterialButton(title: "Cancel", style: .outline, backgroundColor: .gray, textColor: .gray, action: {
                showDeleteDialog = false
            })
            MaterialButton(title: "Delete", style: .fill, backgroundColor: .red, textColor: .white, action: {
                showDeleteDialog = false
            })
        }
        .materialSnackbar(isPresented: $showSnackbar, message: "Item saved", actionTitle: "Undo", onAction: {
            print("undo tapped")
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
