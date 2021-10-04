//
//  PickerDelagate.swift
//  Valuta
//
//  Created by Чистяков Василий Александрович on 26.09.2021.
//

import Foundation
import UIKit

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        listOfcurrencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let valutePicker = listOfcurrencies[row]
        return valutePicker
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickedValute = listOfcurrencies[row]
        //        print(pickedValute)
        textLabel.text = ratesModel?.Valute[pickedValute]?.Name
        
        rubelsTextField.placeholder = listOfcurrencies[row]
        //        rubelsTextField.placeholder = ratesModel?.Valute["\(pickedValute ?? " ")"]!.CharCode
        
        сalculatingСurrency(rubelsTextField: rubelsTextField, dollarsTextField: dollarsTextField, pickedValute: pickedValute)
    }
}
