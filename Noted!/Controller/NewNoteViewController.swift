//
//  NewNoteViewController.swift
//  Noted!
//
//  Created by Kushal Mukherjee on 26/05/19.
//  Copyright © 2019 Kushal Mukherjee. All rights reserved.
//

import UIKit
import CoreData


class NewNoteViewController: UIViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var titleOutlet: UITextField!
    
    
    @IBOutlet weak var textOutlet: UITextView!
    
    
    var selectedNote:Note?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
        let saveButton=UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveNote))
        
        let shareButton=UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareNote))
//        self.navigationItem.rightBarButtonItem=saveButton
        
        self.navigationItem.rightBarButtonItems = [saveButton,shareButton]
        
   
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let note = selectedNote{
            self.titleOutlet.text = note.title
            self.textOutlet.text = note.text
            
        }
    }
    
    //MARK: - share note method
    
    @objc func shareNote(){
        
        let noteText = selectedNote?.text
        let activityVC=UIActivityViewController(activityItems: [noteText as Any], applicationActivities: nil)
        
        present(activityVC, animated: true, completion: nil)
        
        
        
        
        
    }
    
    
    //MARK: - save note method
    @objc func saveNote(){
        var newNoteObj : Note?
        if(selectedNote == nil){
            newNoteObj=Note(context: context)
        }
        else{
            newNoteObj=selectedNote
        }
        
        if(titleOutlet.text?.count == 0 && textOutlet.text.count == 0){
            self.navigationController?.popViewController(animated: true)
            deleteNote(note: newNoteObj!)
            
        }
        else{
            
            newNoteObj?.title=titleOutlet.text
            newNoteObj?.text=textOutlet.text
            
            do{
            try context.save()
                print("Note saved")
                
            }
            catch{
                print("Error saving note :\(error)")
            }
            self.navigationController?.popViewController(animated: true)
        }
        
        
        
    }
    
    //    MARK:- Delete note
    
    func deleteNote(note:Note){
        context.delete(note)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.textOutlet.resignFirstResponder()
        self.titleOutlet.resignFirstResponder()
    }
    
    
    
    
    
    
}
