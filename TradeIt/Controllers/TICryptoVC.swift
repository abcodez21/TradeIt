//
//  CryptoVC.swift
//  TradeIt
//
//  Created by Abdallahi Thiaw on 2/10/23.
//

import UIKit
import DropDown
class TICryptoVC: UIViewController, TradeManagerDelegate {
   
    
    let cryptoMenu: DropDown = {
        let menu = DropDown()
        var cryptoNames: [String] = []
        for coin in currenciesData.cryptoCurrencies{
            cryptoNames.append(coin.key)
        }
        menu.dataSource = cryptoNames
        return menu
    }()
    
    
    @IBOutlet var cryptoLabel: UILabel!
    @IBOutlet var cryptoInput: UITextField!
    @IBOutlet var cryptoAbb: UILabel!
    

    @IBOutlet var currencyLabel: UILabel!
    @IBOutlet var currencyAmount: UILabel!
    @IBOutlet var currencyAbb: UILabel!
    
    @IBOutlet var rateLabel: UILabel!
    
    var tradeManager = TradeManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tradeManager.delegate = self
        rateLabel.text = ""
        
        Utilities.editInput(input: cryptoInput)

        
        cryptoMenu.anchorView = cryptoLabel
        cryptoMenu.width = 350
        cryptoMenu.backgroundColor = cryptoInput.backgroundColor
        cryptoMenu.textColor = cryptoAbb.textColor
        
    }
    
    
    @IBAction func checkRateBtnPressed(_ sender: UIButton) {
        if Utilities.isFilled(input: cryptoInput,   label: cryptoLabel){
            if let fromCurrency = cryptoAbb.text, let toCurrency = currencyAbb.text, let amountEntered = cryptoInput.text{
                tradeManager.fetchTrade(from: fromCurrency, to: toCurrency, amount: amountEntered)
            }
        }
    }
    
    
    @IBAction func cryptoDropDownPressed(_ sender: UIButton) {
        cryptoMenu.show()
        cryptoMenu.selectionAction = {index, title in
            self.cryptoLabel.text = title
            self.cryptoAbb.text = currenciesData.cryptoCurrencies[title]
        }
    }
    func didUpdateTrade(rate: String, result: String){
        
        DispatchQueue.main.sync {
            self.currencyAmount.text = result
            self.rateLabel.text = "1.00 \(self.cryptoAbb.text!) = \(rate) USD"
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }

}
