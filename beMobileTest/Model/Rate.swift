//
//  Rate.swift
//  beMobileTest
//
//  Created by Graciela on 21/09/2018.
//  Copyright © 2018 Graciela. All rights reserved.
//

import Foundation

enum Currency : String{
    
    case USD = "USD"
    case EUR = "EUR"
    case CAD = "CAD"
}

struct Rate: Codable{
    
    var from: String?
    var to: String?
    var rate: Double?
    
    enum CodingKeys : String, CodingKey{
        case from
        case to
        case rate
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        from = try values.decodeIfPresent(String.self, forKey: .from)
        to = try values.decodeIfPresent(String.self, forKey: .to)
        let rateString = try values.decodeIfPresent(String.self, forKey: .rate)
        rate = Double(rateString ?? "0")
    }
}
