//
//  WalletViewController.swift
//  Cash.Track
//
//  Created by Jake Edwards on 7/7/19.
//  Copyright © 2019 Big Ahi Software. All rights reserved.
//

import UIKit

class WalletViewController : UIViewControllerBase, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, WalletUpdateDelegate {
    private var PageView = WalletPageView()
    private var CurrentWallet : Wallet!
    
    override public func viewDidLoad() {
        didUpdateAccount()
        super.viewDidLoad()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        didUpdateAccount()
        let total = CurrentWallet.GetTotalValue()
        self.view.backgroundColor = UIHelpers.getPosNegColorFor(total: total)
    }
    
    public func setWalletInfo(forId walletId: Int) {
        CurrentWallet = Store.shared.getWalletFor(walletId: walletId)
    }
    
    internal override func setupPageView() {
        self.view.addSubview(PageView)
        PageView.setTopAnchor(to: self.view.safeAreaLayoutGuide.topAnchor)
        PageView.setLeadingAnchor(to: self.view.leadingAnchor, withPadding: 2*EdgePadding)
        PageView.setTrailingAnchor(to: self.view.trailingAnchor, withPadding: -2*EdgePadding)
        PageView.setBottomAnchor(to: self.view.bottomAnchor)
    }
    
    internal override func setupPageViewChildren() {
        PageView.NewTransactionButton.addTarget(self, action: #selector(transitionToNewTransactionVc), for: .touchUpInside)
        
        PageView.TransactionCollectionView.delegate = self
        PageView.TransactionCollectionView.dataSource = self
        PageView.TransactionCollectionView.register(TransactionCell.self, forCellWithReuseIdentifier: PageView.TransactionCellId)
    }
    
    internal func didUpdateAccount() {
        let walletId = CurrentWallet.WalletId
        CurrentWallet = Store.shared.getWalletFor(walletId: walletId)
        self.title = CurrentWallet.Name
        PageView.TransactionCollectionView.reloadData()
        let amount = CurrentWallet.GetTotalValue()
        PageView.TotalAmountLabel.text = "\(amount)"
    }
    
    @objc private func transitionToNewTransactionVc() {
        let newTransactionVc : NewTransactionViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "newTransactionVc") as! NewTransactionViewController
        newTransactionVc.WalletId = CurrentWallet.WalletId
        self.navigationController?.pushViewController(newTransactionVc, animated: true)
    }
    
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfTransactions = CurrentWallet.Transactions.count
        return numberOfTransactions
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let transactionForCell = CurrentWallet.Transactions[indexPath.row]
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

