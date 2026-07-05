//
//  File.swift
//
//
//  Created by Kristhian De Oliveira on 2/25/23.
//

import SwiftUI

/// A single day cell in `MaterialDateTimePicker`.
///
/// Previously this view owned `@State public var isSelected` and
/// `@State public var didSelect` (a closure stored in `@State`, which isn't
/// what `@State` is for). Because the view had no stable identity tied to
/// its `day`, SwiftUI could reuse/re-initialize these incorrectly across
/// re-renders, and the "selected" flag could drift out of sync with the
/// parent's actual `daysSelected` array. Making this a plain, stateless view
/// driven entirely by parameters from the parent (the single source of
/// truth) fixes that class of bug.
@available(iOS 18, macOS 15.0, *)
private struct RoundLabel: View {
    let day: Int
    let isSelected: Bool
    let isPassingBy: Bool
    let enableTouch: Bool
    let onToggle: (_ isSelected: Bool) -> Void

    private var fillColor: Color {
        if isPassingBy { return .blue.opacity(0.3) }
        return isSelected ? .accentColor : Color.gray.opacity(0.15)
    }

    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(fillColor)
            Text("\(day)")
                .foregroundColor(isSelected ? .white : .primary)
        }
        .frame(width: 32, height: 32)
        .contentShape(Circle())
        .onTapGesture {
            guard enableTouch else { return }
            onToggle(!isSelected)
        }
        .accessibilityLabel("Day \(day)")
        .accessibilityAddTraits(isSelected ? [.isButton, .isSelected] : [.isButton])
    }
}

/// A calendar grid for selecting a date range within a single month.
///
/// Tap a day to start a range, tap a second day to complete it — `onDateChange`
/// fires with both days (sorted) once exactly two are selected. Tapping either
/// selected day again clears it.
///
/// ```swift
/// MaterialDateTimePicker(month: 7, year: 2026) { days in print(days) }
/// ```
@available(iOS 18, macOS 15.0, *)
public struct MaterialDateTimePicker: View {
    /// 1-indexed month (1 = January).
    public var month: Int
    /// Four-digit year.
    public var year: Int
    @State private var daysSelected: [Int]
    /// Called with the sorted `[start, end]` days once a two-day range is selected.
    public var onDateChange: (_ daysSelected: [Int]) -> Void

    private let columns = Array(repeating: GridItem(.flexible()), count: 7)

    /// Creates a date range picker for the given month.
    /// - Parameters:
    ///   - month: 1-indexed month (1 = January).
    ///   - year: Four-digit year.
    ///   - daysSelected: Initial selection. Defaults to none.
    ///   - onDateChange: Called with the sorted selected range once two days are picked.
    public init(month: Int, year: Int, daysSelected: [Int] = [], onDateChange: @escaping (_ daysSelected: [Int]) -> Void) {
        self.month = month
        self.year = year
        self._daysSelected = State(initialValue: daysSelected)
        self.onDateChange = onDateChange
    }

    /// True for days strictly between the first and last selected day
    /// (exclusive), used to highlight the range being spanned.
    /// Internal (not private) so it's covered directly by unit tests via
    /// `@testable import` — this doesn't change the public API since
    /// `internal` is still invisible to consumers of the library.
    func isBetween(day: Int, min: Int?, max: Int?) -> Bool {
        guard let a = min, let b = max, a != b else { return false }
        let lower = Swift.min(a, b)
        let upper = Swift.max(a, b)
        return day > lower && day < upper
    }

    public var body: some View {
        // Previously the calendar was laid out as 5 fixed GridRows, each
        // showing a hardcoded slice of day numbers (0...4, 5...11, 12...18...).
        // That assumes every month starts on the same weekday, so days never
        // lined up under the correct weekday column for most months. A
        // LazyVGrid with 7 columns, padded at the front with blank cells equal
        // to the month's starting weekday offset, lays days out correctly for
        // any month/year.
        LazyVGrid(columns: columns, spacing: 8) {
            ForEach(0..<leadingBlankDays, id: \.self) { index in
                Color.clear
                    .frame(height: 32)
                    .accessibilityHidden(true)
                    .id("blank-\(index)")
            }
            ForEach(1...max(totalDaysInMonth, 1), id: \.self) { day in
                RoundLabel(
                    day: day,
                    isSelected: daysSelected.contains(day),
                    isPassingBy: isBetween(day: day, min: daysSelected.first, max: daysSelected.last),
                    enableTouch: daysSelected.count < 2 || daysSelected.contains(day)
                ) { isSelected in
                    if isSelected {
                        daysSelected.append(day)
                    } else {
                        daysSelected.removeAll { $0 == day }
                    }
                    if daysSelected.count == 2 {
                        onDateChange(daysSelected.sorted())
                    }
                }
            }
        }
    }

    /// Number of days in `month`/`year`. Previously this force-unwrapped both
    /// `Date.startOfMonth(...)` and `Calendar.dateInterval(...)`, which would
    /// crash on an invalid month (e.g. `month: 13`). Now returns `0` instead
    /// of crashing. Internal (not private) for unit test coverage.
    var totalDaysInMonth: Int {
        guard let date = Date.startOfMonth(for: month, of: year),
              let range = Calendar.current.range(of: .day, in: .month, for: date) else {
            return 0
        }
        return range.count
    }

    /// Number of empty leading cells needed so day 1 lands under the correct
    /// weekday column (`Calendar.component(.weekday:)` is 1 = Sunday...7 =
    /// Saturday, so subtracting 1 gives a 0-based offset). Internal (not
    /// private) for unit test coverage.
    var leadingBlankDays: Int {
        guard let date = Date.startOfMonth(for: month, of: year) else { return 0 }
        return Calendar.current.component(.weekday, from: date) - 1
    }
}

extension Date {
    static func startOfMonth(for month: Int, of year: Int, using calendar: Calendar = .current) -> Date? {
        guard (1...12).contains(month) else { return nil }
        return DateComponents(calendar: calendar, year: year, month: month).date
    }
}
