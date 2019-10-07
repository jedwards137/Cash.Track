//
//  HomeViewController.swift
//  Cash.Track
//
//  Created by Jake Edwards on 10/6/19.
//  Copyright © 2019 Big Ahi Software. All rights reserved.
//

import UIKit

class HomeViewController: UIViewControllerBase, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource  {
    private var PageView = HomePageView()
    
    override func setupNavBar() {
        super.setupNavBar()
        self.title = "Jed's Cash"
    }
    
    override func setupPageView() {
        self.view.addSubview(PageView)
        PageView.setTopAnchor(to: self.view.topAnchor)
        PageView.setBottomAnchor(to: self.view.bottomAnchor)
        PageView.setLeadingAnchor(to: self.view.leadingAnchor)
        PageView.setTrailingAnchor(to: self.view.trailingAnchor)
    }
    
    internal override func setupPageViewChildren() {
        PageView.NewTransactionButton.addTarget(self, action: #selector(transitionToNewTransactionPage), for: .touchUpInside)
        PageView.TransactionCollectionView.delegate = self
        PageView.TransactionCollectionView.dataSource = self
        PageView.TransactionCollectionView.register(TransactionCell.self, forCellWithReuseIdentifier: PageView.TransactionCellId)
        PageView.TransactionCollectionView.register(TransactionHeader.self, forSupplementaryViewOfKind:
            UICollectionView.elementKindSectionHeader, withReuseIdentifier: PageView.TransactionHeaderId)
    }
    
    @objc private func transitionToNewTransactionPage() {
        let newTransactionViewController : NewTransactionViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "newTransactionViewController") as! NewTransactionViewController
        self.navigationController?.pushViewController(newTransactionViewController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let totalForAllWallets = DataStore.shared.getTotalForAllTransactions()
        PageView.TotalAmountLabel.text = "\(totalForAllWallets)"
        PageView.TransactionCollectionView.reloadData()
    }
    
//    internal func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        // go to selected transaction
//        //        let idForSelectedWallet = Store.shared.WalletData[indexPath.row].WalletId
////        let walletVc : WalletViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "walletVc") as! WalletViewController
////        walletVc.setWalletInfo(forId: idForSelectedWallet)
////        self.navigationController?.pushViewController(walletVc, animated: true)
//    }
    
    internal func numberOfSections(in collectionView: UICollectionView) -> Int {
        let numberOfSections = DataStore.shared.TransactionsByDate.count
        return numberOfSections
    }
    
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfTransactionsInSection = DataStore.shared.TransactionsByDate[section].count
        return numberOfTransactionsInSection
    }
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let height : CGFloat = self.view.frame.height*0.050
        let width : CGFloat = PageView.TransactionCollectionView.frame.width
        let size = CGSize(width: width, height: height)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind:
        String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier:
            PageView.TransactionHeaderId, for: indexPath) as! TransactionHeader
        let sectionDate = DataStore.shared.TransactionsByDate[indexPath.section][0].Date
        header.setSectionDate(to: sectionDate)
        return header
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let transactionForCell = DataStore.shared.TransactionsByDate[indexPath.section][indexPath.row]
        let transactionCell = PageView.TransactionCollectionView.dequeueReusableCell(withReuseIdentifier: PageView.TransactionCellId, for: indexPath) as! TransactionCell
        transactionCell.setTransactionInfo(transaction: transactionForCell)
        return transactionCell
    }
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height : CGFloat = self.view.frame.height*0.065
        let width : CGFloat = PageView.TransactionCollectionView.frame.width
        let size = CGSize(width: width, height: height)
        return size
    }
}
