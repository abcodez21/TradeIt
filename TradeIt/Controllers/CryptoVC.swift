//
//  CryptoVC.swift
//  TradeIt
//
//  Created by Abdallahi Thiaw on 2/10/23.
//

import UIKit
import DropDown
class CryptoVC: UIViewController {
    let currencyMenu: DropDown = {
        let menu = DropDown()
        var currencyNames: [String] = []
        for money in currenciesData.countryCurrencies{
            currencyNames.append(money.key)
        }
        menu.dataSource = currencyNames
        return menu
    }()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // home menu
        cryptoMenu.anchorView = cryptoLabel
        cryptoMenu.width = 350
        cryptoMenu.backgroundColor = cryptoInput.backgroundColor
        cryptoMenu.textColor = cryptoAbb.textColor
        
        // away menu
        currencyMenu.anchorView = currencyLabel
        currencyMenu.width = 350
        currencyMenu.backgroundColor = cryptoInput.backgroundColor
        currencyMenu.textColor = cryptoAbb.textColor
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cryptoDropDownPressed(_ sender: UIButton) {
        cryptoMenu.show()
        cryptoMenu.selectionAction = {index, title in
            self.cryptoLabel.text = title
            self.cryptoAbb.text = currenciesData.cryptoCurrencies[title]
        }
    }
    
    @IBAction func currencyDropDownPressed(_ sender: UIButton) {
        currencyMenu.show()
        currencyMenu.selectionAction = {index, title in
            self.currencyLabel.text = title
            self.currencyAbb.text = currenciesData.countryCurrencies[title]
        }
    }
    

}
