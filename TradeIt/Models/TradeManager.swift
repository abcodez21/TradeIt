import Foundation
import UIKit
let apiKey = "bb9826b3d3bc49a599cc1370105082aa"

protocol TradeManagerDelegate{
    func didUpdateTrade(rate: String, result: String)
    func didFailWithError(error: Error)
}

struct TradeManager {
    var delegate: TradeManagerDelegate?
   
    let Tradeurl = "https://exchange-rates.abstractapi.com/v1/convert/"
    // https://exchange-rates.abstractapi.com/v1/convert/?api_key=bb9826b3d3bc49a599cc1370105082aa&base=USD&target=EUR&base_amount=500
    func fetchTrade(from: String, to: String, amount: String){
        let urlString = "\(Tradeurl)?api_key=\(apiKey)&target=\(to)&base=\(from)&base_amount=\(amount)"
        print(urlString)
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String){
        
        // 1. create a url
        if let url = URL(string: urlString){
            // 2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            // 3. Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let trade = self.parseJSON(tradeData: safeData){
                        self.delegate?.didUpdateTrade(rate: trade[0], result: trade[1])
                    }
                }
            }
            
            // 4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(tradeData: Data) -> [String]?{
        let decoder = JSONDecoder()
        do{
           let decodedData = try decoder.decode(TradeData.self, from: tradeData)
            let rate  = String(format: "%.2f", decodedData.exchange_rate)
            let result = String(format: "%.2f", decodedData.converted_amount)
            let finalData = [rate, result]
            return finalData
            
        } catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
}
