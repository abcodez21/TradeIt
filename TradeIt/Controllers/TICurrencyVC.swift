//
//  CurrencyVC.swift
//  TradeIt
//
//  Created by Abdallahi Thiaw on 2/10/23.
//

import UIKit
import DropDown


class TICurrencyVC: UIViewController, TradeManagerDelegate {
    
    let menu: DropDown = {
        let menu = DropDown()
        var currencyNames: [String] = []
        for money in currenciesData.countryCurrencies{
            currencyNames.append(money.key)
        }
        menu.dataSource = currencyNames
        return menu
    }()
    @IBOutlet var fromAbb: UILabel!
    @IBOutlet var fromInput: UITextField!
    
    
    @IBOutlet var toCurrencyName: UILabel!
    @IBOutlet var toAbb: UILabel!
    @IBOutlet var toAmount: UILabel!
    
    @IBOutlet var rateLabel: UILabel!
    
    var tradeManager = TradeManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.editInput(input: fromInput)
        tradeManager.delegate = self
        
        rateLabel.text = ""
        
        // away menu
        menu.anchorView = toAmount
        menu.width = 350
        menu.backgroundColor = fromInput.backgroundColor
        menu.textColor = fromAbb.textColor
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func checkRateBtnPressed(_ sender: UIButton) {
        if Utilities.isFilled(input: fromInput, labelDefault: "select a currency",  label: toCurrencyName){
            if let fromCurrency = fromAbb.text, let toCurrency = toAbb.text, let amountEntered = fromInput.text{
                tradeManager.fetchTrade(from: fromCurrency, to: toCurrency, amount: amountEntered)
            }
        }
        
    }
    
    
    @IBAction func awayDropDownPressed(_ sender: UIButton) {
        menu.show()
        menu.selectionAction = {index, title in
            self.toCurrencyName.text = title
            self.toAbb.text = currenciesData.countryCurrencies[title]
        }
    }
    
    func didUpdateTrade(rate: String, result: String){
        
        DispatchQueue.main.sync {
            self.toAmount.text = result
            self.rateLabel.text = "1.00 USD = \(rate) \(self.toAbb.text!)"
        }
        
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
