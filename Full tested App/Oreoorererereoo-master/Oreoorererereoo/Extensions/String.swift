//
//  String.swift
//  Oreoorererereoo
//
//  Created by Kamil Krzyszczak on 09/01/2019.
//  Copyright © 2019 JeaCode. All rights reserved.
//

extension String {
    subscript (i: Int) -> Character? {
        guard !self.isEmpty else {
            return nil
        }
        
        guard self.count > i else {
            return nil
        }
        
        return self[index(startIndex, offsetBy: i)]
    }
}
