//
//  TheMealAPI.swift
//  TheMeal
//
//  Created by Armando Corona Carrillo on 08/10/23.
//

import Foundation
import Siesta

class TheMealAPI {
    let baseUrl: String = "https://themealdb.com/api/json/v1/1"
    let service: Service
    
    init() {
        let jsonDecoder = JSONDecoder()
        self.service = Service(baseURL: baseUrl, standardTransformers: [.text, .image])
        
        self.service.configure {
            $0.headers["Accept"] = "*/json, application/json"
            $0.pipeline[.cleanup].add(TheMealErrorMessageExtractor(jsonDecoder: jsonDecoder))
        }

        self.service.configureTransformer("filter.php") {
            try jsonDecoder.decode(Meals.self, from: $0.content)
        }
        
        self.service.configureTransformer("lookup.php") {
            try jsonDecoder.decode(MealsById.self, from: $0.content)
        }
    }
}

private struct TheMealErrorMessageExtractor: ResponseTransformer {
    let jsonDecoder: JSONDecoder

    func process(_ response: Response) -> Response {
        guard case .failure(var error) = response, let errorData: Data = error.typedContent(), let registerError = try? jsonDecoder.decode(SpotifyRegisterErrorEnvelope.self, from: errorData) else {
            return response
        }
        if let message = registerError.errors?.first?.value.first {
            error.userMessage = message
        } else {
            error.userMessage = registerError.message
        }
        return .failure(error)
    }

    private struct SpotifyRegisterErrorEnvelope: Decodable {
        let message: String
        let errors: [String: [String]]?
    }
    
}
