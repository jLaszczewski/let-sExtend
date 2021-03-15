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
    with date: Date?
  ) -> Bool {
    let dateWihoutStamp = withoutTimeStamp()
    let otherDateWithoutStamp = date?.withoutTimeStamp()
    
    return dateWihoutStamp == otherDateWithoutStamp
  }
  
  func startOfDay(
    calendar: Calendar = .current
  ) -> Date {
    calendar.startOfDay(for: self)
  }
  
  func endOfDay(
    calendar: Calendar = .current
  ) -> Date {
    startOfDay(calendar: calendar)
      .byAdding(1, .day, calendar: calendar)
      .byAdding(-1, .second, calendar: calendar)
  }
  
  func startOfWeek(
    calendar: Calendar = Calendar.current
  ) -> Date {
    var components = calendar.dateComponents(
      [.yearForWeekOfYear, .weekOfYear, .month],
      from: self)
    components.weekday = calendar.firstWeekday
    
    return calendar.date(from: components)!
  }
  
  func endOfWeek(
    calendar: Calendar = Calendar.current
  ) -> Date {
    startOfWeek(calendar: calendar)
      .byAdding(1, .weekOfYear, calendar: calendar)
      .byAdding(-1, .second, calendar: calendar)
  }
  
  func startOfMonth(
    calendar: Calendar = .current
  ) -> Date {
    let components = calendar.dateComponents(
      [.year, .month],
      from: self)
    
    return calendar.date(from: components)!
  }
  
  func endOfMonth(
    calendar: Calendar = Calendar.current
  ) -> Date {
    startOfMonth(calendar: calendar)
      .byAdding(1, .month, calendar: calendar)
      .byAdding(-1, .second, calendar: calendar)
  }
  
  func daysRange(
    to toDate: Date,
    calendar: Calendar = Calendar.current
  ) -> [Date] {
    let fromDate = self.startOfDay(calendar: calendar)
    let toDate = toDate.endOfDay(calendar: calendar)
    let daysCount = days(to: toDate, calendar: calendar)
    
    return (0...daysCount)
      .map { fromDate.byAdding($0, .day, calendar: calendar) }
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
  
  func withNewTimestamp(
    of timestamp: Date = Date(),
    calendar: Calendar = .current
  ) -> Date {
    let hour = calendar.component(.hour, from: timestamp)
    let minute = calendar.component(.minute, from: timestamp)
    let second = calendar.component(.second, from: timestamp)
    
    var components = calendar.dateComponents(
      [.year, .month, .day, .hour, .minute, .second],
      from: self)
          
    components.hour = hour
    components.minute = minute
    components.second = second
    
    return calendar.date(from: components)!
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
  
  func days(to toDate: Date, calendar: Calendar = .current) -> Int {
    calendar
      .dateComponents(
        [.day],
        from: self,
        to: toDate)
      .day!
  }
  
  func weeks(
    to toDate: Date,
    rule: FloatingPointRoundingRule,
    calendar: Calendar = Calendar.current
  ) -> Int {
    let fromDate = startOfDay(calendar: calendar)
    let toDate = toDate.endOfDay(calendar: calendar)
    let daysCount = fromDate.days(to: toDate, calendar: calendar)
    
    return Int((Double(daysCount) / 7).rounded(rule))
  }
  
  func months(to toDate: Date, calendar: Calendar = .current) -> Int {
    calendar
      .dateComponents(
        [.month],
        from: self,
        to: toDate)
      .month!
  }
  
  func years(to toDate: Date, calendar: Calendar = .current) -> Int {
    calendar
      .dateComponents(
        [.year],
        from: self,
        to: toDate)
      .year!
  }
  
  func isDayBetween(
    _ date1: Date,
    and date2: Date,
    calendar: Calendar =  .current
  ) -> Bool {
    let date1 = date1.startOfDay(calendar: calendar)
    let date2 = date2.endOfDay(calendar: calendar)
    
    return (min(date1, date2) ... max(date1, date2)).contains(self)
  }
}

public extension Date {
  
  func dayNumber(calendar: Calendar = .current) -> Int {
    calendar.dateComponents([.day], from: self).day!
  }
  
  func weekdayNumber(calendar: Calendar = .current) -> Int {
    calendar.dateComponents([.weekday], from: self).weekday!
  }
  
  func yearNumber(calendar: Calendar = .current) -> Int {
    calendar.dateComponents([.year], from: self).year!
  }
}
