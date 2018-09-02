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
    func configureCellFor(_ vgiSystem: VGISystem) {
        
        self.systemNameLabel.text = vgiSystem.name
        self.systemColorView.backgroundColor = vgiSystem.color
        
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor(red: 85.0/255.0, green: 85.0/255.0, blue: 85.0/255.0, alpha: 1).cgColor
        
    }
    
}
