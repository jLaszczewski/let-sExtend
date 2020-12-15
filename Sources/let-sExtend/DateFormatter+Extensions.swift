//
//  DateFormatter+Extensions.swift
//
//
//  Created by Jakub Łaszczewski on 08/01/2020.
//

import Foundation

public extension DateFormatter {
  
  static var dayNameFormatter: DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.setLocalizedDateFormatFromTemplate("EEE")
    return dateFormatter
  }
  
  static var dayFormatter: DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.setLocalizedDateFormatFromTemplate("dd")
    return dateFormatter
  }
  
  static var monthNameYearFormatter: DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.setLocalizedDateFormatFromTemplate("LLLL, yyyy")
    return dateFormatter
  }
  
  static var monthNameFormatter: DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.setLocalizedDateFormatFromTemplate("LLLL")
    return dateFormatter
  }
  
  static var yearFormatter: DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.setLocalizedDateFormatFromTemplate("yyyy")
    return dateFormatter
  }
  
  convenience init(withDateFormat dateFormat: String) {
    self.init()
    self.dateFormat = dateFormat
  }
}
