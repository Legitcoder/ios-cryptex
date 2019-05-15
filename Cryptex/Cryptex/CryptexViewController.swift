//
//  CryptexViewController.swift
//  Cryptex
//
//  Created by Moin Uddin on 5/14/19.
//  Copyright © 2019 Moin Uddin. All rights reserved.
//

import UIKit

class CryptexViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return cryptexController.currentCryptex?.password.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return letters.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return letters[row]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        cryptexPickerView.dataSource = self
        cryptexPickerView.delegate = self
        updateViews()
    }
    
    func updateViews() {
        hintLabel.text = cryptexController.currentCryptex?.hint
        cryptexPickerView.reloadAllComponents()
    }
    
    func reset() {
        countdownTimer?.invalidate()
        let components: Int = cryptexController.currentCryptex?.password.count ?? 0
        for component in 0..<components {
            cryptexPickerView.selectRow(0, inComponent: component, animated: true)
        }
        
        Timer.scheduledTimer(withTimeInterval: 60, repeats: false) { (_) in
            self.presentNoTimeRemainingAlert()
        }
    }
    
    func newCryptexAndReset() {
        cryptexController.randomCryptex()
        updateViews()
        reset()
    }
    

    func hasMatchingPassword() -> Bool {
        let components: Int = cryptexController.currentCryptex?.password.count ?? 0
        let currentPassword = cryptexController.currentCryptex?.password
        var charArr: [String] = []
        for component in 0..<components {
            let selectedRow = cryptexPickerView.selectedRow(inComponent: component)
            guard let letter = pickerView(cryptexPickerView, titleForRow: selectedRow, forComponent: component) else { continue }
            charArr.append(letter)
        }
        let word = charArr.joined().lowercased()
        return word == currentPassword?.lowercased()
    }
    
    
    
    
    func presentCorrectPasswordAlert() {
        let title = "Congratulations!"
        let message = "You guessed the password! Would you like to play again with a new cryptex?"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let newCryptexAction = UIAlertAction(title: "New cryptex", style: .default) { (_) in
            self.newCryptexAndReset()
        }
        
        alert.addAction(newCryptexAction)
        
        present(alert, animated: true)
    }
    
    func presentIncorrectPasswordAlert() {
        
        let title = "Not quite!"
        let message = "Would you like to keep guessing, or try a new cryptex?"
        
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let guessingAction = UIAlertAction(title: "Keep guessing", style: .default, handler: nil)
        
        let newCryptexAction = UIAlertAction(title: "New cryptex", style: .default) { (_) in
            self.newCryptexAndReset()
        }
        
        alert.addAction(guessingAction)
        alert.addAction(newCryptexAction)
        
        present(alert, animated: true)
        
    }
    
    func presentNoTimeRemainingAlert() {
        
        let title = "You've ran out of time!"
        let message = "Would you like to reset the timer and keep guessing, or try a new cryptex?"
        
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        
        let resetAction = UIAlertAction(title: "Reset and try again", style: .default) { (_) in
            self.reset()
        }
        
        let newCryptexAction = UIAlertAction(title: "New cryptex", style: .default) { (_) in
            self.newCryptexAndReset()
        }
        
        alert.addAction(resetAction)
        alert.addAction(newCryptexAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var cryptexPickerView: UIPickerView!
    
    @IBAction func unlock(_ sender: Any) {
        if hasMatchingPassword() {
            presentCorrectPasswordAlert()
        } else {
            presentIncorrectPasswordAlert()
        }
    }
    
    let cryptexController = CryptexController()
    var countdownTimer: Timer?
    var letters = ["A", "B", "C", "D",
                   "E", "F", "G", "H",
                   "I", "J", "K", "L",
                   "M", "N", "O", "P",
                   "Q", "R", "S", "T",
                   "U", "V", "W", "X",
                   "Y", "Z"]
    
}
