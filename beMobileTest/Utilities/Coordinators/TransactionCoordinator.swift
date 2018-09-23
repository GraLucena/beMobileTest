//
//  TransactionCoordinator.swift
//  beMobileTest
//
//  Created by Graciela on 21/09/2018.
//  Copyright © 2018 Graciela. All rights reserved.
//

import UIKit

import UIKit

class TransactionCoordinator: Coordinator {
    
    var rootViewController: UIViewController
    
    private var navigationController: UINavigationController {
        return rootViewController as! UINavigationController
    }
    
    init() {
        rootViewController = UINavigationController()
    }
    
    func start() {
        let transactionVM = TransactionsAPIViewModel()
        let transactionVC = TransactionsViewController.init(viewModel: transactionVM)
        transactionVM.coordinatorDelegate = self
        navigationController.setViewControllers([transactionVC], animated: false)
    }
    
    func showTransactionDetail(trasactions: [Transaction]){
        let transactionDetailVM = TransactionsDetailAPIViewModel(transactions: trasactions)
        let transactionDetailVC = TransactionDetailViewController(viewModel: transactionDetailVM)
        navigationController.pushViewController(transactionDetailVC, animated: true)
    }
}

//MARK : - TransactionsViewModelCoordinatorDelegate
extension TransactionCoordinator : TransactionsViewModelCoordinatorDelegate{
    
    func transactionsViewModel(_ viewModel: TransactionsViewModel, didSelectSku sku: [Transaction]) {
        showTransactionDetail(trasactions: sku)
    }
}
