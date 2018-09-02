//
//  HubViewController.swift
//  ClickOnMapiOS
//
//  Created by Zoárd Geöcze on 02/06/2018.
//  Copyright © 2018 Zoárd Geöcze. All rights reserved.
//

import UIKit

class HubViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var hubCollectionView: UICollectionView!
    @IBOutlet weak var nameField: UITextField!
    
    let items = ["Cidadão Viçosa", "Mossoró Crimes", "Gota d'agua"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hubCollectionView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HubCollectionViewCell
        
        return cell
        
    }

}

