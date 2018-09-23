//
//  TransactionsViewModel.swift
//  beMobileTest
//
//  Created by Graciela on 21/09/2018.
//  Copyright © 2018 Graciela. All rights reserved.
//

import Foundation

protocol TransactionsViewModelViewDelegate: class {
    func loadTable(viewModel: TransactionsViewModel)
}

protocol TransactionsViewModelCoordinatorDelegate: class {
    func transactionsViewModel(_ viewModel: TransactionsViewModel, didSelectSku sku: [Transaction])
}

protocol TransactionsViewModel: class {
    var viewDelegate: TransactionsViewModelViewDelegate? { get set }
    var coordinatorDelegate: TransactionsViewModelCoordinatorDelegate? { get set }
    
    func getTransactions()
    func getRates()
    func numberOfSkus() -> Int
    func skuAt(index: Int) -> Transaction!
    func selectSkuAt(index: Int)
}

class TransactionsAPIViewModel: TransactionsViewModel {

    var viewDelegate: TransactionsViewModelViewDelegate?
    var coordinatorDelegate: TransactionsViewModelCoordinatorDelegate?
    
    private let transactionAPI = TransactionAPI()
    private let ratesAPI = RateAPI()

    private var transactions: [Transaction]?
    
    private var items: [Transaction] = [Transaction]() {
        didSet {
            self.viewDelegate?.loadTable(viewModel: self)
        }
    }
    
    func numberOfSkus() -> Int {
        return items.count
    }
    
    func skuAt(index: Int) -> Transaction! {
        return items[index]
    }
    
    func selectSkuAt(index: Int) {
        let selectedSku = items[index]
        guard let associatedTransactions = transactions?.filter({ $0.sku == selectedSku.sku }) else{return}
        coordinatorDelegate?.transactionsViewModel(self, didSelectSku: associatedTransactions)
    }
    
    func getTransactions() {
        transactionAPI.getTransactions { (transactions, error) in
            self.transactions = transactions
            self.filter(transactions: transactions)
        }
    }
    
    func getRates(){
        ratesAPI.getRates { (rates, error) in
            Rates.shared.rates = rates
        }
    }
    
    private func filter(transactions: [Transaction]){
        var itemsAux = [Transaction]()
        transactions.forEach({ (trans) in
            let contains = itemsAux.contains(where: {$0.sku == trans.sku})
            if !contains{
                itemsAux.append(trans)
            }
        })
        items = itemsAux
    }
}
