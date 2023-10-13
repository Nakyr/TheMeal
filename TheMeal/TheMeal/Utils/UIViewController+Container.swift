//
//  UIViewController+Container.swift
//  TheMeal
//
//  Created by Armando Corona Carrillo on 12/10/23.
//

import Foundation
import UIKit

extension UIViewController {
    func add(_ child: UIViewController, to view: UIView) {
        DispatchQueue.main.async {
            child.willMove(toParent: self)
            child.beginAppearanceTransition(true, animated: false)
            self.addChild(child)
            child.view.frame = view.bounds
            child.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.addSubview(child.view)
            child.didMove(toParent: self)
            child.endAppearanceTransition()
        }
    }

    func remove(_ child: UIViewController) {
        child.willMove(toParent: nil)
        child.removeFromParent()
        child.view.removeFromSuperview()
    }
}
