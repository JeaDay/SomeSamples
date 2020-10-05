//
//  CookieLayer.swift
//  Oreoorererereoo
//
//  Created by Kamil Krzyszczak on 10/01/2019.
//  Copyright © 2019 JeaCode. All rights reserved.
//

import Foundation

struct CookieLayer {
    let place: Int
    let type: LayerType
    
    func visualizeValue(width: Int) -> String {
        
        if width == 2 && type == .Filling {
            return "  "
        }
        
        let realwidth = type == .Filling ? width - 2 : width
        var layer: String = type == .Filling ? " " : ""
        for _ in 1...realwidth {
            layer.append(type == .Filling ? "░" : "█")
        }
        layer.append(type == .Filling ? " " : "")
        return layer
    }
}

enum LayerType {
    case Filling
    case Toping
}
