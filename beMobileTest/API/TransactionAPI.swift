//
//  TransactionAPI.swift
//  beMobileTest
//
//  Created by Graciela on 21/09/2018.
//  Copyright © 2018 Graciela. All rights reserved.
//

import Foundation

typealias TransactionCompletion = (([Transaction], Error?) -> Void)

protocol TransactionRepository {
    func getTransactions(onCompletion completion: TransactionCompletion?)
}

protocol TransactionAPIRepository: TransactionRepository {
    var networkRepository: TransactionRepository { get }
}

struct TransactionAPI: TransactionRepository {
    
    let networkRepository: TransactionRepository = TransactionService()
    
    func getTransactions(onCompletion completion: TransactionCompletion?) {
        networkRepository.getTransactions(onCompletion: completion)
    }
}
