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
    var showError: ((_ show: Bool, _ message: String) -> Void)?
    
    var rows: Int {
        return meals.count
    }
    
}

extension MainViewModel {
    func didLoad() {
        self.getMeals()
    }
}

extension MainViewModel {
    func getMeals() {
        showActivityIndicator?(true)
        apiClient.getMeals { [weak self] result in
            self?.showActivityIndicator?(false)
            guard let self = self else { return }
            
            switch result {
            case .success(let meals):
                self.meals = meals.meals
                self.reloadTable?()
            case .failure(let error):
                showError?(true, error.localizedDescription)
            }
        }
    }
    
    func itemAt(index: Int) -> Meal {
        return meals[index]
    }
}
