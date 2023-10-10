//
//  TheMealAPI+Meals.swift
//  TheMeal
//
//  Created by Armando Corona Carrillo on 09/10/23.
//

import Foundation
import Siesta

extension TheMealAPI {
    private var menu: Resource {
        return service.resource("filter.php")
    }
    
    func getMeals(completion: @escaping (Result<Meals, Error>) -> ()) {
        let resource = menu.withParam("c", "Dessert")
        
        resource.request(.get)
            .onSuccess { response in
                if let meals: Meals = response.typedContent() {
                    completion(.success(meals))
                } else {
                    let error = RequestError(response: nil, content: nil, cause: nil)
                    completion(.failure(error))
                }
            }.onFailure { error in
                completion(.failure(error))
            }
    }
}
