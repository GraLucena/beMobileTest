//
//  RateAPI.swift
//  beMobileTest
//
//  Created by Graciela on 21/09/2018.
//  Copyright © 2018 Graciela. All rights reserved.
//

import Foundation

typealias RatesCompletion = (([Rate], Error?) -> Void)

protocol RateRepository {
    func getRates(onCompletion completion: RatesCompletion?)
}

protocol RateAPIRepository: RateRepository {
    var networkRepository: RateRepository { get }
}

struct RateAPI: RateRepository {
    
    let networkRepository: RateRepository = RateService()
    
    func getRates(onCompletion completion: RatesCompletion?) {
        networkRepository.getRates(onCompletion: completion)
    }
}
