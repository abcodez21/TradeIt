//
//  Utilities.swift
//  TradeIt
//
//  Created by Abdallahi Thiaw on 2/15/23.
//

import Foundation
import UIKit

class Utilities {
    static let centeredParagraphStyle = NSMutableParagraphStyle()
    
    // check if input is a number
    static func isInt(input: UITextField) -> Bool{
        Utilities.centeredParagraphStyle.alignment = .center
        let text = Int(input.text!) ?? -9999
        if text == -9999{
            input.text = ""
            input.attributedPlaceholder = NSAttributedString(
                string: "enter number", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemRed, .paragraphStyle: Utilities.centeredParagraphStyle])
            return false
        }
        return true
    }
    
    
    // check if all field have data
    static func isFilled(input: UITextField, textError: String = "please fill in field",
                         labelDefault: String = "select a crypto", label: UILabel ) -> Bool{
        
        Utilities.centeredParagraphStyle.alignment = .center
        
        if input.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            input.attributedPlaceholder = NSAttributedString(string: textError, attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemRed, .paragraphStyle: Utilities.centeredParagraphStyle])
            return false
        }
        if labelDefault == label.text!{
            label.textColor = UIColor.systemRed
            label.text = "select a currency"
            return false
        }
        let isInt = Utilities.isInt(input: input)
        return isInt
    }
    
    static func editInput(input: UITextField){
        input.attributedPlaceholder = NSAttributedString(
                        string: "Enter amount", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, .paragraphStyle: centeredParagraphStyle]
                    )
    }
}
