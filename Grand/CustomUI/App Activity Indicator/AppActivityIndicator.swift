//
//  AppActivityIndicator.swift
//  Grand
//
//  Created by MorsyElsokary on 26/07/2022.
//

import UIKit
import NVActivityIndicatorView

class AppActivityIndicator: NibLoadingView {

    // MARK: - Outlets

    @IBOutlet private var activityIndicator: NVActivityIndicatorView!

    // MARK: - Methods
    
    override func setupView() {
        
        setupActivityIndicator()
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
