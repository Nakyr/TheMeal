//
//  String+Validation.swift
//  TheMeal
//
//  Created by Armando Corona Carrillo on 11/10/23.
//

import Foundation

extension String {
    var isEmptyOrWhitespace: Bool {
        if self.isEmpty {
            return true
        }
        
        return (self.trimmingCharacters(in: .whitespaces) == "")
    }
}

extension Swift.Optional where Wrapped == String {
    var isEmptyOrWhitespace: Bool {
        // Check nil
        guard let this = self else { return true }
        
        // Check empty string
        if this.isEmpty {
            return true
        }
        // Trim and check empty string
        return (this.trimmingCharacters(in: .whitespaces) == "")
    }
}
