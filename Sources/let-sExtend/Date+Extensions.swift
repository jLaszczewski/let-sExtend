//
//  Date+Extensions.swift
//  
//
//  Created by Jakub Łaszczewski on 11/12/2020.
//

import Foundation

public extension Date {
  
  func isToday() -> Bool {
    return isSameDay(with: Date())
  }
  
  func isSameDay(
    with date: Date
  ) -> Bool {
    let dateWihoutStamp = withoutTimeStamp()
    let otherDateWithoutStamp = date.withoutTimeStamp()
    
    return dateWihoutStamp == otherDateWithoutStamp
  }
  
  func startOfMonth(
    calendar: Calendar = .current
  ) -> Date {
    let components = calendar.dateComponents(
      [.year, .month],
      from: self)
    
    return Date(timeIntervalSince1970: calendar.date(from: components)!.timeIntervalSince1970)
  }
  
  func endOfMonth(
    calendar: Calendar = Calendar.current
  ) -> Date {
    self
      .byAdding(1, .month, calendar: calendar)
      .byAdding(-1, .second, calendar: calendar)
  }
  
  func startOfWeek(
    calendar: Calendar = Calendar.current
  ) -> Date {
    var components = calendar.dateComponents(
      [.year, .weekOfYear, .month, .weekday],
      from: self)
    components.weekday = 2
    
    return calendar.date(from: components)!
  }
  
  func daysRange(
    till tillDate: Date,
    calendar: Calendar = Calendar.current
  ) -> [Date] {
    let sinceDate = self.withoutTimeStamp(calendar: calendar)
    let tillDate = tillDate.withoutTimeStamp(calendar: calendar)
    
    return sinceDate.daysRange(
      till: tillDate,
      collectedDates: [],
      calendar: calendar)
  }
  
  func withoutTimeStamp(calendar: Calendar = .current) -> Date {
    guard
      let date = Calendar.current.date(
        from: dateComponents(
          for: .withoutTime,
          calendar: calendar))
    else {
      fatalError("Failed to strip time from Date object")
    }
    return date
  }
  
  func byAdding(
    _ value: Int,
    _ component: Calendar.Component,
    calendar: Calendar = .current
  ) -> Date {
    calendar.date(
      byAdding: component,
      value: value,
      to: self)!
  }
}

// MARK: - private
private extension Date {
  
  func daysRange(
    till tillDate: Date,
    collectedDates: [Date],
    calendar: Calendar
  ) -> [Date] {
    guard self <= tillDate else { return collectedDates }
    return calendar.date(byAdding: .day, value: 1, to: self)!
      .daysRange(
        till: tillDate,
        collectedDates: collectedDates + [self],
        calendar: calendar)
  }
}
