//
//  PaginationController.swift
//  Grand
//
//  Created by MorsyElsokary on 26/07/2022.
//

import UIKit

protocol PaginationControllerDelegate: AnyObject {
    
    func getNextPage()
    func getPreviousPage()
}

class PaginationController: NibLoadingView {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var pageNumberLabel: UILabel!
    
    // MARK: - Properties
    
    weak var delegate: PaginationControllerDelegate?
    
    func changePageNumber(number: String) {
        
        pageNumberLabel.text = "Page: \(number)"
    }
    
    // MARK: - Actions
    
    @IBAction private func nextPage() {
        
        if let delegate = delegate {
            delegate.getNextPage()
        }
    }
    
    @IBAction private func previousPage() {
        
        if let delegate = delegate {
            delegate.getPreviousPage()
        }
    }
    
}
