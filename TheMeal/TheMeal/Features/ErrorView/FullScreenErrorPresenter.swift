//
//  FullScreenErrorPresenter.swift
//  TheMeal
//
//  Created by Armando Corona Carrillo on 12/10/23.
//

import Foundation
import UIKit

protocol FullScreenErrorPresenter: AnyObject {
    func showFullScreenError(message: String)
    func retryFullScreenErrorBlockCalled()
    func dismissFullScreenError()
}

extension FullScreenErrorPresenter where Self: UIViewController {
    func showFullScreenError(message: String) {
        if let errorMessageViewController = children.first(where:{ $0 is MessageViewController}) as? MessageViewController {
            errorMessageViewController.messageText = message
            return
        }

        let messageVC = MessageViewController.make(message: message)
        messageVC.retryBlock = {
            self.retryFullScreenErrorBlockCalled()
        }
        
        self.add(messageVC, to: self.view)
    }
    
    func retryFullScreenErrorBlockCalled() {
        
    }
    
    func dismissFullScreenError() {
        if let errorMessageViewController = children.first(where:{ $0 is MessageViewController}) as? MessageViewController {
            self.remove(errorMessageViewController)
        }
    }
}
