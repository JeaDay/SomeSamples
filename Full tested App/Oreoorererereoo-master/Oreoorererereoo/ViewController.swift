//
//  ViewController.swift
//  Oreoorererereoo
//
//  Created by Kamil Krzyszczak on 09/01/2019.
//  Copyright © 2019 JeaCode. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cookieInput: UITextField!
    @IBOutlet weak var cookieDisplay: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func editingChanged(_ sender: UITextField) {
        guard let cookie = sender.text,
            let layers = CookieBaker().bake(cookie: cookie) else {
                cookieDisplay.text = ""
                return
        }
        fillWithNewCookie(layers: layers, width: cookie.count)
    }
    
    private func fillWithNewCookie(layers: [CookieLayer], width: Int) {
        var visualization = ""
        for layer in layers {
            visualization.append("\(layer.visualizeValue(width: width))" + "\n")
        }
        cookieDisplay.text = visualization
    }
}

