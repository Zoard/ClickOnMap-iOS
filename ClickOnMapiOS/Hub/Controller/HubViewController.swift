//
//  HubViewController.swift
//  ClickOnMapiOS
//
//  Created by Zoárd Geöcze on 02/06/2018.
//  Copyright © 2018 Zoárd Geöcze. All rights reserved.
//

import UIKit

class HubViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var hubCollectionView: UICollectionView!
    
    let vgiSystems: Array<VGISystem> = [VGISystem(address: "192.168.1.1", name: "Teste", description: "Sistema de Teste",
                                                  color: UIColor.blue, collaborations: 0, latX: 0.0, latY: 0.0, lngX: 0.0, lngY: 0.0)]

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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.vgiSystems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Hub Cell", for: indexPath) as! HubCollectionViewCell
        let vgiSystem = self.vgiSystems[indexPath.row]
        cell.configureCellFor(vgiSystem)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return UIDevice.current.userInterfaceIdiom == .phone ? CGSize(width: collectionView.bounds.width/2-20, height: 160) : CGSize(width: collectionView.bounds.width/3-20, height: 250)
    }

}

