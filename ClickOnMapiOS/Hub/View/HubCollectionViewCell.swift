//
//  HubCollectionViewCell.swift
//  ClickOnMapiOS
//
//  Created by Zoárd Geöcze on 20/06/2018.
//  Copyright © 2018 Zoárd Geöcze. All rights reserved.
//

import UIKit

class HubCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var systemNameLabel: UILabel!
    @IBOutlet weak var systemColorView: UIView!
    
    func configureCellFor(systemTile: SystemTile) {
        
        self.systemNameLabel.text = systemTile.vgiSystem.name
        self.systemColorView.backgroundColor = systemTile.vgiSystem.color
        
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor(red: 85.0/255.0, green: 85.0/255.0, blue: 85.0/255.0, alpha: 1).cgColor
        
        
    }
    
    func configureCellFor(addTile: AddTile) {
        
        self.systemNameLabel.text = addTile.name
        //self.systemColorView.backgroundColor
        
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor(red: 85.0/255.0, green: 85.0/255.0, blue: 85.0/255.0, alpha: 1).cgColor
        
    }
    
}
