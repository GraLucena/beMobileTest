//
//  TransactionDetailViewModel.swift
//  beMobileTest
//
//  Created by Graciela on 23/09/2018.
//  Copyright © 2018 Graciela. All rights reserved.
//

import Foundation

protocol TransactionsDetailViewModelViewDelegate: class {
    func loadTable(viewModel: TransactionsDetailViewModel)
    
}

protocol TransactionsDetailViewModelCoordinatorDelegate: class {
    
}

protocol TransactionsDetailViewModel: class {
    var viewDelegate: TransactionsDetailViewModelViewDelegate? { get set }
    var coordinatorDelegate: TransactionsDetailViewModelCoordinatorDelegate? { get set }
    
    func numberOfTransactions() -> Int
    func transactionsAt(index: Int) -> Double!
    func calculateTrasactions()
    
    var transactions: [Transaction]? { get set }
}

class TransactionsDetailAPIViewModel: TransactionsDetailViewModel {
    
    var viewDelegate: TransactionsDetailViewModelViewDelegate?
    var coordinatorDelegate: TransactionsDetailViewModelCoordinatorDelegate?
    var transactions: [Transaction]?
    var CADtransactions: [Transaction]?
    var EURtransactions: [Transaction]?
    var USDtransactions: [Transaction]?
    
    private var amounts: [Double] = [Double]() {
        didSet {
            self.viewDelegate?.loadTable(viewModel: self)
        }
    }
    
    init(transactions: [Transaction]){
        self.transactions = transactions
    }
    
    func numberOfTransactions() -> Int {
        return amounts.count
    }
    
    func transactionsAt(index: Int) -> Double! {
        return amounts[index]
    }
    
    func calculateTrasactions(){
        
        var auxAmounts = [Double]()
        
        verifyTransactions()
        
        transactions?.forEach({ (transaction) in
            auxAmounts.append(transaction.amount!)
        })
        
        let total = auxAmounts.map({$0}).reduce(0, +)
        auxAmounts.append(total)
        amounts = auxAmounts
    }
    
    private func getRate(from: String) -> Double?{
        if let rate = Rates.shared.rates?.filter({ $0.from == from && $0.to == Currency.EUR.rawValue }){
            return rate.first?.rate
        }
        return nil
    }
    
    private func verifyTransactions(){
        var auxTransactions = [Transaction]()
        transactions?.forEach({ (transaction) in
            if transaction.currency != Currency.EUR.rawValue{
                if let rate = getRate(from: transaction.currency!){
                    var aux = transaction
                    aux.currency = Currency.EUR.rawValue
                    aux.amount = rate * transaction.amount!
                    auxTransactions.append(aux)
                }else{
                    if let newTransaction = verifyRatesFor(transaction), newTransaction.currency == Currency.EUR.rawValue{
                        auxTransactions.append(newTransaction)
                    }
                }
            }else{
                auxTransactions.append(transaction)
            }
        })
        
        transactions?.removeAll()
        transactions = auxTransactions
    }
    
    private func verifyRatesFor(_ transaction: Transaction) -> Transaction?{
        var aux = transaction
        
        if let rate = Rates.shared.rates?.filter({ $0.from == transaction.currency }).first{
            aux.currency = rate.to
            aux.amount = rate.rate! * transaction.amount!
        }
        
        if aux.currency != Currency.EUR.rawValue{
            return verifyRatesFor(aux)
        }else{
            return aux
        }
    }
}
