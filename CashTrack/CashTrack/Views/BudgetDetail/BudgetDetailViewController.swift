//
//  BudgetDetailViewController.swift
//  CashTrack
//
//  Created by Jake Edwards on 9/1/20.
//  Copyright © 2020 Jake Edwards. All rights reserved.
//

import UIKit

class BudgetDetailViewController: UIViewControllerBase, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    private var PageView = BudgetDetailPageView()
    private var TransactionCellId: String = "transactionCellId"
    private var BudgetIndex: Int!
    
    override func setupNavBar() {
        super.setupNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        didUpdateBudget()
    }
    
    public func setInfoForBudget(at index: Int) {
        self.BudgetIndex = index
        let budget = DataStore.shared.getBudget(at: index)
        self.title = budget.Name
        PageView.setInfoFor(budget)
    }
    
    override func setupPageView() {
        self.view.addSubview(PageView)
        PageView.setTopAnchor(to: self.view.safeAreaLayoutGuide.topAnchor)
        PageView.setBottomAnchor(to: self.view.safeAreaLayoutGuide.bottomAnchor)
        PageView.setLeadingAnchor(to: self.view.leadingAnchor)
        PageView.setTrailingAnchor(to: self.view.trailingAnchor)
    }
    
    internal override func setupPageViewChildren() {
        PageView.TransactionsCollectionView.delegate = self
        PageView.TransactionsCollectionView.dataSource = self
        PageView.TransactionsCollectionView.register(TransactionCell.self, forCellWithReuseIdentifier: TransactionCellId)
        PageView.NewTransactionButton.addTarget(self, action: #selector(pushToNewTransactionViewController), for: .touchUpInside)
        PageView.EditBudgetButton.addTarget(self, action: #selector(pushToEditBudgetViewController), for: .touchUpInside)
    }
    
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let currentBudget = DataStore.shared.getBudget(at: BudgetIndex)
        let numberOfTransactions = currentBudget.MonthlyNumberOfTransactions
        return numberOfTransactions
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentBudget = DataStore.shared.getBudget(at: BudgetIndex)
        let transactionForCell = currentBudget.getTransaction(at: indexPath.row)
        
        let cell = PageView.TransactionsCollectionView.dequeueReusableCell(withReuseIdentifier: TransactionCellId, for: indexPath) as! TransactionCell
        cell.setTransactionInfoForCell(with: transactionForCell)
        return cell
    }
    
    internal func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let editTransactionViewController: EditTransactionViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "editTransactionVC") as! EditTransactionViewController
        editTransactionViewController.setInfoForTransaction(at: indexPath.row, forBudgetIndex: self.BudgetIndex)
        self.navigationController?.pushViewController(editTransactionViewController, animated: true)
    }
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height : CGFloat = 55
        let width : CGFloat = PageView.TransactionsCollectionView.frame.width
        let size = CGSize(width: width, height: height)
        return size
    }
    
    @objc private func pushToEditBudgetViewController() {
        let editBudgetViewController: EditBudgetViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "editBudgetVC") as! EditBudgetViewController
        editBudgetViewController.setInfoForBudget(at: BudgetIndex)
        self.navigationController?.pushViewController(editBudgetViewController, animated: true)
    }
    
    @objc private func pushToNewTransactionViewController() {
        
    }
    
    private func didUpdateBudget() {
        setInfoForBudget(at: self.BudgetIndex)
        self.PageView.TransactionsCollectionView.reloadData()
    }
}
