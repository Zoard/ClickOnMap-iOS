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
    @IBOutlet weak var collaborateButton: UIButton!
    
    //MARK: - Attributes
    
    var selectedVGISystem: VGISystem?
    
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        
        configureLayout()
        
        if let vgiSystem = selectedVGISystem {
            print(vgiSystem.address)
        } else {
            print("Nenhum sistema vgi selecionado em SystemMenuViewController")
        }
        
        super.viewDidLoad()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    //MARK: - Methods
    
    func configureLayout() {
        
        collaborateButton.layer.shadowColor = UIColor.black.cgColor
        collaborateButton.layer.shadowOffset = CGSize(width: 3, height: 3)
        collaborateButton.layer.shadowRadius = 3
        collaborateButton.layer.shadowOpacity = 0.8
        
        guard let vgiSystem = self.selectedVGISystem else {
            print("Algum erro para o Log")
            return
        }
                
        self.systemNameLabel.text = vgiSystem.name
        self.systemDescriptionTextView.text = vgiSystem.systemDescription + "."
        self.latitudeLabel.text = String(-20.7546)
        self.longitudeLabel.text = String(-42.8825)
        self.locationLabel.text = "Viçosa/MG"
        self.lastCollaborationLabel.text = "28/11/2018"
        
    }
    
    //MARK: - Actions
    
    @IBAction func backToHub() {
        if let navigation = self.navigationController {
            navigation.popViewController(animated: true)
        }
    }
    
    @IBAction func collaborate(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let collabViewController = storyboard.instantiateViewController(withIdentifier: "Collaboration") as! CollaborationViewController
        if let navigation = self.navigationController {
            collabViewController.selectedVGISystem = self.selectedVGISystem
            navigation.pushViewController(collabViewController, animated: true)
        }
    }
    
}
