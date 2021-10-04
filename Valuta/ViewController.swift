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
        print("DoubleTap")
    }
    
    @IBAction func tapAction(_ sender: Any) {
        rubelsTextField.resignFirstResponder()
        dollarsTextField.resignFirstResponder()
        
        if let rubels = rubelsTextField.text, rubels.isEmpty {
            dollarsTextField.text?.removeAll()
            print("OneTap")
        }
    }
    
    func сalculatingСurrency(rubelsTextField: UITextField!, dollarsTextField: UITextField, pickedValute: String!) {
        guard let roubels: Int = (Int(rubelsTextField.text!)), let pickedValute = pickedValute else { return }
        
        let valueRates: Double = (Double(roubels) * Double((ratesModel?.Valute[pickedValute]!.Value ?? 0)))
        
        guard let valuteNominal =  ratesModel?.Valute[pickedValute]?.Nominal! else { return }
        
        let сalculatingNominal = valueRates / Double(valuteNominal)
        
        dollarsTextField.text = "\(String(format:"%.2f",сalculatingNominal))"
    }
}

