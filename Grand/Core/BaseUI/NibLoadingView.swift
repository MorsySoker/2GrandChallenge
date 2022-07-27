//
//  NibLoadingView.swift
//  Grand
//
//  Created by MorsyElsokary on 26/07/2022.
//

import Foundation
import UIKit

class NibLoadingView: UIView {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var view: UIView!
    
    // MARK: - init
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
        
    }
    
    // MARK: - nib Setup
    
    private func nibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true

        addSubview(view)
        setupView() 
    }

    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView

        return nibView
    }
    
    func setupView() {
        
    }
}
