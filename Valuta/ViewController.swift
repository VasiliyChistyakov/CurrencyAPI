//
//  ViewController.swift
//  Valuta
//
//  Created by Чистяков Василий Александрович on 15.08.2021.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    var pickedValute: String!
    var ratesModel: RatesModel?
    var listOfcurrencies = ["AUD","AZN","GBP","AMD","BYN","BGN","BRL","HUF","HKD","DKK", "USD", "EUR", "INR", "KZT", "CAD", "KGS", "CNY", "MDL", "NOK", "PLN", "RON", "XDR", "SGD", "TJS", "TRY", "TMT", "UZS", "UAH", "CZK", "SEK", "CHF", "ZAR", "KRW", "JPY"]
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var rubelsTextField: UITextField!
    @IBOutlet weak var dollarsTextField: UITextField!
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didDoubleTap(_:)))
        tapGesture.numberOfTapsRequired = 2
        view.addGestureRecognizer(tapGesture)
        
        NetworkingManager.shared.fetchRates { model in
            self.ratesModel = model
        }
    }
    
    @objc private func didDoubleTap(_ gesture: UITapGestureRecognizer) {
        сalculatingСurrency(rubelsTextField: rubelsTextField, dollarsTextField: dollarsTextField, pickedValute: pickedValute)
//        print("DoubleTap")
    }
    
    @IBAction func tapAction(_ sender: Any) {
        rubelsTextField.resignFirstResponder()
        dollarsTextField.resignFirstResponder()
        
        if let rubels = rubelsTextField.text, rubels.isEmpty {
            dollarsTextField.text?.removeAll()
//            print("OneTap")
        }
    }
    
    func сalculatingСurrency(rubelsTextField: UITextField!, dollarsTextField: UITextField, pickedValute: String!) {
        guard let roubels: Int = (Int(rubelsTextField.text!)) else { return }
        //        print(roubels)
        guard let pickedValute = pickedValute else { return }
        
        
        let valueRates =  roubels * Int((ratesModel?.Valute["\(pickedValute)"]!.Value ?? 0))
        dollarsTextField.text = "\(String(valueRates)) ₽"
    }
}

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
