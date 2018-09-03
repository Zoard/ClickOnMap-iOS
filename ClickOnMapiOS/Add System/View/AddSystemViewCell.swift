//
//  AddSystemViewCell.swift
//  ClickOnMapiOS
//
//  Created by Zoárd Geöcze on 02/09/2018.
//  Copyright © 2018 Zoárd Geöcze. All rights reserved.
//

import UIKit

class AddSystemViewCell : UITableViewCell {
    
    @IBOutlet weak var systemNameLabel: UILabel!
    @IBOutlet weak var systemDescriptionTextView: UITextView!
    
    func configureCellFor(_ vgiSystem: VGISystem) {
        
        self.systemNameLabel.text = vgiSystem.name
        self.systemDescriptionTextView.text = vgiSystem.description
        
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor(red: 85.0/255.0, green: 85.0/255.0, blue: 85.0/255.0, alpha: 1).cgColor
        
    }
    
    
}
