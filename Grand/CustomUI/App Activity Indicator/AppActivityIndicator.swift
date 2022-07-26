//
//  AppActivityIndicator.swift
//  Grand
//
//  Created by MorsyElsokary on 26/07/2022.
//

import UIKit
import NVActivityIndicatorView

class AppActivityIndicator: UIView {

    // MARK: - Outlets
    
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var activityIndicator: NVActivityIndicatorView!
    
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
        setupActivityIndicator()
    }

    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView

        return nibView
    }

    
    private func setupActivityIndicator() {
        
        activityIndicator.type = .pacman
        activityIndicator.color = .systemGreen
        activityIndicator.padding = 25
    }
    
    // MARK: - Activity Actions
    
    func startAnimating() {
        
        activityIndicator.startAnimating()
    }
    
    func stopAnimating() {
        
        activityIndicator.stopAnimating()
    }
}
