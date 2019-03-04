//
//  Alert.swift
//  ios
//
//  Created by Zoárd Geöcze on 17/08/2018.
//  Copyright © 2018 Zoárd Geöcze. All rights reserved.
//

import UIKit

enum AlertActions: String {
    
    case tryAgain = "Tentar Novamente"
    case ok = "Ok"
    case understood = "Entendi"
    case cancel = "Cancelar"
    case save = "Salvar"
    case delete = "Deletar"
}

class Alert {
    
    let controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func show(_ title:String = "Desculpe", message:String = "Erro não esperado") {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        let ok = UIAlertAction(title: "Entendi",
                               style: UIAlertActionStyle.cancel,
                               handler: nil)
        
        alert.addAction(ok)
        self.controller.present(alert, animated: true, completion: nil)
    }
    
    func showWithHandler(_ title:String = "Desculpe", message: String = "Erro não esperado",
                         okButtonTitle: String = "Sim", cancelButtonTitle: String,
                         completion: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        let ok = UIAlertAction(title: okButtonTitle,
                               style: UIAlertActionStyle.default,
                               handler: completion)
        
        let cancel = UIAlertAction(title: cancelButtonTitle,
                                   style: UIAlertActionStyle.cancel,
                                   handler: nil)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        self.controller.present(alert, animated: true, completion: nil)
    }
    
    func showWithHandler(_ title:String = "Desculpe", message: String = "Erro não esperado",
                         firstAction: UIAlertAction? = nil, secondAction: UIAlertAction? = nil,
                         thirdAction: UIAlertAction? = nil) {
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        if let first = firstAction {
            alert.addAction(first)
        }
        
        if let second = secondAction {
            alert.addAction(second)
        }
        
        if let third = thirdAction {
            alert.addAction(third)
        }
        
        self.controller.present(alert, animated: true, completion: nil)
        
    }
}
