//
//  CharacterCollectionViewCell.swift
//  BreakingBad
//
//  Created by Tuba N. Yıldız on 24.11.2022.
//

import UIKit
import Kingfisher

class CharacterCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var characterPoster: UIImageView!
    
    @IBOutlet weak var characterName: UILabel!
    
    @IBOutlet weak var characterNickName: UILabel!
    
    @IBOutlet weak var characterBirthday: UILabel!
    
    
    func set(icon: String?, name: String?, nickName: String?, birthday: Birthday?){
        
        /*Service.shared.fetchImage(withUrlString: icon ?? "") { moviePoster in
            DispatchQueue.main.async {
                self.MoviePoster.image = moviePoster
            }
        }*/
        let url = URL(string: icon!)
        DispatchQueue.main.async {
            self.characterPoster.kf.setImage(with: url)
            
            self.characterName.text = name
            self.characterNickName.text = nickName?.capitalizingFirstLetter()
            self.characterBirthday.text = birthday?.getYear()
        }
    }
}
