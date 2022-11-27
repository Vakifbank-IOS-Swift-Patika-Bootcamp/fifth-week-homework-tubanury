//
//  CharacterQuotesViewController.swift
//  BreakingBad
//
//  Created by Tuba N. Yıldız on 26.11.2022.
//

import UIKit

class CharacterQuotesViewController: UIViewController {

    @IBOutlet weak var quotesTable: UITableView!
    var authorName: String?
    var quotes: QuotesResponse?
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quotesTable.dataSource = self
        guard let name = authorName else {return}
        fetchQuotesOfCharacter(name: name)
    }

    func fetchQuotesOfCharacter(name: String){
        Service.getAllQuotesByCharacter(name: name, completion: { quotes, error in
            self.quotes = quotes
            self.quotesTable.reloadData()
        })
    }
}

extension CharacterQuotesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        quotes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let data = quotes {
            let title = data[indexPath.row].quote
            let subtitle = "in " + data[indexPath.row].series

            let cell = quotesTable.dequeueReusableCell(withIdentifier: "quoteCell", for: indexPath)
            cell.textLabel?.text = title
            cell.detailTextLabel?.text = subtitle
        
            return cell
            
        }
        return UITableViewCell()
    }
    
    
}
