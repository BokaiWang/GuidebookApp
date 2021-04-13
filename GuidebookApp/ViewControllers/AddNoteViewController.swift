//
//  AddNoteViewController.swift
//  GuidebookApp
//
//  Created by 王柏凱 on 2021/3/8.
//

import UIKit
import CoreData

protocol AddNoteDelegate {
    func noteAdded()
}

class AddNoteViewController: UIViewController {
    // MARK: variables and properties
    var delegate:AddNoteDelegate?
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   
    @IBOutlet weak var CardView: UIView!
    
    
    @IBOutlet weak var textView: UITextView!
    
    var place:Place?
    
    var note:Note?
    
    
    // MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        CardView.layer.cornerRadius = 5
        CardView.layer.cornerRadius = 5
        CardView.layer.shadowColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.5)
        CardView.layer.shadowOpacity = 1
        CardView.layer.shadowOffset = .zero
        CardView.layer.shadowRadius = 5
        
        textView.text = note?.text
    }

    // MARK: Methods
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        
        // Existing note
        if textView.text != nil {
            note?.date = Date()
            note?.text = textView.text
            note?.place = place
            
            // Save the core data context
            appDelegate.saveContext()
            
            // Let the delegate know that the note was added
            delegate?.noteAdded()
        }
        
        else {
            // Create a new note
            // Configure the properties
            let n = Note(context: context)
            n.date = Date()
            n.text = textView.text
            n.place = place
            
            // Save the core data context
            appDelegate.saveContext()
            
            // Let the delegate know that the note was added
            delegate?.noteAdded()
        }
        
        
        
        dismiss(animated: true, completion: nil)
    }
    
}
