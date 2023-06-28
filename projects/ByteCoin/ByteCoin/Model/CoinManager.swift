//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCoin(_ coinManager: CoinManager, _ coinData: CoinData)
    func didFailWithError(_ error: Error)
}


struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "086299B4-495C-4DC9-A2C2-2DD76205D38A"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    var currency: String?
    var delegate: CoinManagerDelegate?
    
    mutating func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        self.currency = currency
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error!)
                }
                
                if let safeData = data {
                    if let coinData = parseJSON(safeData) {
                        print(coinData)
                        self.delegate?.didUpdateCoin(self, coinData)
                        
                        
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ coinData: Data) -> CoinData? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let time = decodedData.time
            let asset_id_base = decodedData.asset_id_base
            let asset_id_quote = decodedData.asset_id_quote
            let rate = decodedData.rate
            return CoinData(time: time, asset_id_base: asset_id_base, asset_id_quote: asset_id_quote, rate: rate)
            
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
        
    }
}
