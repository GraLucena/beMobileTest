//
//  RootCoordinator.swift
//  beMobileTest
//
//  Created by Graciela on 21/09/2018.
//  Copyright © 2018 Graciela. All rights reserved.
//

import UIKit

class RootCoordinator: Coordinator {
    
    private var window: UIWindow
    private var coordinators: CoordinatorsDictionary
    
    var rootViewController: UIViewController {
        let coordinator = coordinators.popFirst()!.1
        
        return coordinator.rootViewController
    }
    
    // MARK: - Initializers
    init(window: UIWindow) {
        self.window = window
        coordinators = [:]
    }
    
    // MARK: - Coordinator
    func start() {
        showTransactionList()
    }
    
    // MARK: Helpers
    private func showTransactionList() {
        let transactionCoordinator = TransactionCoordinator()
        coordinators[transactionCoordinator.name] = transactionCoordinator
        window.rootViewController = transactionCoordinator.rootViewController
        transactionCoordinator.start()
    }
}
