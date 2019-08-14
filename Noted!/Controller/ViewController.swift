//
//  ViewController.swift
//  Noted!
//
//  Created by Kushal Mukherjee on 26/05/19.
//  Copyright © 2019 Kushal Mukherjee. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tableViewOutlet: UITableView!
    
    var notesArray:[Note]=[]
    
    let context=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewOutlet.delegate=self
        tableViewOutlet.dataSource=self
        
        editButtonItem.action=#selector(editMethod)
        self.navigationItem.leftBarButtonItem=editButtonItem
        
        self.navigationController?.navigationBar.barTintColor=UIColor.cyan
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getNotes()
    }
    
    @objc func editMethod(){

        if(editButtonItem.title=="Edit"){

            self.tableViewOutlet.isEditing=true
            self.editButtonItem.title="Done"
        }
        else{

            self.tableViewOutlet.isEditing=false
            self.editButtonItem.title="Edit"
            
        }
        
    }
    
    
    func getNotes(){
        
        let fetchRequest:NSFetchRequest<Note>=Note.fetchRequest()
        do{
            notesArray = try context.fetch(fetchRequest)
        }
        catch{
            print("Error fetching notes :\(error)")
        }
        
        tableViewOutlet.reloadData()
        
        
    }
    
    
    
    
}

extension ViewController:UITableViewDataSource,UITableViewDelegate{
   
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell=tableViewOutlet.dequeueReusableCell(withIdentifier: "notescell", for: indexPath)
        
        if(notesArray[indexPath.row].title != ""){
        cell.textLabel?.text = notesArray[indexPath.row].title
            
        }
        else{
            cell.textLabel?.text = notesArray[indexPath.row].text
            
        }
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "newnotesegue", sender: self)
        tableViewOutlet.deselectRow(at: tableViewOutlet.indexPathForSelectedRow!, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            print("Delete rows now")
            
            let deleteNoteObj = notesArray[indexPath.row]
            context.delete(deleteNoteObj)
            do{
                try context.save()
            }
            catch{
                print("Error while saving after delete : \(error)")
            }
            
            notesArray.remove(at: indexPath.row)
            tableViewOutlet.deleteRows(at: [indexPath], with: .fade)
            
            
            
            
        }
//        tableViewOutlet.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! NewNoteViewController
        if let indexpath = tableViewOutlet.indexPathForSelectedRow{
            destinationVC.selectedNote = notesArray[indexpath.row]
        }
    }
    
    
    
    
    
}
