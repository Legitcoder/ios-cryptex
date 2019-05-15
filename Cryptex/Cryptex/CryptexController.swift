//
//  CryptexController.swift
//  Cryptex
//
//  Created by Moin Uddin on 5/14/19.
//  Copyright © 2019 Moin Uddin. All rights reserved.
//

import Foundation


class CryptexController {
    
    var cryptexes: [Cryptex] = [Cryptex(password: "Cryptex", hint: "The thing you are trying to solve right now")]
    
    var currentCryptex: Cryptex?
    
    init() {
        randomCryptex()
    }
    
    func randomCryptex() {
        currentCryptex = self.cryptexes.randomElement()
    }
}
