//
//  PlaceTableViewCell.swift
//  GuidebookApp
//
//  Created by 王柏凱 on 2021/3/8.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {
    // MARK: Properties
    
    @IBOutlet weak var shadowView: UIView!

    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var placeImageView: UIImageView!
    
    @IBOutlet weak var placeNameLabel: UILabel!
    
    
    
    // MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Style the cell background
        cardView.layer.cornerRadius = 5
        shadowView.layer.cornerRadius = 5
        shadowView.layer.shadowColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.5)
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowOffset = .zero
        shadowView.layer.shadowRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    // MARK: Methods
    
    func setCell(p:Place) {
        // Set the image
        if p.imageName != nil {
            self.placeImageView.image = UIImage(named: p.imageName!)
        }
        
        // Set the label
        self.placeNameLabel.text = p.name
    }

}
