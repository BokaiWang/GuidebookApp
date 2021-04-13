//
//  InfoViewController.swift
//  GuidebookApp
//
//  Created by 王柏凱 on 2021/3/7.
//

import UIKit

class InfoViewController: UIViewController {

    // MARK: Variables and Properties
    @IBOutlet weak var SummaryLabel: UILabel!
    
    var place:Place?
    
    // MARK: ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  
    override func viewWillAppear(_ animated: Bool) {
        SummaryLabel.text = place?.summary
    }
}
