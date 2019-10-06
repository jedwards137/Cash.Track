//
//  HomeViewController.swift
//  Cash.Track
//
//  Created by Jake Edwards on 7/14/19.
//  Copyright © 2019 Big Ahi Software. All rights reserved.
//

import UIKit

class HomeViewController: UIViewControllerBase, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource  {
    private var PageView = HomePageView()
    private var OptionsMenu = TopDownMenu()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Jed's Cash"
        
        /*self.view.addSubview(OptionsMenu)
        OptionsMenu.setTopAnchor(to: self.view.safeAreaLayoutGuide.topAnchor)
        OptionsMenu.setLeadingAnchor(to: self.view.leadingAnchor)
        OptionsMenu.setTrailingAnchor(to: self.view.trailingAnchor)
        
        setupOptionsBarButton()*/
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let totalForAllWallets = Store.shared.getTotalForAllWallets()
        PageView.TotalAmountLabel.text = "\(totalForAllWallets)"
        PageView.WalletsCollectionView.reloadData()
        self.view.backgroundColor = UIHelpers.getPosNegColorFor(total: totalForAllWallets)
    }
    
    internal override func setupPageView() {
        self.view.addSubview(PageView)
        PageView.setTopAnchor(to: self.view.safeAreaLayoutGuide.topAnchor)
        PageView.setLeadingAnchor(to: self.view.leadingAnchor, withPadding: 2*EdgePadding)
        PageView.setTrailingAnchor(to: self.view.trailingAnchor, withPadding: -2*EdgePadding)
        PageView.setBottomAnchor(to: self.view.bottomAnchor)
    }
    
    internal override func setupPageViewChildren() {
        PageView.NewWalletButton.addTarget(self, action: #selector(transitionToNewWalletVc), for: .touchUpInside)
        
        PageView.WalletsCollectionView.delegate = self
        PageView.WalletsCollectionView.dataSource = self
        PageView.WalletsCollectionView.register(WalletCell.self, forCellWithReuseIdentifier: PageView.WalletCellId)
    }
    
    @objc private func transitionToNewWalletVc() {
        let newWalletVc : NewWalletViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "newWalletVc") as! NewWalletViewController
        self.navigationController?.pushViewController(newWalletVc, animated: true)
    }
    
    internal func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let idForSelectedWallet = Store.shared.WalletData[indexPath.row].WalletId
        let walletVc : WalletViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "walletVc") as! WalletViewController
        walletVc.setWalletInfo(forId: idForSelectedWallet)
        self.navigationController?.pushViewController(walletVc, animated: true)
    }
    
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfTransactions = Store.shared.WalletData.count
        return numberOfTransactions
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let walletIdForCell = Store.shared.WalletData[indexPath.row].WalletId
        let cell = PageView.WalletsCollectionView.dequeueReusableCell(withReuseIdentifier: PageView.WalletCellId, for: indexPath) as! WalletCell
        cell.setWalletInfo(forId: walletIdForCell)
        return cell
    }
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height : CGFloat = self.view.frame.height*0.065
        let width : CGFloat = PageView.WalletsCollectionView.frame.width
        let size = CGSize(width: width, height: height)
        return size
    }
    
    /*func setupOptionsBarButton() {
        let optionsButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(openPageOptions))
        self.navigationItem.rightBarButtonItem = optionsButton
    }
    
    @objc func openPageOptions() {
        OptionsMenu.show()
    }*/
}
