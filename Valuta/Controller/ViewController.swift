//
//  ViewController.swift
//  Valuta
//
//  Created by Чистяков Василий Александрович on 15.08.2021.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    var listOfcurrencies: [String] = [ ]
    var pickedValute: String!
    var ratesModel: RatesModel?
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var rubelsTextField: UITextField!
    @IBOutlet weak var dollarsTextField: UITextField!
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
        
        appendData()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didDoubleTap(_:)))
        tapGesture.numberOfTapsRequired = 2
        view.addGestureRecognizer(tapGesture)
    }
    
    func appendData() {
        NetworkingManager.shared.fetchRates { models in
            self.ratesModel = models
            let listsCharCode = models.Valute.keys.sorted()
            self.listOfcurrencies = listsCharCode
        }
        print(listOfcurrencies)
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
        guard let roubels: Int = (Int(rubelsTextField.text!)), let pickedValute = pickedValute else { return }
        let valueRates: Double = (Double(roubels) * Double((ratesModel?.Valute[pickedValute]!.Value ?? 0)))
        
        guard let valuteNominal =  ratesModel?.Valute[pickedValute]?.Nominal! else { return }
        let сalculatingNominal = valueRates / Double(valuteNominal)
        
        dollarsTextField.text = "\(String(format:"%.2f",сalculatingNominal))"
    }
}

