//
//  PlaceViewController.swift
//  GuidebookApp
//
//  Created by 王柏凱 on 2021/3/7.
//

import UIKit

class PlaceViewController: UIViewController {
    
    // MARK: Variables and Properties
    var place:Place?
    
    @IBOutlet weak var placeImageView: UIImageView!
    
    @IBOutlet weak var placeNameLabel: UILabel!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var containerView: UIView!
    
    lazy var infoViewController:InfoViewController = {
        
        let infoVC = self.storyboard?.instantiateViewController(identifier: Constants.INFO_VIEWCONTROLLER) as! InfoViewController
        return infoVC
    }()
    
    lazy var mapViewController:MapViewController = {
        
        let mapVC = self.storyboard?.instantiateViewController(identifier: Constants.MAP_VIEWCONTROLLER) as! MapViewController
        return mapVC
    }()
    
    lazy var notesViewController:NotesViewController = {
        
        let notesVC = self.storyboard?.instantiateViewController(identifier: Constants.NOTES_VIEWCONTROLLER) as! NotesViewController
        return notesVC
    }()
    
    // MARK: ViewController lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        
        if place?.imageName != nil {
            // Set the image
            placeImageView.image = UIImage(named: place!.imageName!)
        }
        // Set the name
        placeNameLabel.text = place?.name
        
        // Make sure the first segment is displayed
        segmentChanged(self.segmentedControl)
    }
    
    // MARK: Methods
    
    private func switchChildViewControllers(childVC:UIViewController) {
        // Add it as a child view cotnroller of this one
        addChild(childVC)
        
        // Add its view as a subview of the container view
        containerView.addSubview(childVC.view)
        
        // Set its frame and sizing
        childVC.view.frame = containerView.bounds
        childVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Indicate that it's now a child view controller
        childVC.didMove(toParent: self)
    }

    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            infoViewController.place = self.place
            switchChildViewControllers(childVC: infoViewController)
        case 1:
            mapViewController.place = self.place
            switchChildViewControllers(childVC: mapViewController)
        case 2:
            notesViewController.place = self.place
            switchChildViewControllers(childVC: notesViewController)
        default:
            switchChildViewControllers(childVC: infoViewController)
        }
        
    }
}
