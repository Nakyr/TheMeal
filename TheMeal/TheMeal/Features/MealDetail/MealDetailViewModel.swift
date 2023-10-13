//
//  MealDetailViewModel.swift
//  TheMeal
//
//  Created by Armando Corona Carrillo on 11/10/23.
//

import Foundation

class MealDetailViewModel {
    private let apiClient: TheMealAPI
    private let id: String
    private var meal: MealDetail? = nil
    
    var showActivityIndicator: ((_ show: Bool) -> Void)?
    var updateInfo: ((_ meal: MealDetail) -> Void)?
    var showFullScreenError: ((_ message: String) -> Void)?
    var hideFullScreenError: (() -> Void)?
    
    init(apiClient: TheMealAPI, id: String) {
        self.apiClient = apiClient
        self.id = id
    }
}

extension MealDetailViewModel {
    func didLoad() {
        getMealDetails(id: self.id)
    }
    
    private func getMealDetails(id: String) {
        showActivityIndicator?(true)
        hideFullScreenError?()
        apiClient.getMealDetailBy(id: self.id) { [weak self] result in
            self?.showActivityIndicator?(false)
            switch result {
            case .success(let mealById):
                self?.meal = mealById.meals.first
                self?.updateInfo?(mealById.meals[0])
            case .failure(_):
                self?.showFullScreenError?("Ups! an error has occurred")
            }
        }
    }
    
    func retryButtonWasTapped() {
        getMealDetails(id: self.id)
    }
}
