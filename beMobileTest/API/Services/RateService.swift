//
//  RateService.swift
//  beMobileTest
//
//  Created by Graciela on 21/09/2018.
//  Copyright © 2018 Graciela. All rights reserved.
//

import Foundation
import Alamofire

struct RateService: RateRepository {
    
    func getRates(onCompletion completion: RatesCompletion?) {
        
        Alamofire.request(Router.rates()).validate().responseJSON { (response) in
            var result: Result<[Rate]> = Result.success([Rate]())
            
            switch response.result {
                case .success(let jsonDictionary):
                    do {
//                        let newjsonDictionary : [Any] = [
//                            [ "from": "EUR", "to": "USD", "rate": "1.359" ],
//                            [ "from": "CAD", "to": "EUR", "rate": "0.732" ],
//                            [ "from": "USD", "to": "CAD", "rate": "0.736" ],
//                            [ "from": "EUR", "to": "CAD", "rate": "1.366" ]
//                        ]

                        let jsonData = try? JSONSerialization.data(withJSONObject: jsonDictionary, options: [])
                        let rates = try JSONDecoder().decode([Rate].self, from: jsonData!)
                        result = Result.success(rates)
                    } catch let error {
                        result = Result.failure(error)
                }
                case .failure(let error):
                    result = Result.failure(error)
            }

            if let completion = completion {
                completion(result.value ?? [], result.error)
            }
        }
    }
}
