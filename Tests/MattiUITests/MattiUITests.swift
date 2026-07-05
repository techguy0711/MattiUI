import XCTest
@testable import MattiUI

/// These tests target the calendar-math bugs found and fixed in
/// `MaterialDateTimePicker`: the original implementation force-unwrapped
/// date math (crashing on invalid input) and hardcoded which weekday column
/// each day landed in (wrong for most months). `totalDaysInMonth`,
/// `leadingBlankDays`, and `isBetween` were changed from `private` to
/// internal specifically so they're reachable here via `@testable import`.
final class MaterialDateTimePickerTests: XCTestCase {

    func testDaysInMonth_january_hasThirtyOneDays() {
        let picker = MaterialDateTimePicker(month: 1, year: 2023) { _ in }
        XCTAssertEqual(picker.totalDaysInMonth, 31)
    }

    func testDaysInMonth_february_nonLeapYear_hasTwentyEightDays() {
        let picker = MaterialDateTimePicker(month: 2, year: 2023) { _ in }
        XCTAssertEqual(picker.totalDaysInMonth, 28)
    }

    func testDaysInMonth_february_leapYear_hasTwentyNineDays() {
        let picker = MaterialDateTimePicker(month: 2, year: 2024) { _ in }
        XCTAssertEqual(picker.totalDaysInMonth, 29)
    }

    func testDaysInMonth_invalidMonth_returnsZeroInsteadOfCrashing() {
        // Previously this force-unwrapped date math and would crash.
        let picker = MaterialDateTimePicker(month: 13, year: 2023) { _ in }
        XCTAssertEqual(picker.totalDaysInMonth, 0)
    }

    func testLeadingBlankDays_january2023_startsOnSunday() {
        // January 1, 2023 was a Sunday, the first weekday column, so there
        // should be no leading blank cells.
        let picker = MaterialDateTimePicker(month: 1, year: 2023) { _ in }
        XCTAssertEqual(picker.leadingBlankDays, 0)
    }

    func testLeadingBlankDays_february2023_startsOnWednesday() {
        // February 1, 2023 was a Wednesday (4th weekday column, 1-indexed
        // from Sunday), so 3 leading blank cells are needed. This is exactly
        // the case the old hardcoded 5-row layout got wrong.
        let picker = MaterialDateTimePicker(month: 2, year: 2023) { _ in }
        XCTAssertEqual(picker.leadingBlankDays, 3)
    }

    func testIsBetween_dayStrictlyInsideRange_isTrue() {
        let picker = MaterialDateTimePicker(month: 1, year: 2023) { _ in }
        XCTAssertTrue(picker.isBetween(day: 5, min: 3, max: 8))
    }

    func testIsBetween_dayEqualToEndpoints_isFalse() {
        let picker = MaterialDateTimePicker(month: 1, year: 2023) { _ in }
        XCTAssertFalse(picker.isBetween(day: 3, min: 3, max: 8))
        XCTAssertFalse(picker.isBetween(day: 8, min: 3, max: 8))
    }

    func testIsBetween_handlesReversedRange() {
        // Users can drag-select backward; min/max should self-correct.
        let picker = MaterialDateTimePicker(month: 1, year: 2023) { _ in }
        XCTAssertTrue(picker.isBetween(day: 5, min: 8, max: 3))
    }

    func testIsBetween_missingEndpoint_isFalse() {
        let picker = MaterialDateTimePicker(month: 1, year: 2023) { _ in }
        XCTAssertFalse(picker.isBetween(day: 5, min: nil, max: 8))
        XCTAssertFalse(picker.isBetween(day: 5, min: 3, max: nil))
    }

    func testIsBetween_equalEndpoints_isFalse() {
        let picker = MaterialDateTimePicker(month: 1, year: 2023) { _ in }
        XCTAssertFalse(picker.isBetween(day: 5, min: 5, max: 5))
    }
}
