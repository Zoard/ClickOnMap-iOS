//
//  PendingCollaborationsTableViewCell.swift
//  ClickOnMapiOS
//
//  Created by Zoárd Geöcze on 05/09/2018.
//  Copyright © 2018 Zoárd Geöcze. All rights reserved.
//

import UIKit
import SwipeCellKit

class PendingCollaborationsTableViewCell: SwipeTableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var collaborationTitleLabel: UILabel!
    @IBOutlet weak var collaborationTimeLabel: UILabel!
    @IBOutlet weak var photoIcon: UIImageView!
    @IBOutlet weak var videoIcon: UIImageView!
    
    // MARK: - Methods
    
    func configureCell(for collaboration: Collaboration) {
        
        self.collaborationTitleLabel.text = collaboration.title
        self.collaborationTimeLabel.text = Date().appFormat(collaboration.collaborationDate)
        
        print("Collaboration Photo: \(collaboration.photo)")
        print("Collaboration Video: \(collaboration.video)")
        
        if collaboration.photo != "" {
            self.photoIcon.image = UIImage(named: "ic_photo_on")
        } else {
            self.photoIcon.image = UIImage(named: "ic_photo_off")
        }
        
        if collaboration.video != "" {
            self.videoIcon.image = UIImage(named: "ic_video_on")
        } else {
            self.videoIcon.image = UIImage(named: "ic_video_off")
        }
        
    }
    

}
