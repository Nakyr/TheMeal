//
//  MainViewModel.swift
//  TheMeal
//
//  Created by Armando Corona Carrillo on 09/10/23.
//

import Foundation

class MainViewModel {
    private var apiClient: TheMealAPI = TheMealAPI()
    
    var meals: [Meal] = []
    
    var showActivityIndicator: ((_ show: Bool) -> Void)?
    var reloadTable: (() -> Void)?
    var showMealDetail: ((_ viewModel: MealDetailViewModel) -> Void)?
    var showFullScreenError: ((_ message: String) -> Void)?
    var hideFullScreenError: (() -> Void)?
    
    var rows: Int {
        return meals.count
    }
    
}

extension MainViewModel {
    func didLoad() {
        self.getMeals()
    }
    
    func retryButtonWasTapped() {
        self.getMeals()
    }
    
    func itemAt(index: Int) -> Meal {
        return meals[index]
    }
    
    func rowWasSelected(row: Int) {
        let item = itemAt(index: row)
        let viewModel = MealDetailViewModel(apiClient: apiClient, id: item.idMeal)
        self.showMealDetail?(viewModel)
    }
}

extension MainViewModel {
    private func getMeals() {
        showActivityIndicator?(true)
        hideFullScreenError?()
        apiClient.getMeals { [weak self] result in
            self?.showActivityIndicator?(false)
            guard let self = self else { return }
            
            switch result {
            case .success(let meals):
                self.meals = meals.meals
                self.reloadTable?()
            case .failure(_):
                self.showFullScreenError?("Ups! an error has occurred")
            }
        }
    }
}
