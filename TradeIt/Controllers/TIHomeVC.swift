//
//  ViewController.swift
//  TradeIt
//
//  Created by Abdallahi Thiaw on 2/8/23.
//

import UIKit
import CLTypingLabel
class TIHomeVC: UIViewController {

    @IBOutlet var AppNameLabel: CLTypingLabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        AppNameLabel.text = "Trade It"
        // Do any additional setup after loading the view.
    }


}

