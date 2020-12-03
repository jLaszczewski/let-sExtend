//
//  String+RegularExrepssion.swift
//  Fit Dostawcy
//
//  Created by Jakub Łaszczewski on 23/04/2019.
//  Copyright © 2019 Jakub Łaszczewski. All rights reserved.
//

import Foundation

public extension String {
  
    static func ~= (lhs: String, rhs: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: rhs) else { return false }
        let range = NSRange(location: 0, length: lhs.utf16.count)
        return regex.firstMatch(in: lhs, options: [], range: range) != nil
    }
}