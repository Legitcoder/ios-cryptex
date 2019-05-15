//
//  CryptexController.swift
//  Cryptex
//
//  Created by Moin Uddin on 5/14/19.
//  Copyright © 2019 Moin Uddin. All rights reserved.
//

import Foundation


class CryptexController {
    
    var cryptexes: [Cryptex] = [
        Cryptex(password: "Cryptex", hint: "The thing you are trying to solve right now"),
        Cryptex(password: "Lambda", hint: "Name of the coding school you're attending")
    ]
    
    var currentCryptex: Cryptex?
    
    init() {
        randomCryptex()
    }
    
    func randomCryptex() {
        currentCryptex = self.cryptexes.randomElement()
    }
}
