//
//  AddSystemViewController.swift
//  ClickOnMapiOS
//
//  Created by Zoárd Geöcze on 02/09/2018.
//  Copyright © 2018 Zoárd Geöcze. All rights reserved.
//

import UIKit
import Foundation

class AddSystemViewController : UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Outlets
    
    @IBOutlet weak var systemSearchBar: UISearchBar!
    @IBOutlet weak var addSystemTableView: UITableView!
    
    // MARK: - Attributes
    
    /*let vgiSystems: Array<VGISystem> = [VGISystem(address: "192.168.1.1", name: "Cidadão Viçosa",
                                                  description: "Sistema para a Cidade de Viçosa",
                                                  color: UIColor.red, collaborations: 0, latX: 0.0, latY: 0.0, lngX: 0.0, lngY: 0.0),
                                        VGISystem(address: "192.168.1.1", name: "Gota D'agua",
                                                  description: "Sistema para evitar desperdício de água no estado de Minas Gerais",
                                                  color: UIColor.red, collaborations: 0, latX: 0.0, latY: 0.0, lngX: 0.0, lngY: 0.0)]*/
    
    var vgiSystems: Array<VGISystem> = []
    var searchList: Array<VGISystem> = []
    var delegate: AddSystemTileDelegate?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        self.addSystemTableView.dataSource = self
        self.addSystemTableView.delegate = self
        self.systemSearchBar.delegate = self
        
        self.searchList = self.vgiSystems
        
        changeSearchBarAttributes()
        requestAvailabeVGISystems()
        
        super.viewDidLoad()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    // MARK: - TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Add System Cell", for: indexPath) as! AddSystemViewCell
        let vgiSystem = self.searchList[indexPath.row]
        cell.configureCellFor(vgiSystem)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = self.searchList[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginController = storyboard.instantiateViewController(withIdentifier: "Login") as! LoginViewController
        loginController.selectedVGISystem = selected
        loginController.delegate = self.delegate
        
        navigationController?.pushViewController(loginController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? 130 : 150
    }
    
    // MARK: - Web Services
    
    func requestAvailabeVGISystemsResponse(_ response: VGISystemDataResponse?) {
        
        guard let vgiSystemsResponse = response?.vgiSystems! else {
            print("ENTROU AQUI")
            return
        }
        
        self.searchList = vgiSystemsResponse
        self.addSystemTableView.reloadData()
        
    }
    
    func requestAvailabeVGISystems() {
        
        VGISystemService().requestVGISystems(completionHandler: requestAvailabeVGISystemsResponse(_:))
        
    }
    
    // MARK: - Methods
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchList = self.vgiSystems
        if searchText != "" {
            let filteredList = self.searchList.filter { ($0.name?.lowercased().contains(searchText.lowercased()))!}
            self.searchList = filteredList
        }
        
        self.addSystemTableView.reloadData()
    }
    
    func changeSearchBarAttributes() {
        
        let textFieldInsideSearchBar = systemSearchBar.value(forKey: "searchField") as? UITextField
        
        let searchIcon = textFieldInsideSearchBar?.leftView as! UIImageView
        searchIcon.image = searchIcon.image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        searchIcon.tintColor = UIColor.white
    }
    
    // MARK: - Actions
    
    @IBAction func back() {
        navigationController?.popViewController(animated: true)
    }
 
    
}
