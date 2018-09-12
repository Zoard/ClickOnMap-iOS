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
    
    //MARK: - Attributes
    
    var selectedVGISystem: VGISystem?
    
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        
        configureLayout()
        
        super.viewDidLoad()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    //MARK: - Methods
    
    func configureLayout() {
        
        guard let vgiSystem = selectedVGISystem else {
            print("Algum erro para o Log")
            return
        }
        
        self.systemNameLabel.text = vgiSystem.name
        self.systemDescriptionTextView.text = vgiSystem.description
        self.latitudeLabel.text = String(vgiSystem.latX)
        self.longitudeLabel.text = String(vgiSystem.lngX)
        self.locationLabel.text = "Viçosa/MG"
        self.lastCollaborationLabel.text = "07/09/2018"
        
    }
    
    //MARK: - Actions
    
    @IBAction func backToHub() {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    
}
