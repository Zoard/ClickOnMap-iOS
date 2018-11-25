//
//  HubViewController.swift
//  ClickOnMapiOS
//
//  Created by Zoárd Geöcze on 02/06/2018.
//  Copyright © 2018 Zoárd Geöcze. All rights reserved.
//

import UIKit

class HubViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, AddSystemTileDelegate {
    
    //MARK: - Outlets
    
    @IBOutlet weak var hubCollectionView: UICollectionView!
    
    //MARK: - Attributes
    
    /*var vgiSystem: VGISystem = VGISystem(address: "192.168.1.1", name: "Teste", description: "Sistema de Teste",
                                         color: UIColor.blue, collaborations: 0, latX: 0.0, latY: 0.0, lngX: 0.0, lngY: 0.0)*/
    
    var tiles: Array<Tile> = [AddTile(name: "add")]
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hubCollectionView.dataSource = self
        hubCollectionView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    //MARK: - CollectionView
    
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
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let addSystemcontroller = storyboard.instantiateViewController(withIdentifier: "AddSystem") as! AddSystemViewController
            addSystemcontroller.delegate = self
            navigationController?.pushViewController(addSystemcontroller, animated: true)
            print("Ce ta doido...")
            
        } else {
            /*guard let systemTile = tile, systemTile.vgiSystem.available == true else {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let loginController = storyboard.instantiateViewController(withIdentifier: "Login") as! LoginViewController
                //REVER ISSO AQUI, TENHO QUE ADICIONAR UM VGISystem para o LOGIN
                navigationController?.pushViewController(loginController, animated: true)
            }*/
            
            let systemTile = tile as! SystemTile
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let menuController = storyboard.instantiateViewController(withIdentifier: "VGISystem") as! UITabBarController
            //menuController.selectedVGISystem = systemTile.vgiSystem
            navigationController?.pushViewController(menuController, animated: true)
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return UIDevice.current.userInterfaceIdiom == .phone ? CGSize(width: collectionView.bounds.width/2, height: 160) : CGSize(width: collectionView.bounds.width/2, height: 250)
    }
    
    //MARK: - Delegate
    
    func add(_ systemTile: SystemTile) {
        self.tiles.append(systemTile)
        self.hubCollectionView.reloadData()
    }

}

