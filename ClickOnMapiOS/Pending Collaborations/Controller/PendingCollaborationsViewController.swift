//
//  PendingCollaborationsViewController.swift
//  ClickOnMapiOS
//
//  Created by Zoárd Geöcze on 05/09/2018.
//  Copyright © 2018 Zoárd Geöcze. All rights reserved.
//

import UIKit
import SwipeCellKit

class PendingCollaborationsViewController: UIViewController, UITableViewDataSource,
    UITableViewDelegate, SwipeTableViewCellDelegate  {
    
    // MARK: - Outlets
    
    @IBOutlet weak var pendingCollaborationsTableView: UITableView!
    
    // MARK: - Variables
    
    var selectedVGISystem: VGISystem?
    var collaborations: Array<Collaboration> = []
    var selectedIndexPath: IndexPath?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pendingCollaborationsTableView.dataSource = self
        self.pendingCollaborationsTableView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        populateCollaborations()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.collaborations.removeAll()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Methods
    
    func populateCollaborations() {
        let realmCollaborations = Collaboration.all()
        print("Pending Collaborations Counter: \(realmCollaborations.count)")
        
        if realmCollaborations.isEmpty {
            self.collaborations.removeAll()
        } else {
            for collaboration in realmCollaborations {
                self.collaborations.append(collaboration)
            }
        }
        
        self.pendingCollaborationsTableView.reloadData()
    }
    
    func editCollaboration() {
        
        guard let indexPath = self.selectedIndexPath else {
            return
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let collaborationViewController = storyboard.instantiateViewController(withIdentifier: "Collaboration") as! CollaborationViewController
        if let navigation = self.navigationController {
            collaborationViewController.selectedVGISystem = self.selectedVGISystem
            collaborationViewController.selectedPendingCollaboration = self.collaborations[indexPath.row]
            navigation.pushViewController(collaborationViewController, animated: true)
        }
        
    }
    
    func deleteCollabHandler(_ alert: UIAlertAction) {
        guard let indexPath = self.selectedIndexPath else {
            return
        }
        
        let collaboration = self.collaborations[indexPath.row]
        Collaboration.delete(collaboration)
        self.collaborations.remove(at: indexPath.row)
        self.pendingCollaborationsTableView.reloadData()
    }
    
    func deleteCollaboration() {
        let delete = UIAlertAction(title: AlertActions.delete.rawValue, style: .destructive, handler: deleteCollabHandler)
        let cancel = UIAlertAction(title: AlertActions.cancel.rawValue, style: .cancel, handler: nil)
        Alert(controller: self).showWithHandler("Deletar Colaboração Pendente",
                                                message: "Você deseja deletar essa colaboração pendente?",
                                                firstAction: delete, secondAction: cancel)
    }
    
    // MARK: - TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.collaborations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pendingCollabCell", for: indexPath) as! PendingCollaborationsTableViewCell
        cell.delegate = self
        
        let collaboration = self.collaborations[indexPath.row]
        cell.configureCell(for: collaboration)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath,
                   for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }
        
        self.selectedIndexPath = indexPath
        
        let sendAction = SwipeAction(style: SwipeActionStyle.default, title: "Enviar") { action, indexPath in
            self.sendCollaboration()
            print("Send")
        }
        
        let editAction = SwipeAction(style: SwipeActionStyle.default, title: "Editar") { action, indexPath in
            self.editCollaboration()
            print("Edit")
        }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Deletar") { action, indexPath in
            self.deleteCollaboration()
            print("Delete")
        }
        
        // customize the action appearance
        sendAction.backgroundColor = UIColor(named: "Colors/ComapDarkGreen")
        sendAction.image = UIImage(named: "ic_upload")?.af_imageScaled(to: CGSize(width: 35, height: 22))
        editAction.backgroundColor = UIColor.gray
        editAction.image = UIImage(named: "ic_edit")?.af_imageScaled(to: CGSize(width: 30, height: 30))
        deleteAction.image = UIImage(named: "ic_delete")?.af_imageScaled(to: CGSize(width: 25, height: 25))

        return [deleteAction, editAction, sendAction]
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? 67 : 150
    }
    
    // MARK: - Web Services - Send Collaboration
    
    func sendCollaborationCompletionHandler(_ response: DefaultDataResponse?) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        guard let responseData = response else {
            let ok = UIAlertAction(title: AlertActions.ok.rawValue, style: .default, handler: nil)
            Alert(controller: self).showWithHandler("Sem Conexão",
                                                    message: "Conecte-se à uma rede para tentar novamente.",
                                                    firstAction: ok)
            return
        }
        
        if (responseData.success == 1) {
            let ok = UIAlertAction(title: AlertActions.ok.rawValue, style: .default, handler: deleteCollabHandler)
            Alert(controller: self).showWithHandler("Colaboração Realizada!",
                                                    message: "Sua colaboração foi enviada com sucesso!",
                                                    firstAction: ok)
        } else {
            let understood = UIAlertAction(title: AlertActions.understood.rawValue, style: .default, handler: nil)
            Alert(controller: self).showWithHandler("Colaboração Não Realizada",
                                                    message: "Não foi possível realizar a colaboração. Tente alterar a categoria ou subcategoria da sua colaboração pendente.",
                                                    firstAction: understood)
        }
        
    }
    
    func sendCollaboration() {
        
        guard let vgiSystem = self.selectedVGISystem else {
            return
        }
        
        guard let indexPath = self.selectedIndexPath else {
            return
        }
        
        let collaboration = self.collaborations[indexPath.row]
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        CollaborationService(baseUrl: vgiSystem.address).sendCollaboration(collaboration: collaboration, completionHandler: sendCollaborationCompletionHandler)
    }
    
    // MARK: - Actions
    
    func deleteAllHandler(_ alert: UIAlertAction) {
        
        switch alert.title {
        case AlertActions.ok.rawValue:
            break
        case AlertActions.cancel.rawValue:
            break
        case AlertActions.delete.rawValue:
            Collaboration.deleteAll()
            populateCollaborations()
            break
        default:
            break
        }
        
    }
    
    
    @IBAction func deleteAll(_ sender: UIBarButtonItem) {
        
        if self.collaborations.isEmpty {
            let ok = UIAlertAction(title: AlertActions.ok.rawValue,
                                       style: .cancel, handler: deleteAllHandler)
            Alert(controller: self).showWithHandler("Nenhuma Colaboração Pendente",
                                                    message: "Você não possui qualquer colaboração pendente para deletá-la",
                                                    firstAction: ok)
            
        } else {
            let cancel = UIAlertAction(title: AlertActions.cancel.rawValue,
                                       style: .cancel, handler: deleteAllHandler)
            let delete = UIAlertAction(title: AlertActions.delete.rawValue,
                                       style: .destructive, handler: deleteAllHandler)
            
            
            Alert(controller: self).showWithHandler("Deletar Todas as Colaborações",
                                                    message: "Você tem certeza que deseja deletar todas as colaborações pendentes?",
                                                    firstAction: cancel, secondAction: delete)
        }
        
    }
    

}
