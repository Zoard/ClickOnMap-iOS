//
//  HubViewController.swift
//  ClickOnMapiOS
//
//  Created by Zoárd Geöcze on 02/06/2018.
//  Copyright © 2018 Zoárd Geöcze. All rights reserved.
//

import UIKit

class HubViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, AddSystemTileDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet weak var hubCollectionView: UICollectionView!
    
    // MARK: - Attributes
    
    var tiles: Array<Tile> = []
    
    // MARK: - Realm DB
    
    let dataBase = RealmDB()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hubCollectionView.dataSource = self
        hubCollectionView.delegate = self
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
    
    // MARK: - CollectionView
    
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return UIDevice.current.userInterfaceIdiom == .phone ? CGSize(width: collectionView.bounds.width/2, height: 160) : CGSize(width: collectionView.bounds.width/2, height: 250)
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
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let menuController = storyboard.instantiateViewController(withIdentifier: "VGISystem") as! UITabBarController
        if let systemMenuViewController = menuController.viewControllers![0] as? SystemMenuViewController {
            systemMenuViewController.selectedVGISystem = systemTile.vgiSystem
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
    
    //MARK: - Delegate
    
    func add(_ vgiSystem: VGISystem) {
        dataBase.create(object: vgiSystem)
        updateHubTiles()
    }

}

