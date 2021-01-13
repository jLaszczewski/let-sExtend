//
//  DateExtensionsTests.swift
//  
//
//  Created by Jakub Łaszczewski on 15/12/2020.
//

import XCTest
@testable import let_sExtend

class DateExtensionsTests: XCTestCase {}

extension DateExtensionsTests {
  
  func testStartOfWeek() {
    var calendar = Calendar.current
    calendar.firstWeekday = 2
    
    let mondayComponent = DateComponents(
      calendar: calendar,
      year: 2020,
      month: 1,
      day: 27,
      hour: 0)
    
    let tuesdayComponent = DateComponents(
      calendar: calendar,
      year: 2020,
      month: 1,
      day: 28,
      hour: 0)
    
    let saturdayComponent = DateComponents(
      calendar: calendar,
      year: 2020,
      month: 2,
      day: 2,
      hour: 0)
    
    let sundayComponent = DateComponents(
      calendar: calendar,
      year: 2020,
      month: 2,
      day: 2,
      hour: 0)
    
    let mondayDate = calendar.date(
      from: mondayComponent)!
    
    let tuesdayDate = calendar.date(
      from: tuesdayComponent)!
    
    let saturdayDate = calendar.date(
      from: saturdayComponent)!
    
    let sundayDate = calendar.date(
      from: sundayComponent)!
    
    XCTAssertEqual(
      mondayDate.startOfWeek(calendar: calendar),
      mondayDate)
    XCTAssertEqual(
      tuesdayDate.startOfWeek(calendar: calendar),
      mondayDate)
    XCTAssertEqual(
      saturdayDate.startOfWeek(calendar: calendar),
      mondayDate)
    XCTAssertEqual(
      sundayDate.startOfWeek(calendar: calendar),
      mondayDate)
  }
  
  func testEndOfWeek() {
    var calendar = Calendar.current
    calendar.firstWeekday = 2
    
    let mondayComponent = DateComponents(
      calendar: calendar,
      year: 2020,
      month: 1,
      day: 27,
      hour: 0)
    
    let tuesdayComponent = DateComponents(
      calendar: calendar,
      year: 2020,
      month: 1,
      day: 28,
      hour: 0)
    
    let saturdayComponent = DateComponents(
      calendar: calendar,
      year: 2020,
      month: 2,
      day: 2,
      hour: 0)
    
    let sundayComponent = DateComponents(
      calendar: calendar,
      year: 2020,
      month: 2,
      day: 2,
      hour: 23,
      minute: 59,
      second: 59)
    
    let mondayDate = calendar.date(
      from: mondayComponent)!
    
    let tuesdayDate = calendar.date(
      from: tuesdayComponent)!
    
    let saturdayDate = calendar.date(
      from: saturdayComponent)!
    
    let sundayDate = calendar.date(
      from: sundayComponent)!
    
    XCTAssertEqual(
      mondayDate.endOfWeek(calendar: calendar),
      sundayDate)
    XCTAssertEqual(
      tuesdayDate.endOfWeek(calendar: calendar),
      sundayDate)
    XCTAssertEqual(
      saturdayDate.endOfWeek(calendar: calendar),
      sundayDate)
    XCTAssertEqual(
      sundayDate.endOfWeek(calendar: calendar),
      sundayDate)
  }
}
