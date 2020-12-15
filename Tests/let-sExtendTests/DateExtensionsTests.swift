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
    let calendar = Calendar.current
    
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
      mondayDate.startOfWeek(),
      mondayDate)
    XCTAssertEqual(
      tuesdayDate.startOfWeek(),
      mondayDate)
    XCTAssertEqual(
      saturdayDate.startOfWeek(),
      mondayDate)
    XCTAssertEqual(
      sundayDate.startOfWeek(),
      mondayDate)
  }
}
