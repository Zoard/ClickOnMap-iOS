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
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var videoButton: UIButton!
    @IBOutlet weak var collaborateButton: UIButton!
    
    // MARK: - Variables
    
    var selectedVGISystem: VGISystem?
    var currentLocation: CLLocation?
    var collaboration: Collaboration?
    var selectedPendingCollaboration: Collaboration?
    var categoryPickerRow: Int = 0
    var subcategoryPickerRow: Int = 0
    
    
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
        
        if let pendingCollab = self.selectedPendingCollaboration {
            configureLayout(for: pendingCollab)
        }
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Methods
    
    func configureLayout(for pendingCollab: Collaboration) {
        
        self.titleTextField.text = pendingCollab.title
        self.descriptionTextView.text = pendingCollab.collaborationDescription
        
        if pendingCollab.photo != "" {
            self.photoButton.imageView?.image = UIImage(named: "ic_photo_on")
        } else {
            self.photoButton.imageView?.image = UIImage(named: "ic_photo_off")
        }
        
        if pendingCollab.video != "" {
            self.videoButton.imageView?.image = UIImage(named: "ic_video_on")
        } else {
            self.videoButton.imageView?.image = UIImage(named: "ic_video_off")
        }
        
        self.collaborateButton.titleLabel?.text = "Salvar Edição"
    }
    
    //TODO: ADD PHOTO AND VIDEO OPTIONS IN HERE
    func inputTextFieldChecker(vgiSystem: VGISystem) -> Bool {
        
        guard let title = self.titleTextField.text else {
            return false
        }
        guard let collabDescription = self.descriptionTextView.text else {
            return false
        }
        
        if (title != "" && collabDescription != "") {
            
        } else {
            Alert(controller: self).show("Campo em Branco", message: "Todos os campos (*) são obrigatórios.")
            return false
        }
        
        let category = vgiSystem.categories[self.categoryPickerRow]
        let categoryId = Int(category.id)!
        let categoryName = category.categoryDescription
        let subcategories = category.subcategories
        var subcategoryId = 0
        var subcategoryName = ""
        if !subcategories.isEmpty {
            subcategoryId = Int(subcategories[self.subcategoryPickerRow].id)!
            subcategoryName = subcategories[self.subcategoryPickerRow].typeDescription
        }
        
        let collab = Collaboration()
        
        if let pendingCollab = self.selectedPendingCollaboration {
            
            collab.set(realmId: pendingCollab.realmId, userId: pendingCollab.userId, userName: pendingCollab.userName,
                       title: title, collabDescription: collabDescription,
                       collaborationDate: pendingCollab.collaborationDate, categoryId: categoryId,
                       categoryName: categoryName,
                       subcategoryId: subcategoryId, subcategoryName: subcategoryName,
                       photo: pendingCollab.photo, video: pendingCollab.video, audio: "",
                       latitude: pendingCollab.latitude, longitude: pendingCollab.longitude)
            
        } else {
            guard let user = vgiSystem.user else {
                print("LOG_USER")
                return false
            }
            
            guard let location = currentLocation else {
                print("LOG_LOCATION")
                return false
            }
            
            collab.set(realmId: UUID().uuidString, userId: user.email, userName: user.name,
                       title: title, collabDescription: collabDescription,
                       collaborationDate: Date().serverFormat(), categoryId: categoryId,
                       categoryName: categoryName,
                       subcategoryId: subcategoryId, subcategoryName: subcategoryName,
                       photo: "", video: "", audio: "",
                       latitude: String(location.coordinate.latitude),
                       longitude: String(location.coordinate.longitude))
            
            
            
        }
        
        self.collaboration = collab
        
        return true
    }
    
    func saveCollaboration(_ alert: UIAlertAction) {
        guard let pendingCollab = self.selectedPendingCollaboration else {
            return
        }
        
        guard let editedCollab = self.collaboration else {
            return
        }
        
        Collaboration.update(editedCollab)
        if let navigation = self.navigationController {
            navigation.popViewController(animated: true)
        }
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
        
        
        return vgiSystem.categories[self.categoryPickerRow].subcategories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        guard let vgiSystem = selectedVGISystem else {
            return ""
        }
        
        if component == 0 {
            return vgiSystem.categories[row].categoryDescription
        }
        
        return vgiSystem.categories[self.categoryPickerRow].subcategories[row].typeDescription
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            self.categoryPickerRow = row
        }
        
        self.subcategoryPickerRow = row
        
        self.categoriesPickerView.reloadComponent(1)
    }
    
    
    // MARK: - Web Services - Send Collaboration
    
    func failedCollab(_ alert: UIAlertAction) {
        
        switch alert.title {
        case AlertActions.tryAgain.rawValue:
            sendCollaboration()
            break
        case AlertActions.save.rawValue:
            guard let collab = self.collaboration else {
                return
            }
            Collaboration.add(new: collab)
            let ok = UIAlertAction(title: AlertActions.ok.rawValue, style: .default, handler: successCollab)
            Alert(controller: self).showWithHandler("Colaboração Salva",
                                                    message: "Sua colaboração foi salva com sucesso e pode ser vista na sua lista de colaborações pendentes",
                                                    firstAction: ok)
            break
        default:
            break
        }
        
        
    }
    
    func successCollab(_ alert: UIAlertAction) {
        if let navigation = self.navigationController {
            navigation.popViewController(animated: true)
        }
    }
    
    func sendCollaborationCompletionHandler(_ alert: UIAlertAction) {
        sendCollaboration()
    }
    
    func sendCollaborationCompletionHandler(_ response: DefaultDataResponse?) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        guard let responseData = response else {
            
            let tryAgain = UIAlertAction(title: AlertActions.tryAgain.rawValue, style: .default, handler: failedCollab)
            let save = UIAlertAction(title: AlertActions.save.rawValue, style: .default, handler: failedCollab)
            let cancel = UIAlertAction(title: AlertActions.cancel.rawValue, style: .destructive, handler: nil)
            Alert(controller: self).showWithHandler("Sem Conexão",
                                                    message: "Conecte-se à uma rede para tentar novamente ou salve sua colaboração para enviá-la mais tarde.",
                                                    firstAction: tryAgain, secondAction: save,
                                                    thirdAction: cancel)
            return
        }
        
        if (responseData.success == 1) {
            Alert(controller: self).showWithHandler("Colaboração Realizada!",
                                                    message: "Sua colaboração foi realizada com sucesso!",
                                                    okButtonTitle: "Ok", cancelButtonTitle: "",
                                                    completion: successCollab)
        } else {
            Alert(controller: self).showWithHandler("Colaboração Não Realizada",
                                         message: responseData.error_msg,
                                         okButtonTitle: "Tentar Novamente", cancelButtonTitle: "Cancelar",
                                         completion: successCollab)
        }
        
    }
    
    func sendCollaboration() {
        
        guard let vgiSystem = self.selectedVGISystem else {
            print("Log")
            return
        }
        
        if (inputTextFieldChecker(vgiSystem: vgiSystem)) {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            CollaborationService(baseUrl: vgiSystem.address).sendCollaboration(collaboration: self.collaboration!, completionHandler: sendCollaborationCompletionHandler)
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
    
    @IBAction func collaborate(_ sender: UIButton) {
        
        guard let vgiSystem = self.selectedVGISystem else {
            print("Error in Collaborate")
            return
        }
        
        if inputTextFieldChecker(vgiSystem: vgiSystem) {
            
            if self.selectedPendingCollaboration != nil {
                let save = UIAlertAction(title: AlertActions.save.rawValue, style: .default, handler: saveCollaboration)
                let cancel = UIAlertAction(title: AlertActions.cancel.rawValue, style: .cancel, handler: nil)
                Alert(controller: self).showWithHandler("Salvar Colaboração Editada", message: "Clique em salvar para confirmar a edição da colaboração.", firstAction: save, secondAction: cancel)
            } else {
                sendCollaboration()
            }
        }
    }
    
    
}
