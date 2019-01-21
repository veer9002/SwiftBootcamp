//
//  BitCoinViewController.swift
//  SwiftBootcamp
//
//  Created by Syon on 21/01/19.
//  Copyright © 2019 Manish Sharma. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class BitCoinViewController: UIViewController {

    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    var finalURL = ""
    
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Networking
    /***************************************************************/
    
    func getBitcoinData(url: String) {
        
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if response.result.isSuccess {
                    
                    print("Sucess! Got the bitcoin data")
                    let bitcoinJSON : JSON = JSON(response.result.value!)
                    
                    self.updateBitcoinData(json: bitcoinJSON)
                    
                } else {
                    print("Error: \(String(describing: response.result.error))")
                    self.bitcoinPriceLabel.text = "Connection Issues"
                }
        }
        
    }
    
    //MARK: - JSON Parsing
    /***************************************************************/
    
    func updateBitcoinData(json : JSON) {
        
        if let bitcoinResult = json["ask"].double {
            self.bitcoinPriceLabel.text = String(bitcoinResult)
        } else {
            self.bitcoinPriceLabel.text = "Price Unavailable"
        }
    }
    
    
}

extension BitCoinViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(row)
        let fullUrl = baseURL + currencyArray[row]
        getBitcoinData(url: fullUrl)
    }
    
}
