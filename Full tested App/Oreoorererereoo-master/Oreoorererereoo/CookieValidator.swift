//
//  CookieValidator.swift
//  Oreoorererereoo
//
//  Created by Kamil Krzyszczak on 10/01/2019.
//  Copyright © 2019 JeaCode. All rights reserved.
//

import Foundation

final class CookieValidator {
    
    private let legal = ["O","r","e","o"]
    
    func isValid(cookie: String) -> Bool {
        
        guard !cookie.isEmpty else {
            return false
        }
        
        guard containsOnlyLegalCharacters(cookie: cookie) else {
            return false
        }
        
        guard isValidLayers(cookie: cookie) else {
            return false
        }
        
        return true
    }
    
    private func containsOnlyLegalCharacters(cookie: String) -> Bool {
        for character in cookie {
            if !legal.contains(String(character)) {
                return false
            }
        }
        return true
    }
    
    private func isValidLayers(cookie: String) -> Bool {
        for i in 0...(cookie.count - 1) {
            if cookie[i] == "r", cookie[i+1] != "e" {
                return false
            } else if cookie[i] == "e", cookie[i+1] == "e" {
                return false
            }
        }
        return true
    }

}
