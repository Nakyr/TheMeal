//
//  TheMealAPI+MealDetail.swift
//  TheMeal
//
//  Created by Armando Corona Carrillo on 09/10/23.
//

import Foundation
import Siesta

extension TheMealAPI {
    private var mealDetail: Resource {
        return service.resource("lookup.php")
    }
    
    func getMealDetailBy(id: String, completion: @escaping (Result<MealsById, Error>) -> ()) {
        let resource = mealDetail.withParam("i", id)
        
        resource.request(.get)
            .onSuccess { response in
                if let meals: MealsById = response.typedContent() {
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
