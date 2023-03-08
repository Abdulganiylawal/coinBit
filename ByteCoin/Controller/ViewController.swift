//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
  

    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!

    @IBOutlet weak var currencyRateLabel: UILabel!
    
    
    var coinManager = CoinManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
    }
    
    
}
//MARK: - UIPickerViewDelegate

extension ViewController:UIPickerViewDataSource,UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row != coinManager.currencyArray.count{
            return "\(coinManager.currencyArray[row])"
        }
        else{
            return ""
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coinManager.fetchCurrency(for:coinManager.currencyArray[row])
        currencyLabel.text = coinManager.currencyArray[row]
    }
}


//MARK: - CoinManagerDelegate

extension ViewController:CoinManagerDelegate{
    func didUpdateRate(coinObject: CoinObject) {
        DispatchQueue.main.async {
            self.currencyRateLabel.text = coinObject.rate
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}
