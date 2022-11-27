//
//  ImdbViewController.swift
//  BreakingBad
//
//  Created by Tuba N. Yıldız on 25.11.2022.
//

import UIKit
import WebKit

class ImdbViewController: UIViewController {

    @IBOutlet weak var imdbView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString = "https://www.imdb.com/title/tt0903747/"
        
        if let url = URL(string: urlString) {
            //imdbView.navigationDelegate = self
            imdbView.load(URLRequest(url: url))
        }
        
    }
    
}
