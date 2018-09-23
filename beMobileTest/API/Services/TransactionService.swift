//
//  TransactionService.swift
//  beMobileTest
//
//  Created by Graciela on 21/09/2018.
//  Copyright © 2018 Graciela. All rights reserved.
//

import Foundation
import Alamofire

struct TransactionService: TransactionRepository {
    
    func getTransactions(onCompletion completion: TransactionCompletion?) {
        Alamofire.request(Router.transactions()).validate().responseJSON { (response) in
            var result: Result<[Transaction]> = Result.success([Transaction]())
            
            switch response.result {
            case .success(let jsonDictionary):
                do {
//                    let newjsonDictionary : [Any] = [
//                    [ "sku": "T2006", "amount": "10.00", "currency": "USD" ],
//                    [ "sku": "M2007", "amount": "34.57", "currency": "CAD" ],
//                    [ "sku": "R2008", "amount": "17.95", "currency": "USD" ],
//                    [ "sku": "T2006", "amount": "7.63", "currency": "EUR" ],
//                    [ "sku": "B2009", "amount": "21.23", "currency": "USD" ]
//                    ]

                    
                    let jsonData = try? JSONSerialization.data(withJSONObject: jsonDictionary, options: [])
                    let transactions = try JSONDecoder().decode([Transaction].self, from: jsonData!)
                    result = Result.success(transactions)
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
