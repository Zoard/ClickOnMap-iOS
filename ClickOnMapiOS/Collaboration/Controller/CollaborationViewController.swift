//
//  CollaborationViewController.swift
//  ClickOnMapiOS
//
//  Created by Zoárd Geöcze on 11/09/2018.
//  Copyright © 2018 Zoárd Geöcze. All rights reserved.
//

import UIKit
import GoogleMaps

class CollaborationViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var categoriesPickerView: UIPickerView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: - Variables
    
    var selectedVGISystem: VGISystem?
    var currentLocation: CLLocation?
    var collaboration: Collaboration?
    var pickerViewData = [[EventType]]()
    var pickerRow: Int = 0
    
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        
        self.hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(raiseScroll(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillShow , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(unraiseScroll(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillHide , object: nil)
        
        self.categoriesPickerView.dataSource = self
        self.categoriesPickerView.delegate = self
        
        configurePickerData()
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Picker View
    
    func configurePickerData() {
        if let vgiSystem = self.selectedVGISystem {
            for category in vgiSystem.categories {
                print(category.categoryDescription)
                print(category.realmId)
                for subcategory in category.subcategories {
                    print(subcategory.typeDescription)
                    print(subcategory.realmId)
                }
                
            }
        } else {
            print("Nenhum sistema vgi selecionado")
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        guard let vgiSystem = selectedVGISystem else {
            return 0
        }
        
        if component == 0 {
            return vgiSystem.categories.count
        }
        
        
        return vgiSystem.categories[self.pickerRow].subcategories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        guard let vgiSystem = selectedVGISystem else {
            return ""
        }
        
        if component == 0 {
            return vgiSystem.categories[row].categoryDescription
        }
        
        return vgiSystem.categories[self.pickerRow].subcategories[row].typeDescription
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            self.pickerRow = row
        }
        
        self.categoriesPickerView.reloadComponent(1)
    }
    
    // MARK: - Methods
    
    func inputTextFieldChecker(vgiSystem: VGISystem) -> Bool {
        
        guard let title = self.titleTextField.text else {
            return false
        }
        guard let systemDescription = self.descriptionTextView.text else {
            return false
        }
        /*guard let password = self.passwordTextField.text else {
            return false
        }
        guard let passwordConfirm = self.passwordConfirmTextField.text else {
            return false
        }*/
        
        
        if (title != "" && systemDescription != "") {
            
        } else {
            Alert(controller: self).show("Campo em Branco", message: "Todos os campos são obrigatórios.")
            return false
        }
        
        guard let user = vgiSystem.user else {
            print("LOG_USER")
            return false
        }
        
        guard let location = currentLocation else {
            print("LOG_LOCATION")
            return false
        }
        
        let collab = Collaboration(collaborationId: 50, userId: user.email, userName: user.name,
                                   title: title, description: systemDescription,
                                   collaborationDate: Date().serverFormat(), categoryId: 2,
                                   categoryName: "", subcategoryId: 5, subcategoryName: "",
                                   photo: "", video: "", audio: "",
                                   latitude: String(location.coordinate.latitude),
                                   longitude: String(location.coordinate.longitude))
        
        
        self.collaboration = collab
        
        return true
    }
    
    // MARK: Web Services - Send Collaboration
    
    func successCollab(_ alert: UIAlertAction) {
        if let navigation = self.navigationController {
            navigation.popViewController(animated: true)
        }
    }
    
    func sendCollaborationCompletionHandler(_ alert: UIAlertAction) {
        sendCollaboration()
    }
    
    func sendCollaborationCompletionHandler(_ response: DefaultDataResponse?) {
        
        guard let responseData = response else {
            Alert(controller: self).showWithHandler("Sem Conexão",message: "Conecte-se à uma rede e tente novamente.",
                                                    okButtonTitle: "Tentar Novamente", cancelButtonTitle: "Cancelar",
                                                    completion: successCollab(_:))
            return
        }
        
        if (responseData.success == 1) {
            Alert(controller: self).showWithHandler("Colaboração Realizada!",
                                                    message: "Sua colaboração foi realizada com sucesso!",
                                                    okButtonTitle: "Ok", cancelButtonTitle: "",
                                                    completion: successCollab(_:))
        } else {
            Alert(controller: self).showWithHandler("Colaboração Não Realizada",
                                         message: responseData.error_msg,
                                         okButtonTitle: "Tentar Novamente", cancelButtonTitle: "Cancelar",
                                         completion: successCollab(_:))
        }
        
    }
    
    func sendCollaboration() {
        
        guard let vgiSystem = self.selectedVGISystem else {
            print("Log")
            return
        }
        
        if (inputTextFieldChecker(vgiSystem: vgiSystem)) {
            CollaborationService(baseUrl: vgiSystem.address).sendCollaboration(collaboration: self.collaboration!, completionHandler: sendCollaborationCompletionHandler(_:))
        }
        
        
    }
    
    // MARK: - Actions
    
    @objc func raiseScroll(notification: Notification) {
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.width,
                                                  height: self.scrollView.frame.height + 320)
    }
    
    @objc func unraiseScroll(notification: Notification) {
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.width,
                                             height: self.scrollView.frame.height - 320)
    }


    @IBAction func cancelCollaboration(_ sender: Any) {
        if let navigation = self.navigationController {
            navigation.popViewController(animated: true)
        }
    }
    
    @IBAction func takePicture(_ sender: UIButton) {
    }
    
    @IBAction func takeVideo(_ sender: UIButton) {
    }
    
}
