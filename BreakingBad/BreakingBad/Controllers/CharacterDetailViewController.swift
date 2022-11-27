//
//  CharacterDetailViewController.swift
//  BreakingBad
//
//  Created by Tuba N. Yıldız on 25.11.2022.
//

import UIKit

class CharacterDetailViewController: UIViewController {

   
    var character: Character?
    
    @IBOutlet weak var characterImageView: UIImageView!
    
    @IBOutlet weak var characterOccupation: UILabel!
    @IBOutlet weak var characterBirthday: UILabel!
    @IBOutlet weak var characterNickName: UILabel!
    @IBOutlet weak var characterName: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let char = character {
            let url = URL(string: char.img)
            DispatchQueue.main.async {
                self.characterImageView.kf.setImage(with: url)
                
                self.characterName.text = char.name
                self.characterNickName.text = char.nickname.capitalizingFirstLetter()
                self.characterBirthday.text = char.birthday.getYear()
                self.characterOccupation.text = char.occupation.first
            }
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toQuotes"{
            if let data = character {
                let detailVc = segue.destination as! CharacterQuotesViewController
                detailVc.authorName = data.name
            }
        }
    }
    
}
