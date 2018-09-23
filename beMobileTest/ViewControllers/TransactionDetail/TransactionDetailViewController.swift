//
//  TransactionDetailViewController.swift
//  beMobileTest
//
//  Created by Graciela on 23/09/2018.
//  Copyright © 2018 Graciela. All rights reserved.
//

import UIKit

class TransactionDetailViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    var viewModel: TransactionsDetailViewModel
    
    //MARK: - Initializers
    init(viewModel: TransactionsDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: TransactionsViewController.self), bundle: nil)
        title = self.viewModel.transactions?.first?.sku
        self.viewModel.calculateTrasactions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()
    }
    
    private func configureTable(){
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }
}

//MARK : - UITableViewDataSource
extension TransactionDetailViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfTransactions()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell",for: indexPath)
        cell.textLabel?.text = String(format: "%.2f", viewModel.transactionsAt(index: indexPath.row))
        return cell
    }
}

//MARK : - TransactionsDetailViewModelViewDelegate
extension TransactionDetailViewController : TransactionsDetailViewModelViewDelegate{
    func loadTable(viewModel: TransactionsDetailViewModel) {
        tableView.reloadData()
    }
}
