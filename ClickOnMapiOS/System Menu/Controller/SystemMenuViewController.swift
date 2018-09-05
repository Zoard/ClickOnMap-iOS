//
//  SystemMenuViewController.swift
//  ClickOnMapiOS
//
//  Created by Zoárd Geöcze on 04/09/18.
//  Copyright © 2018 Zoárd Geöcze. All rights reserved.
//

import UIKit

class SystemMenuViewController : UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var systemNameLabel: UILabel!
    @IBOutlet weak var systemDescriptionTextView: UITextView!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var lastCollaborationLabel: UILabel!
    
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    //MARK: - Actions
    
    @IBAction func backToHub() {
        
    }
    
    
}
