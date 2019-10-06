//
//  AccountViewController.swift
//  Cash.Track
//
//  Created by Jake Edwards on 7/7/19.
//  Copyright © 2019 Big Ahi Software. All rights reserved.
//

import UIKit

class WalletViewController : UIViewControllerAbstract, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, WalletUpdateDelegate {
    private var PageView = WalletPageView()
    private var CurrentAccount : Wallet!
    public var CurrentAccountId : Int!
    
    override public func viewDidLoad() {
        didUpdateAccount()
        super.viewDidLoad()
        self.view.backgroundColor = .gray
    }
    
    override func viewDidAppear(_ animated: Bool) {
        didUpdateAccount()
    }
    
    internal override func setupPageView() {
        self.view.addSubview(PageView)
        PageView.setTopAnchor(to: self.view.safeAreaLayoutGuide.topAnchor)
        PageView.setLeadingAnchor(to: self.view.leadingAnchor)
        PageView.setTrailingAnchor(to: self.view.trailingAnchor)
        PageView.setBottomAnchor(to: self.view.bottomAnchor)
    }
    
    internal override func setupPageViewChildren() {
        PageView.WithdrawButton.addTarget(self, action: #selector(handleWithdrawButtonPress), for: .touchUpInside)
        PageView.DepositButton.addTarget(self, action: #selector(handleDepositButtonPress), for: .touchUpInside)
        
        PageView.TransactionCollectionView.delegate = self
        PageView.TransactionCollectionView.dataSource = self
        PageView.TransactionCollectionView.register(TransactionCell.self, forCellWithReuseIdentifier: PageView.TransactionCellId)
    }
    
    internal func didUpdateAccount() {
        CurrentAccount = Store.shared.getAccountFor(accountId: CurrentAccountId)
        self.title = CurrentAccount.Name
        PageView.TransactionCollectionView.reloadData()
        PageView.TotalAmountLabel.text = "$\(CurrentAccount.GetTotalValue())"
    }
    
    @objc private func handleWithdrawButtonPress() {
        presentNewTransactionVcWith(transactionType: TransactionType.Withdrawal)
    }
    
    @objc private func handleDepositButtonPress() {
        presentNewTransactionVcWith(transactionType: TransactionType.Deposit)
    }
    
    private func presentNewTransactionVcWith(transactionType: TransactionType) {
        let newTransactionVc : NewTransactionViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "newTransactionVc") as! NewTransactionViewController
        newTransactionVc.NewTransactionType = transactionType
        newTransactionVc.AccountName = CurrentAccount.Name
        self.navigationController?.pushViewController(newTransactionVc, animated: true)
    }
    
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfTransactions = CurrentAccount.Transactions.count
        return numberOfTransactions
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let transactionForCell = CurrentAccount.Transactions[indexPath.row]
        let cell = PageView.TransactionCollectionView.dequeueReusableCell(withReuseIdentifier: PageView.TransactionCellId, for: indexPath) as! TransactionCell
        cell.setTransactionInfo(transaction: transactionForCell)
        return cell
    }
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height : CGFloat = self.view.frame.height*0.065
        let width : CGFloat = PageView.TransactionCollectionView.frame.width
        let size = CGSize(width: width, height: height)
        return size
    }
}

