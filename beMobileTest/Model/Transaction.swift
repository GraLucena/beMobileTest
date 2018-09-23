//
//  Transaction.swift
//  beMobileTest
//
//  Created by Graciela on 21/09/2018.
//  Copyright © 2018 Graciela. All rights reserved.
//

import Foundation

struct Transaction: Codable{
    
    var sku: String?
    var amount: Double?
    var currency: String?
    
    enum CodingKeys : String, CodingKey{
        case sku
        case amount
        case currency
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        sku = try values.decodeIfPresent(String.self, forKey: .sku)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        let amountString = try values.decodeIfPresent(String.self, forKey: .amount)
        amount = Double(amountString ?? "0")
    }
}

