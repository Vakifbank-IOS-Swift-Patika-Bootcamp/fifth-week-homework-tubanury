//
//  NoteAddEditViewController.swift
//  BreakingBad
//
//  Created by Tuba N. Yıldız on 29.11.2022.
//

import UIKit

protocol NoteAddEditViewControllerDelegate: AnyObject {
    func savePressed(noteText: String, episode: Int, season: Int)
    func updatePressed(note: Note)
}

class NoteAddEditViewController: UIViewController{

    @IBOutlet weak var episodeTextField: UITextField!
    @IBOutlet weak var seasonTextField: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    
    weak var delegate: NoteAddEditViewControllerDelegate?
   
    var note: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteTextView.becomeFirstResponder()
        if note != nil {
            episodeTextField.text = String(note!.noteEpisode)
            seasonTextField.text = String(note!.noteSeason)
            noteTextView.text = note!.noteText
            
        }
    }
    
    @IBAction func didTappedSaveButton(_ sender: Any) {
        guard let episodeText = episodeTextField.text else {
            presentAlert(title: "", message: "Missing Episode!")
            return
        }
        guard let seasonText = seasonTextField.text else {
            presentAlert(title: "", message: "Missing Season!")
            return
        }
        guard let noteText = noteTextView.text else {
            presentAlert(title: "", message: "Missing Note!")
            return
        }
        

        if note != nil {
            note?.noteSeason = Int64(seasonText) ?? 0
            note?.noteText = noteText
            note?.noteEpisode = Int64(episodeText) ?? 0
            delegate?.updatePressed(note: self.note!)
        }
        else {
            delegate?.savePressed(noteText: noteText, episode: Int(episodeText) ?? 0, season: Int(seasonText) ?? 0)
        }
        self.navigationController?.popToRootViewController(animated: true)

    }
    
}


