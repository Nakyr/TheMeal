//
//  MealTableViewCell.swift
//  TheMeal
//
//  Created by Armando Corona Carrillo on 09/10/23.
//

import Foundation
import UIKit
import SiestaUI

class MealTableViewCell: UITableViewCell {
    static let reuseIdentifier = "MealTableViewCell"
    
    @IBOutlet private weak var mealImage: RemoteImageView!
    @IBOutlet private weak var nameLabel: UILabel!
}

extension MealTableViewCell {
    func fillWith(name: String, urlImage: String) {
        nameLabel.text = name
        mealImage.imageURL = urlImage
    }
}
