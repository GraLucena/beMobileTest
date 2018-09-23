//
//  Coordinator.swift
//  beMobileTest
//
//  Created by Graciela on 21/09/2018.
//  Copyright © 2018 Graciela. All rights reserved.
//

import UIKit

typealias CoordinatorsDictionary = [String: Coordinator]

protocol Coordinator: class {
    var rootViewController: UIViewController { get }
    
    func start()
}

extension Coordinator {
    var name: String {
        return String(describing: self)
    }
}
