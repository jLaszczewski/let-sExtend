//
//  String+HTML.swift
//  
//
//  Created by Jakub Łaszczewski on 01/12/2020.
//

import Foundation

public extension String {
  
  var isHtml: Bool {
    self ~= "<[^>]+>"
  }
  
  var htmlContent: String {
    """
        <!doctype html>
        <html>
            <head>
                <meta charset="utf-8">
            </head>
            <body>
                <font style="font-size:24pt;" face="arial">
                    \(self)
                </font>
            </body>
        </html>
        """
  }
}
