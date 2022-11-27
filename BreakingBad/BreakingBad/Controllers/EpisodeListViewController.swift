//
//  EpisodeListViewController.swift
//  BreakingBad
//
//  Created by Tuba N. Yıldız on 25.11.2022.
//

import UIKit

class EpisodeListViewController: UIViewController {

    @IBOutlet weak var episodeTableView: UITableView!
    
    var episodesData: EpisodesResponse?
    var characters : [String]?
   
    
    lazy var popUpWindow: UIStackView = {
        let temp = UIStackView(arrangedSubviews: [closeButton, secondTable])
        
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.backgroundColor = .systemBackground
        temp.alignment = .trailing
        temp.distribution = .fill
        temp.axis = .vertical
        temp.spacing = 0
        return temp
        
    }()
    
    lazy var secondTable: UITableView = {
        
        secondTable = UITableView(frame: CGRect(x: 0, y: 0, width: 300, height: 230))
    
        secondTable.heightAnchor.constraint(equalToConstant: 230).isActive = true
        secondTable.widthAnchor.constraint(equalToConstant: 300).isActive = true
        secondTable.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        secondTable.dataSource = self
        secondTable.delegate = self
        
        return secondTable
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton(type: .close, primaryAction: .none)
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)

        return button
    }()
    
    

    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        episodeTableView.delegate = self
        episodeTableView.dataSource = self
       
        fetchEpisodes()
    }

    func fetchEpisodes() {
        //present(loadingVC, animated: true)
        Service.getAllEpisodes {episodesData , error in
            self.episodesData = episodesData
            self.episodeTableView.reloadData()
        }
    }
}

extension EpisodeListViewController: UITableViewDelegate, UITableViewDataSource {
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == episodeTableView {
            return  self.episodesData?.count ?? 0
        }
        else if tableView == secondTable {
            return self.characters?.count ?? 0
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == episodeTableView {
            if let data = episodesData {
                let title = data[indexPath.row].title
                let episodeInfo = "S" + data[indexPath.row].season.getFormattedEpisode() + "•" + "E" + data[indexPath.row].episode.getFormattedEpisode()
                let cell = episodeTableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath)
               
                cell.textLabel?.text = title
                cell.detailTextLabel?.text = episodeInfo
                        
                return cell
            }
        }
        else if tableView == secondTable {
            let cell = secondTable.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
            cell.textLabel?.text = self.characters?[indexPath.row] ?? "test"
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.characters = self.episodesData?[indexPath.row].characters
        handleShowPopUp()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == secondTable {
            return "Who did act on this episode?"
        }
        return ""
    }
    
    
    
    @objc func handleShowPopUp() {
        
        
        view.addSubview(visualEffectView)

        visualEffectView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        visualEffectView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        visualEffectView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        visualEffectView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        
        view.addSubview(popUpWindow)
        popUpWindow.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40).isActive = true
        popUpWindow.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
         
         popUpWindow.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
         popUpWindow.alpha = 0
         
         UIView.animate(withDuration: 0.5) {
             self.visualEffectView.alpha = 0.6
             self.popUpWindow.alpha = 1
             self.popUpWindow.transform = CGAffineTransform.identity
         }
    }
    
    @objc func closeButtonTapped(){
        self.popUpWindow.removeFromSuperview()
        self.visualEffectView.removeFromSuperview()

    }

}


