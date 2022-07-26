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

class PaginationController: UIView {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var pageNumberLabel: UILabel!
    
    // MARK: - Properties
    
    weak var delegate: PaginationControllerDelegate?

    // MARK: - init
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }
    
    // MARK: - Methods
    
    private func nibSetup() {
        containerView = loadViewFromNib()
        containerView.frame = bounds
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerView.translatesAutoresizingMaskIntoConstraints = true

        addSubview(containerView)
    }

    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView

        return nibView
    }
    
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
