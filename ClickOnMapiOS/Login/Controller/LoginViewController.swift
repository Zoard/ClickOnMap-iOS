//
//  LoginViewController.swift
//  ClickOnMapiOS
//
//  Created by Zoárd Geöcze on 02/09/2018.
//  Copyright © 2018 Zoárd Geöcze. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class LoginViewController : UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var systemNameLabel: UILabel!
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    
    //MARK: - Attributes
    
    var selectedVGISystem: VGISystem?
    var delegate: AddSystemTileDelegate?
    
    //MAR: - View Life Cycle
    
    override func viewDidLoad() {
        
        if let vgiSystem = selectedVGISystem {
            systemNameLabel.text = vgiSystem.name
        }
        
        super.viewDidLoad()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    //MARK: - Methods
    
    
    
    //MARK: - Actions
    
    @IBAction func login() {
        //Implement
        guard let vgiSystem = self.selectedVGISystem else {
            print("Algum log")
            return
        }
        let systemTile: SystemTile = SystemTile(vgiSystem: vgiSystem, available: true)
        self.delegate?.add(systemTile)
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func register() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let registerController = storyboard.instantiateViewController(withIdentifier: "Register") as! RegisterViewController
        registerController.selectedVGISystem = self.selectedVGISystem
        navigationController?.pushViewController(registerController, animated: true)
    }
    
    @IBAction func close() {
        navigationController?.popToRootViewController(animated: true)
    }
}
















