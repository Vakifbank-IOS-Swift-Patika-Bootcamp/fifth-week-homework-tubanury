//
//  CharactersViewController.swift
//  BreakingBad
//
//  Created by Tuba N. Yıldız on 24.11.2022.
//

import UIKit

class CharactersViewController: UIViewController {

    @IBOutlet weak var characterCollectionView: UICollectionView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var charactersData: CharactersResponse?
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.spinner.startAnimating()
        }
        characterCollectionView.delegate = self
        characterCollectionView.dataSource = self
        fetchCharacters()
    }
   
  
    
    func fetchCharacters() {
        Service.getAllCharacters { charactersData, error in
            self.charactersData = charactersData
            self.spinner.isHidden = true
            self.characterCollectionView.reloadData()
            
        }
        

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail"{
            if let cell = sender as? UICollectionViewCell,
               let indexPath = self.characterCollectionView.indexPath(for: cell) {
                
                let vc = segue.destination as! CharacterDetailViewController //Cast with your DestinationController
                //Now simply set the title property of vc
                vc.character = charactersData?[indexPath.row]
            }
        }
    }
    func presentAlert(){ //todo: title ve message parametre olarak alıp reusable hale getir.
        let alert = UIAlertController(title: "Error", message: "The movie you searched is not found!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Try again", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension CharactersViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        charactersData?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCollectionViewCell", for: indexPath) as! CharacterCollectionViewCell
        cell.set(icon: charactersData?[indexPath.row].img,
                 name: charactersData?[indexPath.row].name,
                 nickName: charactersData?[indexPath.row].nickname,
                 birthday: charactersData?[indexPath.row].birthday)
        
        return cell
    }
    
}
