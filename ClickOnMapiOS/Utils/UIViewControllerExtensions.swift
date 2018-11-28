//
//  UIViewControllerExtensions.swift
//  ClickOnMapiOS
//
//  Created by Zoárd Geöcze on 25/11/18.
//  Copyright © 2018 Zoárd Geöcze. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
