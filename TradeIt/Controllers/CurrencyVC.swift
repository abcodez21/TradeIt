//
//  CurrencyVC.swift
//  TradeIt
//
//  Created by Abdallahi Thiaw on 2/10/23.
//

import UIKit
import DropDown


class CurrencyVC: UIViewController {
    
    
    let homeMenu: DropDown = {
        let menu = DropDown()
        var currencyNames: [String] = []
        for money in currenciesData.countryCurrencies{
            currencyNames.append(money.key)
        }
        menu.dataSource = currencyNames
        return menu
    }()
    
    let awayMenu: DropDown = {
        let menu = DropDown()
        var currencyNames: [String] = []
        for money in currenciesData.countryCurrencies{
            currencyNames.append(money.key)
        }
        menu.dataSource = currencyNames
        return menu
    }()
    @IBOutlet var homeCurrency: UILabel!
    @IBOutlet var homeAbb: UILabel!
    @IBOutlet var homeInput: UITextField!
    
    
    @IBOutlet var awayCurrency: UILabel!
    @IBOutlet var awayAbb: UILabel!
    @IBOutlet var awayAmount: UILabel!
    
    @IBOutlet var rateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // home menu
        homeMenu.anchorView = homeInput
        homeMenu.width = 350
        homeMenu.backgroundColor = homeInput.backgroundColor
        homeMenu.textColor = homeAbb.textColor
        
        // away menu
        awayMenu.anchorView = awayAmount
        awayMenu.width = 350
        awayMenu.backgroundColor = homeInput.backgroundColor
        awayMenu.textColor = homeAbb.textColor
        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func homeDropDownPressed(_ sender: UIButton) {
        homeMenu.show()
        homeMenu.selectionAction = {index, title in
            self.homeCurrency.text = title
            self.homeAbb.text = currenciesData.countryCurrencies[title]
        }
    }
    
    @IBAction func awayDropDownPressed(_ sender: UIButton) {
        awayMenu.show()
        awayMenu.selectionAction = {index, title in
            self.awayCurrency.text = title
            self.awayAbb.text = currenciesData.countryCurrencies[title]
        }
    }
}
