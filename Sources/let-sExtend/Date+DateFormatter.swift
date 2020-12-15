//
//  Date+DateFormatter.swift
//  
//
//  Created by Jakub Łaszczewski on 15/12/2020.
//

import Foundation

public extension DateComponents {
  
  enum Kind {
    case time
    case dayOfMonth
    case `default`
    case withoutTime
  }
}

// MARK: - Components
public extension Date {
  
  func monthNumber(calendar: Calendar = Calendar.current) -> Int {
    calendar.dateComponents([.month], from: self).month!
  }
  
  func dateComponents(
    for destination: DateComponents.Kind,
    calendar: Calendar
  ) -> DateComponents {
    switch destination {
    case .dayOfMonth:
      return calendar.dateComponents(
        [.month,
         .day,
         .hour,
         .minute],
        from: self)
    case .time:
      return calendar.dateComponents(
        [.hour,
         .minute],
        from: self)
    case .withoutTime:
      return calendar.dateComponents(
        [.year,
         .month,
         .day],
        from: self)
    case .default:
      return calendar.dateComponents(
        [.year,
         .month,
         .day,
         .hour,
         .minute,
         .second,
         .nanosecond],
        from: self)
    }
  }
}
