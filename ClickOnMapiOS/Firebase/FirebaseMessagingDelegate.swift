//
//  FirebaseMessagingService.swift
//  ClickOnMapiOS
//
//  Created by Zoárd Geöcze on 24/11/18.
//  Copyright © 2018 Zoárd Geöcze. All rights reserved.
//

import Foundation
import Firebase

extension AppDelegate : MessagingDelegate {
    
    func sendFirebaseKeyHandler(_ response: DefaultDataResponse?) {
        
        guard let success = response?.success else {
            return
        }
        
        if success == 1 {
            print("Firebase Token successfully sended to server.")
        } else {
            print("It was not possible to send Firebase Token to server.")
        }
        
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        
        let creationDate = Date().serverFormat()
        print(creationDate)
        FirebaseService().sendFirebaseKey(firebaseKey: fcmToken, creationDate: creationDate,
                                          completionHandler: sendFirebaseKeyHandler(_:))
    }
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        
    }
    
}
