//
//  NotesViewController.swift
//  GuidebookApp
//
//  Created by 王柏凱 on 2021/3/7.
//

import UIKit
import CoreData

class NotesViewController: UIViewController {

    // MARK: variables and properties
    var place:Place?
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var fetchedNotesRC:NSFetchedResultsController<Note>?
    
    var notes:[Note]?
        
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: viewcontroller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refresh()
    }
    
    // MARK: Methods
    
    func refresh() {
        // Check if there's a place set
        
        if let place = place {

            // Get a fetch request for the places
            let request:NSFetchRequest<Note> = Note.fetchRequest()
            
            request.predicate = NSPredicate(format: "place = %@", place)
            
            
            // Set a sort descriptor
            let sort = NSSortDescriptor(key: "date", ascending: false)
            request.sortDescriptors = [sort]

            do {
                // Create a fetched results controller
                fetchedNotesRC = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context , sectionNameKeyPath: nil, cacheName: nil)

                // Execute the fetch
                try fetchedNotesRC!.performFetch()
            }
            catch {}
            
            /*
            if let place = place {

                // Get a fetch request for the places
                let request:NSFetchRequest<Note> = Note.fetchRequest()
                
                request.predicate = NSPredicate(format: "place = %@", place)
                
                // Set a sort descriptor
                let sort = NSSortDescriptor(key: "date", ascending: false)
                request.sortDescriptors = [sort]

                do {
                    // Execute the fetch
                    notes = try context.fetch(request)
                }
                catch {}
            */

            // Tell table view to request data
            tableView.reloadData()
        }
    }
    
    

    @IBAction func addNoteTapped(_ sender: Any) {
        // Display the popup
        let addNoteVC = storyboard?.instantiateViewController(identifier: Constants.ADDNOTES_VIEWCONTROLLER) as! AddNoteViewController
        
        addNoteVC.delegate = self
        
        // Pass the place object through
        addNoteVC.place = place
        
        // Configure the popupmode
        addNoteVC.modalPresentationStyle = .overCurrentContext
        
        // Present it
        present(addNoteVC, animated: true, completion: nil)
        
    }
    
}

extension NotesViewController:AddNoteDelegate {
    func noteAdded() {
        // Refresh the notes from core data and display in tableview
        refresh()
    }
}


extension NotesViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedNotesRC?.fetchedObjects?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.NOTE_CELL, for: indexPath)

        // Get references to the labels
        let dateLabel = cell.viewWithTag(1) as! UILabel
        let noteLabel = cell.viewWithTag(2) as! UILabel

        // Get the note for this indexPath
        let note = fetchedNotesRC?.object(at: indexPath)

        if let note = note {
            let df = DateFormatter()
            df.dateFormat = "MM-dd-yyyy HH:mm"
            dateLabel.text = df.string(from: note.date!)
            noteLabel.text = note.text
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, nil) in
            
            if self.fetchedNotesRC == nil {
                return
            }
            // Get a reference to the note to be deleted
            let n = self.fetchedNotesRC!.object(at: indexPath)
            
            // Pass it to the core data context delete method
            self.context.delete(n)
            
            // Save the context
            self.appDelegate.saveContext()
            
            // Refetch results and refresh the tableview
            self.refresh()
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Display the popup
        let addNoteVC = storyboard?.instantiateViewController(identifier: Constants.ADDNOTES_VIEWCONTROLLER) as! AddNoteViewController
        
        addNoteVC.delegate = self
        
        // Pass the place object through
        addNoteVC.place = place
        
        if let place = place {

            // Get a fetch request for the places
            let request:NSFetchRequest<Note> = Note.fetchRequest()
            
            request.predicate = NSPredicate(format: "place = %@", place)
            
            // Set a sort descriptor
            let sort = NSSortDescriptor(key: "date", ascending: false)
            request.sortDescriptors = [sort]

            do {
                // Execute the fetch
                notes = try context.fetch(request)
                
                addNoteVC.note = notes![indexPath.row]
            }
            catch {}
        }
        
        // Configure the popupmode
        addNoteVC.modalPresentationStyle = .overCurrentContext
        
        // Present it
        present(addNoteVC, animated: true, completion: nil)
    }

}
