//
//  TransactionsViewController.swift
//  beMobileTest
//
//  Created by Graciela on 21/09/2018.
//  Copyright © 2018 Graciela. All rights reserved.
//

import UIKit
import SVProgressHUD

class TransactionsViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    var viewModel: TransactionsViewModel

    //MARK: - Initializers
    init(viewModel: TransactionsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: TransactionsViewController.self), bundle: nil)
        viewModel.viewDelegate = self
        SVProgressHUD.show()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getRates()
        viewModel.getTransactions()
        configureTable()
    }
    
    private func configureTable(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }
}

//MARK : - UITableViewDelegate
extension TransactionsViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectSkuAt(index: indexPath.row)
    }
}

//MARK : - UITableViewDataSource
extension TransactionsViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfSkus()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell",for: indexPath)
        cell.textLabel?.text = viewModel.skuAt(index: indexPath.row).sku
        return cell
    }
}

//MARK : - TransactionsViewModelViewDelegate
extension TransactionsViewController : TransactionsViewModelViewDelegate{
    func loadTable(viewModel: TransactionsViewModel) {
        tableView.reloadData()
        SVProgressHUD.dismiss()
    }
}
