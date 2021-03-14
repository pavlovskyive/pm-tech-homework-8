//
//  Data + Decode.swift
//  WeatherApp
//
//  Created by Vsevolod Pavlovskyi on 14.03.2021.
//

import Foundation
import Combine

extension Data {
    
    func decode<T: Decodable>() -> AnyPublisher<T, WeatherError> {
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        return Just(self)
            .decode(type: T.self, decoder: decoder)
            .mapError { error in
                .parsing(description: error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }

}
