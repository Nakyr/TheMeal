//
//  MealDetailViewController.swift
//  TheMeal
//
//  Created by Armando Corona Carrillo on 11/10/23.
//

import Foundation
import UIKit
import SiestaUI

class MealDetailViewController: UIViewController, Storyboarded {
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var mealImage: RemoteImageView!
    @IBOutlet private weak var instructionsLabel: UILabel!
    @IBOutlet private weak var ingredientsLabel: UILabel!
    @IBOutlet private weak var detailsStackView: UIStackView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    private var viewModel: MealDetailViewModel!
    
    static func make(viewModel: MealDetailViewModel) -> MealDetailViewController {
        let vc = MealDetailViewController.instantiate()
        vc.viewModel = viewModel
        return vc
    }
    
}

extension MealDetailViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.didLoad()
    }
}

extension MealDetailViewController {
    func bind() {
        viewModel.showActivityIndicator = { [weak self] show in
            DispatchQueue.main.async {
                if show {
                    self?.activityIndicator.startAnimating()
                    self?.activityIndicator.isHidden = false
                } else {
                    self?.activityIndicator.stopAnimating()
                    self?.activityIndicator.isHidden = true
                }
            }
        }
        
        viewModel.updateInfo = { [weak self] meal in
            DispatchQueue.main.async {
                self?.nameLabel.text = meal.strMeal
                self?.mealImage.imageURL = meal.strMealThumb
                self?.instructionsLabel.text = "Instructions: \n" + meal.strInstructions
                self?.ingredientsLabel.text = "Ingredients: \n" + meal.allIngredientsAndMeasurements()
            }
        }
    }
}
