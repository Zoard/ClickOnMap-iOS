//
//  MapViewController.swift
//  ClickOnMapiOS
//
//  Created by Zoárd Geöcze on 05/09/2018.
//  Copyright © 2018 Zoárd Geöcze. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController, GMSMapViewDelegate {
    
    // MARK: - Variables
    
    var selectedVGISystem: VGISystem?
    var collaborations: Array<Collaboration> = []
    
    // MARK: - Map Attributes
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var mapView: GMSMapView!
    var zoomLevel: Float = 15.0

    override func viewDidLoad() {
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        loadMap()
        
        if let vgiSystem = selectedVGISystem {
            print(vgiSystem.address)
        } else {
            print("Nenhum sistema vgi selecionado em MapViewController")
        }
        
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        requestCollaborations()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Google Map
    
    func loadMap() {
        
        let camera = GMSCameraPosition.camera(withLatitude: -20.7546,
                                              longitude: -42.8825,
                                              zoom: zoomLevel)
        mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
        mapView.settings.myLocationButton = true
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.isMyLocationEnabled = true
        
        // Add the map to the view, hide it until we've got a location update.
        view.addSubview(mapView)
        mapView.isHidden = true
        mapView.delegate = self
        
        insertButton()

        
    }
    
    func populateMap() {
        
        mapView.clear()
        
        print(self.collaborations.count)
        
        for collab in self.collaborations {
             let marker = GMSMarker()
             marker.position = CLLocationCoordinate2D(latitude: Double(collab.latitude)!, longitude: Double(collab.longitude)!)
             marker.title = collab.title
             marker.snippet = collab.collaborationDescription
             marker.userData = collab
             marker.map = self.mapView
         }
        
    }
    
    func insertButton() {
        let btn: UIButton = UIButton(frame: CGRect(x: 130, y: 439, width: 60, height: 60))
        btn.setImage(UIImage(named: "Logo"), for: UIControlState.normal)
        btn.addTarget(self, action: #selector(collaborate), for: UIControlEvents.touchUpInside)
        
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOffset = CGSize(width: 3, height: 3)
        btn.layer.shadowRadius = 3
        btn.layer.shadowOpacity = 0.8
        
        self.mapView.addSubview(btn)
    }
    
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        let collab = marker.userData as? Collaboration
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let collabDetailsViewController = storyboard.instantiateViewController(withIdentifier: "CollaborationDetails") as! CollaborationDetailsViewController
        if let navigation = self.navigationController {
            collabDetailsViewController.selectedCollab = collab
            collabDetailsViewController.selectedVGISystem = self.selectedVGISystem
            navigation.pushViewController(collabDetailsViewController, animated: true)
        }
        
    }
    
    // MARK: - Web Services - Request Collaborations
    
    func requestCollaborationsCompletionHandler(_ response: CollaborationsDataResponse?) {
        guard let responseData = response?.collaborations else {
            print("It Wasn't Possible to get Collaborations")
            return
        }
        
        self.collaborations = responseData
        populateMap()
    }
    
    func requestCollaborations() {
        
        guard let vgiSystem = self.selectedVGISystem else {
            print("Log")
            return
        }
        
        CollaborationService(baseUrl: vgiSystem.address).requestCollaborations(completionHandler: requestCollaborationsCompletionHandler(_:))
    }
    
    // MARK: - Actions
    
    @objc func collaborate() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let collabViewController = storyboard.instantiateViewController(withIdentifier: "Collaboration") as! CollaborationViewController
        if let navigation = self.navigationController {
            collabViewController.selectedVGISystem = self.selectedVGISystem
            print("Latitude: \(self.locationManager.location?.coordinate.latitude)")
            print("Longitude: \(self.locationManager.location?.coordinate.longitude)")
            collabViewController.currentLocation = self.locationManager.location
            navigation.pushViewController(collabViewController, animated: true)
        }
        
    }
    

}
