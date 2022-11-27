//
//  Extensions.swift
//  BreakingBad
//
//  Created by Tuba N. Yıldız on 24.11.2022.
//

import Foundation


extension String {
    
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
