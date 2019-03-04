//
//  CollaborationDetailsViewController.swift
//  ClickOnMapiOS
//
//  Created by Zoárd Geöcze on 26/02/19.
//  Copyright © 2019 Zoárd Geöcze. All rights reserved.
//

import Foundation
import UIKit

class CollaborationDetailsViewController : UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var collabTitleLabel: UILabel!
    @IBOutlet weak var collabDescriptionTextView: UITextView!
    @IBOutlet weak var collabCategoryLabel: UILabel!
    @IBOutlet weak var collabSubcategoryLabel: UILabel!
    @IBOutlet weak var collabUsernameLabel: UILabel!
    @IBOutlet weak var pictureButton: UIButton!
    @IBOutlet weak var videoButton: UIButton!
    
    
    // MARK: - Attributes
    
    var selectedCollab: Collaboration?
    var selectedVGISystem: VGISystem?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        
        configureLayout()
        
        super.viewDidLoad()
    }
    
    // MARK: - Methods
    
    func configureLayout() {
        
        guard let collaboration = self.selectedCollab else {
            return
        }
        
        self.collabTitleLabel.text = collaboration.title
        self.collabDescriptionTextView.text = collaboration.collaborationDescription
        self.collabCategoryLabel.text = collaboration.categoryName
        self.collabSubcategoryLabel.text = collaboration.subcategoryName
        self.collabUsernameLabel.text = collaboration.userName
        
        if collaboration.photo != "" {
            self.pictureButton.setImage(UIImage(named: "ic_photo_on"), for: UIControlState.normal)
        }
        
        if collaboration.video != "" {
            self.videoButton.setImage(UIImage(named: "ic_video_on"), for: UIControlState.normal)
        }
        
    }
    
    // MARK: - Web Services - Request Collaboration Midia
    
    func requestCollaborationMidiaCompletionHandler(_ response: UIImage?) {
        
        guard let image = response else {
            return
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mediaViewController = storyboard.instantiateViewController(withIdentifier: "Media") as! MediaViewController
        if let navigation = self.navigationController {
            mediaViewController.selectedImage = image
            navigation.pushViewController(mediaViewController, animated: true)
        }
        
    }
    
    func requestCollaborationMidia(in midiaPath: String) {
        
        guard let vgiSystem = self.selectedVGISystem else {
            return
        }
        
        CollaborationService(baseUrl: vgiSystem.address)
            .requestCollaborationMidia(midiaPath: midiaPath,
                                       completionHandler: requestCollaborationMidiaCompletionHandler(_:))
    }
    
    // MARK: - Actions
    
    @IBAction func requestPicture(_ sender: UIButton) {
        
        
        guard let collaboration = self.selectedCollab else {
            return
        }
        
        if collaboration.photo != "" {
            let path = "/imagensenviadas/" + collaboration.photo
            requestCollaborationMidia(in: path)
        }
    }
    
    @IBAction func requestVideo(_ sender: UIButton) {
        
    }
    
    @IBAction func close(_ sender: UIBarButtonItem) {
        if let navigation = self.navigationController {
            navigation.popViewController(animated: true)
        }
    }
    
    
}
