//
//  HubViewController.swift
//  ClickOnMapiOS
//
//  Created by Zoárd Geöcze on 02/06/2018.
//  Copyright © 2018 Zoárd Geöcze. All rights reserved.
//

import UIKit
import PopMenu

class HubViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, SystemTileDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet weak var hubCollectionView: UICollectionView!
    
    // MARK: - Attributes
    
    var tiles: Array<Tile> = []
    let popMenuManager = PopMenuManager.default
    var longPressTileSelected: SystemTile?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        hubCollectionView.dataSource = self
        hubCollectionView.delegate = self
        
        let collectionViewLongPressGesture = UILongPressGestureRecognizer(target: self,
                                                                          action: #selector(collectionViewLongPress(gesture:)))
        collectionViewLongPressGesture.minimumPressDuration = 0.5
        collectionViewLongPressGesture.delaysTouchesBegan = true
        
        popMenuManager.popMenuShouldDismissOnSelection = true
        configurePopMenuActions()
        
        self.hubCollectionView.addGestureRecognizer(collectionViewLongPressGesture)
        // Do any additional setup after loading the view, typically from a nib.
        updateHubTiles()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    // MARK: - Collection View
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tiles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Hub Cell", for: indexPath) as! HubCollectionViewCell
        let tile = self.tiles[indexPath.row]
        
        if tile is AddTile {
            cell.configureCellFor(addTile: tile as! AddTile)
        } else {
            cell.configureCellFor(systemTile: tile as! SystemTile)
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tile = self.tiles[indexPath.row]
        
        if tile is AddTile {
            addSystemNavigate()
        } else {
            let systemTile = tile as! SystemTile
            if systemTile.available {
                systemMenuNavigate(to: systemTile)
            } else {
                loginNavigate()
            }
            
        }
        
    }
    
    @objc func collectionViewLongPress(gesture: UILongPressGestureRecognizer) {
        
        if gesture.state == .recognized {
            return
        }
        
        let p = gesture.location(in: self.hubCollectionView)
        
        if let indexPath = self.hubCollectionView.indexPathForItem(at: p) {
            // get the cell at indexPath (the one you long pressed)
            let cell = self.hubCollectionView.cellForItem(at: indexPath) as! HubCollectionViewCell
            // do stuff with the cell
            let tile = self.tiles[indexPath.row]
            
            if tile is SystemTile {
                self.longPressTileSelected = tile as? SystemTile
                self.popMenuManager.present(sourceView: cell)
            }
            
            print("Hub Collection View Index Path: \(indexPath)")
        } else {
            print("couldn't find index path")
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return UIDevice.current.userInterfaceIdiom == .phone ? CGSize(width: collectionView.bounds.width/2, height: 160) : CGSize(width: collectionView.bounds.width/2, height: 250)
    }
    
    // MARK: - Pop Menu
    
    func configurePopMenuActions() {
        
        let sync = PopMenuDefaultAction(title: "Sincronizar", image: UIImage(named: "ic_sync"), didSelect: {action in
            self.popMenuSync()
        })
        let remove = PopMenuDefaultAction(title: "Remover", image: UIImage(named: "ic_trash"), didSelect: { action in
            self.popMenuRemove()
        })
        
        self.popMenuManager.addAction(sync)
        self.popMenuManager.addAction(remove)
        
    }
    
    func syncCompletionHandler(action: UIAlertAction) {
        
        guard let vgiSystem = self.longPressTileSelected?.vgiSystem else {
            print("No VGISystem Selected")
            return
        }
        
    }
    
    func removeCompletionHandler(action: UIAlertAction) {
        
        
    }
    
    func popMenuSync() {
        Alert(controller: self).showWithHandler(cancelButtonTitle: "Cancelar", completion: syncCompletionHandler)
        
        print("Sync")
    }
    
    func popMenuRemove() {
        Alert(controller: self).showWithHandler(cancelButtonTitle: "Cancelar", completion: removeCompletionHandler)
        guard let vgiSystem = self.longPressTileSelected?.vgiSystem else {
            print("No VGISystem Selected")
            return
        }
        
        deleteTile(vgiSystem)
        
        let categories = EventCategory.all()
        print("Categories Counter: \(categories.count)")
        
        print("Remove")
    }
    
    // MARK: - Methods
    
    func addSystemNavigate() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let addSystemcontroller = storyboard.instantiateViewController(withIdentifier: "AddSystem") as! AddSystemViewController
        addSystemcontroller.delegate = self
        if let navigation = self.navigationController {
            navigation.pushViewController(addSystemcontroller, animated: true)
        }
    }
    
    func systemMenuNavigate(to systemTile: SystemTile) {
        
        let vgiSystem = VGISystem.search(for: systemTile.vgiSystem)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let menuController = storyboard.instantiateViewController(withIdentifier: "VGISystem") as! UITabBarController
        if let systemMenuViewController = menuController.viewControllers![0] as? SystemMenuViewController {
            systemMenuViewController.selectedVGISystem = vgiSystem
        }
        if let mapViewController = menuController.viewControllers![1] as? MapViewController {
            mapViewController.selectedVGISystem = vgiSystem
        }
        if let pendingCollabsViewController = menuController.viewControllers![2] as? PendingCollaborationsViewController {
            pendingCollabsViewController.selectedVGISystem = vgiSystem
        }
        if let navigation = self.navigationController {
            navigation.pushViewController(menuController, animated: true)
        }
        
    }
    
    func loginNavigate() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "Login") as! LoginViewController
        loginViewController.delegate = self
        if let navigation = self.navigationController {
            navigation.pushViewController(loginViewController, animated: true)
        }
    }
    
    func updateHubTiles() {
        self.tiles.removeAll()
        
        let vgiSystems = VGISystem.all()
        print(vgiSystems.count)
        for vgiSystem in vgiSystems {
            self.tiles.append(SystemTile(vgiSystem: vgiSystem, available: !vgiSystem.sync))
        }
        self.tiles.append(AddTile(name: "add"))
        self.hubCollectionView.reloadData()
    }
    
    // MARK: - System Tile Delegate
    
    func addTile(_ vgiSystem: VGISystem) {
        VGISystem.add(new: vgiSystem)
        let categories = EventCategory.all()
        print("Categories Counter: \(categories.count)")
        updateHubTiles()
    }
    
    func deleteTile(_ vgiSystem: VGISystem) {
        VGISystem.delete(vgiSystem)
        updateHubTiles()
    }

}

