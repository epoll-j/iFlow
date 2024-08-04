//
//  Double.swift
//  debugger
//
//  Created by dubhe on 2024/7/31.
//

import Foundation

extension Double {
    func formattedDate(_ format: String = "yyyy-MM-dd mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: Date(timeIntervalSince1970: self))
    }
}
