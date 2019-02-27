//
//  MidiaViewController.swift
//  ClickOnMapiOS
//
//  Created by Zoárd Geöcze on 27/02/19.
//  Copyright © 2019 Zoárd Geöcze. All rights reserved.
//

import Foundation
import UIKit

class MediaViewController : UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Attributes
    
    var selectedImage: UIImage?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        
        displayImage()
        
        super.viewDidLoad()
    }
    
    // MARK: - Methods
    
    func displayImage() {
        
        guard let image = selectedImage else {
            print("Not a valid Image")
            return
        }
        
        self.imageView.image = image
        
        
    }
    
    // MARK: - Actions
    
    @IBAction func swipeToBack(_ sender: UIScreenEdgePanGestureRecognizer) {
        
        if let navigation = self.navigationController {
            navigation.popViewController(animated: true)
        }
        
    }
    
    
}
