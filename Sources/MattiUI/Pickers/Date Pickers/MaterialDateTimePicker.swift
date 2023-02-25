//
//  File.swift
//  
//
//  Created by Kristhian De Oliveira on 2/25/23.
//

import SwiftUI

@available(iOS 15, macOS 13.0, *)
struct RoundLabel: View {
    @State public var isSelected = false
    @State public var didSelect: (_ state: Bool) -> Void
    var daysSelected: [Int]
    var isPassingBy: Bool
    var enableTouch: Bool
    var label:String
    private func shapeStyle() -> Color {
        if isPassingBy {
            return .blue.opacity(0.3)
        }
        return isSelected ? .black : .white
    }
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(shapeStyle())
            Text(label)
                .foregroundColor(isSelected ? .white : .black)
        }
        .frame(width: 30, height: 30)
        .onTapGesture {
            if daysSelected.count > 1 {
                isSelected = false
            } else {
                isSelected.toggle()
            }
            didSelect(isSelected && enableTouch)
        }
    }
}

@available(iOS 15, macOS 32.0, *)
struct MaterialDateTimePicker: View {
    var month: Int, year: Int
    @State private var DaysSelected: [Int] = []
    @State public var onDateChange: (_ daysSelected: [Int]) -> Void
    func isBetween(day: Int?, min:Int?, max:Int?) -> Bool{
        guard var min = min else { return false }
        guard var max = max else { return false }
        guard let day = day else { return false }
        
        //If user selects dates backward range reverse it to correc sequence
        if min > max {
            let tempMax = max
            max = min
            min = tempMax
        }
        
        let range = min...max
        for value in range {
            if day == value {
                if day != min {
                    if day != max {
                        return true
                    }
                }
            }
        }
        return false
    }
    private func cell(day: Int) -> any View {
        RoundLabel(didSelect: { state in
            if state == true {
                DaysSelected.append(day)
            } else {
                DaysSelected.removeAll { selectedDay in
                    selectedDay == day
                }
            }
            //Only call onDateChange when range is complete
            if DaysSelected.count == 2 {
                onDateChange(DaysSelected.map({ DayIn in
                    return DayIn + 1
                }).sorted())
            }
        }, daysSelected: DaysSelected, isPassingBy: isBetween(day: day, min: DaysSelected.first, max: DaysSelected.last), enableTouch: DaysSelected.count <= 2, label: "\(day + 1)")
    }
    var body: some View {
        ScrollView {
            Grid {
                GridRow {
                    ForEach(0..<daysIn(month: month, year: year), id: \.self) { day in
                        if 0...4 ~= day {
                            AnyView(cell(day: day))
                        }
                    }
                }
                GridRow {
                    ForEach(0..<daysIn(month: month, year: year), id: \.self) { day in
                        if 5...11 ~= day {
                            AnyView(cell(day: day))
                        }
                    }
                }
                GridRow {
                    ForEach(0..<daysIn(month: month, year: year), id: \.self) { day in
                        if 12...18 ~= day {
                            AnyView(cell(day: day))
                        }
                    }
                }
                GridRow {
                    ForEach(0..<daysIn(month: month, year: year), id: \.self) { day in
                        if 19...25 ~= day {
                            AnyView(cell(day: day))
                        }
                    }
                }
                GridRow {
                    ForEach(0..<daysIn(month: month, year: year), id: \.self) { day in
                        if 26...31 ~= day {
                            AnyView(cell(day: day))
                        }
                    }
                }
            }
        }
    }
    private func daysIn(month: Int, year: Int) -> Int {
        let date = Date.startOfMonth(for: month, of: year)
        let calendar = Calendar.current
        
        // Calculate start and end of the current year (or month with `.month`):
        let interval = calendar.dateInterval(of: .month, for: date!)! //change year it will no of days in a year , change it to month it will give no of days in a current month
        
        // Compute difference in days:
        let days = calendar.dateComponents([.day], from: interval.start, to: interval.end).day!
        return days
    }
}

extension Date {
    static func startOfMonth(for month: Int, of year: Int, using calendar: Calendar = .current) -> Date? {
        DateComponents(calendar: calendar, year: year, month: month).date
    }
}

