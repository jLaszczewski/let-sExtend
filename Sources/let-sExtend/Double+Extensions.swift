//
//  Double+Extensions.swift
//  
//
//  Created by ITgenerator on 22/02/2021.
//

import Foundation

public extension Double {
  
  func croppedEndingString(
    minimumFractionDigits: Int = 0,
    maximumFractionDigits: Int = 2,
    formatter: NumberFormatter = NumberFormatter()
  ) -> String {
    let number = NSNumber(value: self)
    formatter.minimumFractionDigits = minimumFractionDigits
    formatter.maximumFractionDigits = maximumFractionDigits
    return String(formatter.string(from: number) ?? "")
  }
}
