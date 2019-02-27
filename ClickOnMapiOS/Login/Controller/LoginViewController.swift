//
//  LoginViewController.swift
//  ClickOnMapiOS
//
//  Created by Zoárd Geöcze on 02/09/2018.
//  Copyright © 2018 Zoárd Geöcze. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import Firebase
import RealmSwift

class LoginViewController : UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var systemNameLabel: UILabel!
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    
    // MARK: - Attributes
    
    var selectedVGISystem: VGISystem?
    var delegate: SystemTileDelegate?
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        
        self.hideKeyboardWhenTappedAround()
        
        if let vgiSystem = selectedVGISystem {
            systemNameLabel.text = vgiSystem.name
        }
        
        super.viewDidLoad()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    // MARK: - Web Services - Request VGISystem Categories
    
    func requestVGISystemCategoriesCompletionHandler(_ response: EventCategoryDataResponse?) {
        
        guard let responseCategories = response?.categories else {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            Alert(controller: self).showWithHandler("Sem Conexão",message: "Conecte-se à uma rede e tente novamente.",
                                                    okButtonTitle: "Tentar Novamente", cancelButtonTitle: "Cancelar",
                                                    completion: verifyUserCompletionAlert(_:))
            return
        }
        
        guard let responseData = response else {
            return
        }
        
        guard let vgiSystem = self.selectedVGISystem else {
            return
        }
        
        if (responseData.success == 1) {
            vgiSystem.set(new: responseCategories)
            vgiSystem.hasSession = true
            VGISystem.update(vgiSystem)
            self.delegate?.addTile(vgiSystem)
            navigateToHubViewController()
        } else {
            print("Log: RegisterViewController_requestVGISystemCategoriesCompletionHandler")
            Alert(controller: self).show("Cadastro Não Realizado", message: responseData.error_msg)
        }
        
    }
    
    func requestVGISystemCategories() {
        
        guard let vgiSystem = self.selectedVGISystem else {
            print("Log")
            return
        }
        
        VGISystemService(baseUrl: vgiSystem.address).requestVGISystemCategories(completionHandler: requestVGISystemCategoriesCompletionHandler(_:))
        
    }
    
    // MARK: - Web Services - Send Mobile System
    
    func sendMobyleSystemCompletionHandler(_ response: DefaultDataResponse?) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        guard (response != nil) else {
            Alert(controller: self).showWithHandler("Sem Conexão",message: "Conecte-se à uma rede e tente novamente.",
                                                    okButtonTitle: "Tentar Novamente", cancelButtonTitle: "Cancelar",
                                                    completion: verifyUserCompletionAlert(_:))
            return
        }
        
        guard let vgiSystem = self.selectedVGISystem else {
            return
        }
        
        if VGISystem.search(for: vgiSystem) != nil {
            vgiSystem.hasSession = true
            VGISystem.update(vgiSystem)
            navigateToHubViewController()
        } else {
            requestVGISystemCategories()
        }
    }
    
    func sendMobileSystem() {
        guard let vgiSystem = self.selectedVGISystem else {
            return
        }
        
        guard let fcmToken = Messaging.messaging().fcmToken else {
            return
        }
        
        VGISystemService().sendMobileSystem(systemAddress: vgiSystem.address,
                                            firebaseKey: fcmToken,
                                            completionHandler: sendMobyleSystemCompletionHandler(_:))
    }
    
    
    // MARK: - Web Services - Verify User
    
    func verifyUserCompletionAlert(_ alert: UIAlertAction) {
        verifyUser()
    }
    
    func verifyUserCompletionHandler(_ response: UserDataResponse?) {
        
        guard let user = response?.user else {
            Alert(controller: self).showWithHandler("Sem Conexão",message: "Conecte-se à uma rede e tente novamente.",
                                                    okButtonTitle: "Tentar Novamente", cancelButtonTitle: "Cancelar",
                                                    completion: verifyUserCompletionAlert(_:))
            return
        }
        guard let responseData = response else {
            return
        }

        if responseData.success == 1 {
            self.selectedVGISystem?.user = user
            sendMobileSystem()
        } else {
            Alert(controller: self).show("Login Não Realizado", message: responseData.error_msg)
        }
        
    }
    
    func verifyUser() {
        
        guard let vgiSystem = self.selectedVGISystem else {
            return
        }
        
        guard let userEmail = self.emailTextField.text else {
            return
        }
        
        guard let userPassword = self.passwordTextField.text else {
            return
        }
        
        if(userEmail != "" &&  userPassword != "") {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            UserService(baseUrl: vgiSystem.address).verifyUser(email: userEmail, password: userPassword,
                                                               completionHandler: verifyUserCompletionHandler(_:))
        } else {
            Alert(controller: self).show("Campo em Branco", message: "O campo email e senha são obrigatórios.")
        }

    }
    
    // MARK: - Navigation
    
    func navigateToHubViewController() {
        if let navigation = self.navigationController {
            navigation.popToRootViewController(animated: true)
        }
    }
    
    // MARK: - Actions
    
    @IBAction func login() {
        
        verifyUser()
        
    }
    
    @IBAction func register() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let registerController = storyboard.instantiateViewController(withIdentifier: "Register") as! RegisterViewController
        registerController.selectedVGISystem = self.selectedVGISystem
        registerController.delegate = self.delegate
        if let navigation = self.navigationController {
            navigation.pushViewController(registerController, animated: true)
        }
    }
    
    @IBAction func close() {
        navigateToHubViewController()
    }
}
















