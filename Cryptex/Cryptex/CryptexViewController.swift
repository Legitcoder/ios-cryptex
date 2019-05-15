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
    
    
    var letters = ["A", "B", "C", "D",
                   "E", "F", "G", "H",
                   "I", "J", "K", "L",
                   "M", "N", "O", "P",
                   "Q", "R", "S", "T",
                   "U", "V", "W", "X",
                   "Y", "Z"]

    override func viewDidLoad() {
        super.viewDidLoad()
        cryptexPickerView.dataSource = self
        cryptexPickerView.delegate = self
        guard let hint = cryptexController.currentCryptex?.hint else { return }
        updateViews(hint: hint)
    }
    
    func updateViews(hint: String) {
        hintLabel.text = hint
        cryptexPickerView.reloadAllComponents()
    }
    
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var cryptexPickerView: UIPickerView!
    
    @IBAction func unlock(_ sender: Any) {
    }
    
    let cryptexController = CryptexController()
    
}
