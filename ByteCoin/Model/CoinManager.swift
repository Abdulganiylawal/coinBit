//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate{
    func didUpdateRate(coinObject:CoinObject)
    func didFailWithError(error:Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "6F8AF972-AD8B-4C42-BF9A-24772593DF4F"
    
    var delegate: CoinManagerDelegate?
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR",""]
    
    func fetchCurrency(for currency:String){
        let url = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(with: url)
    }
    
    func performRequest(with urlString: String){
        //1. Create a URL
        if let url = URL(string: urlString){
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            //3. Give the session a task
            let task =  session.dataTask(with: url) { data, response, error in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data{
                    if let object = self.parseJson(safeData){
                        delegate?.didUpdateRate(coinObject: object)
                        
                    }
                }
              
            }
            //4. strat the task
            task.resume()
        }
        
    }
        
        func parseJson(_ safeData: Data)->CoinObject?{
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(CoinManagerObject.self, from: safeData)
                let coinObject = CoinObject(value: decodedData.rate)
                return coinObject
            }catch {
                self.delegate?.didFailWithError(error: error)
                return nil
            }
        }
}
    

