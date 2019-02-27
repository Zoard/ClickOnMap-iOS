//
//  RegisterViewController.swift
//  ClickOnMapiOS
//
//  Created by Zoárd Geöcze on 02/09/2018.
//  Copyright © 2018 Zoárd Geöcze. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import Firebase


class RegisterViewController : UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var usernameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordConfirmTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var formScrollView: UIScrollView!
    
    
    // MARK: - Attributes
    
    var selectedVGISystem: VGISystem?
    var delegate: SystemTileDelegate?
    var registeredUser: User?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        
        self.hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(raiseScroll(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillShow , object: nil)
        
        super.viewDidLoad()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    // MARK: - Methods
    
    func inputTextFieldChecker() -> Bool {
        
        guard let userName = self.usernameTextField.text else {
            return false
        }
        guard let email = self.emailTextField.text else {
            return false
        }
        guard let password = self.passwordTextField.text else {
            return false
        }
        guard let passwordConfirm = self.passwordConfirmTextField.text else {
            return false
        }
        
        if (userName != "" && email != "" && password != "" && passwordConfirm != "") {
            if (password != passwordConfirm) {
                Alert(controller: self).show("Senhas Não Conferem",
                                             message: "Os campos 'Senha' e 'Confirmação de Senha' possuem valores diferentes.")
            }
        } else {
            Alert(controller: self).show("Campo em Branco", message: "Todos os campos são obrigatórios.")
            return false
        }
        
        let chekedUser = User()
        chekedUser.setAttributes(id: email, email: email, name: userName, password: password, type: "C",
                            registerDate: Date().serverFormat())
        
        self.registeredUser = chekedUser

        return true
    }
    
    // MARK: - Web Services - Send Mobile System
    
    func sendMobyleSystemCompletionHandler(_ response: DefaultDataResponse?) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        guard (response != nil) else {
            Alert(controller: self).showWithHandler("Sem Conexão",message: "Conecte-se à uma rede e tente novamente.",
                                                    okButtonTitle: "Tentar Novamente", cancelButtonTitle: "Cancelar",
                                                    completion: sendUserCompletionAlert(_:))
            return
        }
        
        guard let vgiSystem = self.selectedVGISystem else {
            print("Log")
            return
        }
        
        guard let user = self.registeredUser else {
            print("Log")
            return
        }
        
        vgiSystem.user = user
        vgiSystem.hasSession = true
        self.delegate?.addTile(vgiSystem)
        
        if let navigation = self.navigationController {
            navigation.popToRootViewController(animated: true)
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
    
    // MARK: - Web Services - Request VGISystem Categories
    
    func requestVGISystemCategoriesCompletionHandler(_ response: EventCategoryDataResponse?) {
        
        guard let responseCategories = response?.categories else {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            Alert(controller: self).showWithHandler("Sem Conexão",message: "Conecte-se à uma rede e tente novamente.",
                                                    okButtonTitle: "Tentar Novamente", cancelButtonTitle: "Cancelar",
                                                    completion: sendUserCompletionAlert(_:))
            return
        }
        
        guard let responseData = response else {
            return
        }
        
        if (responseData.success == 1) {
            self.selectedVGISystem?.set(new: responseCategories)            
            sendMobileSystem()
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
    
    // MARK: - Web Services - Send User
    
    func sendUserCompletionAlert(_ alert: UIAlertAction) {
        sendUser()
    }
    
    func sendUserCompletionHandler(_ response: DefaultDataResponse?) {
        
        guard let responseData = response else {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            Alert(controller: self).showWithHandler("Sem Conexão",message: "Conecte-se à uma rede e tente novamente.",
                                                    okButtonTitle: "Tentar Novamente", cancelButtonTitle: "Cancelar",
                                                    completion: sendUserCompletionAlert(_:))
            return
        }
        
        if (responseData.success == 1) {
            requestVGISystemCategories()
        } else {
            print(responseData.error)
            print(responseData.error_msg)
            Alert(controller: self).show("Cadastro Não Realizado", message: responseData.error_msg)
        }
        
    }
    
    func sendUser() {
        
        guard let vgiSystem = self.selectedVGISystem else {
            print("Log")
            return
        }
        
        if(inputTextFieldChecker()) {
            
            guard let user = self.registeredUser else {
                print("Log")
                return
            }
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            UserService(baseUrl: vgiSystem.address).sendUser(user: user,
                                                             completionHandler: sendUserCompletionHandler(_:))
        }
       
        
    }
    
    // MARK: - Actions
    
    @objc func raiseScroll(notification: Notification) {
        self.formScrollView.contentSize = CGSize(width: self.formScrollView.frame.width,
                                             height: self.formScrollView.frame.height + 320)
    }
    
    @IBAction func register() {
        sendUser()
    }
    
    @IBAction func login() {
        if let navigation = self.navigationController {
            navigation.popViewController(animated: true)
        }
    }
    
    
}
