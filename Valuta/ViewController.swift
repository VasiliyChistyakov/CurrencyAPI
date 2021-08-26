//
//  ViewController.swift
//  Valuta
//
//  Created by Чистяков Василий Александрович on 15.08.2021.
//

import UIKit

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
        fetchRates()
    }
    
    @IBAction func saveAction(_ sender: Any) {
        
        guard let roubels: Int = (Int(rubelsTextField.text!)) else { return }
        //        print(roubels)
        guard let pickedValute = pickedValute else { return }
        let valueRates =  roubels * Int((ratesModel?.Valute["\(pickedValute)"]!.Value)!)
        dollarsTextField.text = "\(String(valueRates)) ₽"
    }
    
    func fetchRates(){
        guard let url = URL(string: "https://www.cbr-xml-daily.ru/daily_json.js") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            print(data)
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                self.ratesModel = try decoder.decode(RatesModel.self, from: data)
                print(self.ratesModel?.Date)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }.resume()
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
        print(pickedValute)
        textLabel.text = ratesModel?.Valute[pickedValute]?.Name
        rubelsTextField.placeholder = listOfcurrencies[row]
//        rubelsTextField.placeholder = ratesModel?.Valute["\(pickedValute ?? " ")"]!.CharCode
    }
}
