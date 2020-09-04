//
//  BudgetsViewController.swift
//  CashTrack
//
//  Created by Jake Edwards on 7/30/20.
//  Copyright © 2020 Jake Edwards. All rights reserved.
//

import UIKit

class BudgetsViewController: UIViewControllerBase, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    private var PageView = BudgetsPageView()
    private var BudgetCellId: String = "budgetCellId"
    private var BudgetFooterCellId: String = "budgetFooterCellId"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        didUpdateBudgets()
    }

    override func setupNavBar() {
        super.setupNavBar()
        let currentMonthString = DataStore.shared.CurrentMonth.getMonthString()
        self.title = "Jake's \(currentMonthString)"
    }
    
    override func setupPageView() {
        self.view.addSubview(PageView)
        PageView.setTopAnchor(to: self.view.safeAreaLayoutGuide.topAnchor)
        PageView.setBottomAnchor(to: self.view.safeAreaLayoutGuide.bottomAnchor)
        PageView.setLeadingAnchor(to: self.view.leadingAnchor)
        PageView.setTrailingAnchor(to: self.view.trailingAnchor)
    }
    
    internal override func setupPageViewChildren() {
        PageView.BudgetsCollectionView.delegate = self
        PageView.BudgetsCollectionView.dataSource = self
        PageView.BudgetsCollectionView.register(BudgetCell.self, forCellWithReuseIdentifier: BudgetCellId)
        PageView.BudgetsCollectionView.register(BudgetFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: BudgetFooterCellId)
    }
    
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfBudgets = DataStore.shared.getNumberOfBudgets()
        return numberOfBudgets
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let budgetForCell = DataStore.shared.getBudget(at: indexPath.row)
        
        let cell = PageView.BudgetsCollectionView.dequeueReusableCell(withReuseIdentifier: BudgetCellId, for: indexPath) as! BudgetCell
        cell.setBudgetInfoForCell(with: budgetForCell)
        return cell
    }
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height : CGFloat = self.view.frame.height*0.105
        let width : CGFloat = PageView.BudgetsCollectionView.frame.width
        let size = CGSize(width: width, height: height)
        return size
    }
    
    internal func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionFooter:
            let footerCell = PageView.BudgetsCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BudgetFooterCellId, for: indexPath) as! BudgetFooterView
            let footerTapRecognizer = UITapGestureRecognizer(target:self, action:#selector(footerTapped))
            footerCell.addGestureRecognizer(footerTapRecognizer)
            return footerCell
        default:
            assert(false, "unexpected element kind")
        }
    }
    
    internal func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let budgetDetailViewController: BudgetDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "budgetDetailVC") as! BudgetDetailViewController
        budgetDetailViewController.setInfoForBudget(at: indexPath.row)
        self.navigationController?.pushViewController(budgetDetailViewController, animated: true)
    }
    
    @objc func footerTapped() {
        let newBudgetViewController: NewBudgetViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "newBudgetViewController") as! NewBudgetViewController
        self.navigationController?.pushViewController(newBudgetViewController, animated: true)
    }
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let height : CGFloat = self.view.frame.height*0.035
        let width : CGFloat = PageView.BudgetsCollectionView.frame.width
        let size = CGSize(width: width, height: height)
        return size
    }
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let insets = UIEdgeInsets(top: UIValues.EdgePadding, left: 0, bottom: UIValues.EdgePadding, right: 0)
        return insets
    }
    
    internal func didUpdateBudgets() {
        PageView.BudgetsCollectionView.reloadData()
        
        let currentPotForAllBudgets = DataStore.shared.getToalCurrentPotForAllBudgets()
        PageView.CurrentPotAmount.text = "$\(currentPotForAllBudgets)"
        
        let totalAllocatedForAllBudgets = DataStore.shared.getTotalAllocatedForAllBudgets()
        PageView.AllocatedAmount.text = "$\(totalAllocatedForAllBudgets)"
        
        let totalSpentForAllBudgets = DataStore.shared.getTotalSpentForAllBudgets()
        PageView.SpentAmount.text = "$\(totalSpentForAllBudgets)"
        
        let amountRemainingForAllBudgets = DataStore.shared.getTotalRemainingForAllBudgets()
        PageView.NetAmount.text = "$\(amountRemainingForAllBudgets)"
    }
}

