//
//  Extensions.swift
//  BreakingBad
//
//  Created by Tuba N. Yıldız on 24.11.2022.
//

import Foundation
import UIKit

extension String {
    
    func firstNumber() -> Int {
        for character in self {
            if character.isNumber{
                return Int(String(character)) ?? 0
            }
        }
        return 0
    }
    
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func getFormattedEpisode() -> String {
        var num = 0
        if Int(self) != nil {
            num = Int(self) ?? 0
        }
        else{
           self.dropFirst()
           num = Int(self) ?? 0
        }
        if 10 - (num) > 0 {
            if self.hasPrefix(" ") {
                return "0" + self.dropFirst()
            }
            else {
                return "0" + self
            }
        }
        else {
            return self
        }
    }
}

extension UIViewController {
    func presentAlert(title: String, message: String){ //todo: title ve message parametre olarak alıp reusable hale getir.
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Try again", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
