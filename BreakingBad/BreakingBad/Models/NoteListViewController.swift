//
//  NoteListViewController.swift
//  BreakingBad
//
//  Created by Tuba N. Yıldız on 29.11.2022.
//

import UIKit

class NoteListViewController: UIViewController {

    @IBOutlet weak var noteListTableView: UITableView!
    var notes: [Note] = []
    
    
    lazy var floatingButton: UIButton = {
        let temp:UIButton = UIButton(type: UIButton.ButtonType.contactAdd)
        temp.layer.cornerRadius = 25
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)

        return temp
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notes = CoreDataManager.shared.getNotes()
        view.addSubview(floatingButton)
       
        floatingButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        floatingButton.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor, constant: -10).isActive = true

        configureTableView()
    }
    
    private func configureTableView(){
        noteListTableView.delegate = self
        noteListTableView.dataSource = self
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier  == "toAddEdit" {
            let destination = segue.destination as! NoteAddEditViewController
            destination.delegate = self
            if sender != nil {
                destination.note = sender as? Note
            }
        }
    }
    
    @objc func addButtonTapped(){
        performSegue(withIdentifier: "toAddEdit", sender: nil)
    }
}

extension NoteListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        cell.textLabel?.text = notes[indexPath.row].noteText
        cell.detailTextLabel?.text = "Season " + String(notes[indexPath.row].noteSeason) + " - Episode " + String(notes[indexPath.row].noteEpisode)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toAddEdit", sender: notes[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let note = notes[indexPath.row]
            CoreDataManager.shared.deleteNote(note: note)
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension NoteListViewController: NoteAddEditViewControllerDelegate {
    
    func savePressed(noteText: String, episode: Int, season: Int) {
        guard let note = CoreDataManager.shared.saveNote(text: noteText, season: season, episode: episode ) else {return}
        self.notes.append(note)
        self.noteListTableView.reloadData()
    }
    
    func updatePressed(note: Note) {
        let note_new = CoreDataManager.shared.updateNote(note: note)
        self.noteListTableView.reloadData()
    }
}
