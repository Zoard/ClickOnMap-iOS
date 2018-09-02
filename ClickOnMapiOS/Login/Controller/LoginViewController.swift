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
    
    @IBOutlet weak var systemNameLabel: UILabel!
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
    }
    
    @IBAction func login() {
        
    }
    
    @IBAction func register() {
    }
    
}
