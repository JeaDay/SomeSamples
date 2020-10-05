//
//  CookieBaker.swift
//  Oreoorererereoo
//
//  Created by Kamil Krzyszczak on 09/01/2019.
//  Copyright © 2019 JeaCode. All rights reserved.
//


final class CookieBaker {
   
    func bake(cookie: String) -> [CookieLayer]? {
        guard CookieValidator().isValid(cookie: cookie) else {
            return nil
        }
        
        var layers: [CookieLayer] = []
        
        var index = 0
        let shortCookie = cookie.replacingOccurrences(of: "e",
                                                      with: "")
        _ = shortCookie
            .map { letter in
                if let layer = bakeLayer(cookie: shortCookie,
                                         index: index) {
                    layers.append(layer)
                    index += 1
                }
        }
        
        return layers
    }
    
    
    func bakeLayer(cookie: String, index: Int) -> CookieLayer? {
        guard !cookie.isEmpty, cookie.count > index else { return nil }
        
        let character = cookie[index]
        
        return character == "o" || character == "O" ? CookieLayer(place: index, type: .Toping) : CookieLayer(place: index, type: .Filling)
    }
}
