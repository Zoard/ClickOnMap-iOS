//
//  RegisterViewController.swift
//  ClickOnMapiOS
//
//  Created by Zoárd Geöcze on 02/09/2018.
//  Copyright © 2018 Zoárd Geöcze. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField


class RegisterViewController : UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var usernameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordConfirmTextField: SkyFloatingLabelTextField!
    
    //MARK: - Attributes
    
    var selectedVGISystem: VGISystem?
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    
    //MARK: - Actions
    
    @IBAction func register() {
        //Implement
    }
    
    @IBAction func login() {
        navigationController?.popViewController(animated: true)
    }
    
    
}
