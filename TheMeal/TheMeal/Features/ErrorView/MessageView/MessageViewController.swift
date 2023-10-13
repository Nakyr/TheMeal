//
//  MessageViewController.swift
//  TheMeal
//
//  Created by Armando Corona Carrillo on 12/10/23.
//

import Foundation
import UIKit


class MessageViewController: UIViewController, Storyboarded {
    enum Constants {
        static let messageLabelText = "Ups! an error has occurred"
        static let retryButtonText = "Retry"
    }
    
    private var message: String = Constants.messageLabelText
    private var buttonLabel: String = Constants.retryButtonText
    
    typealias MessageRetryBlock = () -> Void
    var retryBlock: MessageRetryBlock? = nil
    
    var isButtonHiden: Bool = false {
        didSet {
            actionButton?.isHidden = isButtonHiden
        }
    }
    
    var messageText: String = "" {
        didSet {
            self.message = messageText
            self.messageLabel?.text = message
        }
    }
    
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var actionButton: UIButton!
    
    static func make(message: String = Constants.messageLabelText, buttonLabel: String = Constants.retryButtonText) -> MessageViewController {
        let vc = MessageViewController.instantiate()
        vc.message = message
        vc.buttonLabel = buttonLabel
        
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.messageLabel.text = message
        self.actionButton.titleLabel?.text = buttonLabel
    }
    
    @IBAction private func retryButtonTouched(_ sender: Any) {
        retryBlock?()
    }
}
