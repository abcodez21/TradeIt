import Foundation
import UIKit
let apiKey = "EyWz53JJkD4ptnd0N1tnShUYUyNGVK3l"

protocol TradeManagerDelegate{
    func didUpdateTrade(rate: String, result: String)
    func didFailWithError(error: Error)
}

struct TradeManager {
    var delegate: TradeManagerDelegate?
   
    let Tradeurl = "https://api.apilayer.com/fixer/convert"
    
    func fetchTrade(from: String, to: String, amount: String){
        let urlString = "\(Tradeurl)?apikey=\(apiKey)&to=\(to)&from=\(from)&amount=\(amount)"
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
            let rate  = String(format: "%.2f", decodedData.info.rate)
            let result = String(format: "%.2f", decodedData.result)
            let finalData = [rate, result]
            return finalData
            
        } catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
}
