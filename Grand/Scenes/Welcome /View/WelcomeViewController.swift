//
//  WelcomeViewController.swift
//  Grand
//
//  Created by MorsyElsokary on 23/07/2022.
//

import UIKit


enum Lang: String, CaseIterable {
    
    case arabic
    case english
    case french
    
    func urlLang() -> String {
        
        switch self {
        case .arabic:
            return "ar"
        case .english:
            return "en"
        case .french:
            return "fr"
        }
    }
    
    func getCountryFromLang() -> String {
        
        switch self {
        case .arabic:
            return "eg"
        case .english:
            return "us"
        case .french:
            return "fr"
        }
    }
}

final class WelcomeViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private var langStackView: UIStackView!
    private var isLangSelected: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: - Methods
    
    private func setupView() {
        
        setLangButtons(langs: Lang.allCases)
    }
    
    private func setLangButtons(langs: [Lang]) {
        
        guard langs.count > 0 else {
            return
        }
        
        langs.forEach {
            langStackView.addArrangedSubview(
                createNewLangButton(
                    title: $0.rawValue.capitalized,
                    action: #selector(pressed(sender:))))
        }
        
        langStackView.addArrangedSubview(
            createNewLangButton(
                title: "Confirm",
                btnColor: .magenta,
                action: #selector(confirmAndLog)))
        
        langStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.layoutIfNeeded()
    }
    
    private func createNewLangButton(
        title: String,
        textColor: UIColor = .white,
        btnColor: UIColor = .systemGreen,
        action: Selector) -> UIButton {
        
        let langBtn = UIButton()
        langBtn.setTitle(title, for: .normal)
        langBtn.backgroundColor = btnColor
        langBtn.tintColor = textColor
        langBtn.layer.cornerRadius = 8
        langBtn.clipsToBounds = true
        langBtn.addTarget(
            self,
            action: action,
            for: .touchUpInside)
        
        let heightConstraint = NSLayoutConstraint(
            item: langBtn,
            attribute: NSLayoutConstraint.Attribute.height,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: nil,
            attribute: NSLayoutConstraint.Attribute.notAnAttribute,
            multiplier: 1,
            constant: 56)
        langBtn.addConstraints([heightConstraint])
        
        return langBtn
    }
    
    private func clearSelection() {
        
        langStackView.arrangedSubviews.dropLast().forEach {
            
            if let btn = $0 as? UIButton {
        
                btn.backgroundColor = .systemGreen
                isLangSelected = false
            }
        }
    }
    
    @objc private func pressed(sender: UIButton) {
        
        clearSelection()
        
        if let buttonTitle = sender.title(for: .normal) {
            UserUtilites.saveLang(
                lang: buttonTitle.lowercased())
            sender.backgroundColor = .red
            isLangSelected =  true
        }
    }
    
    // MARK: - Actions
    
    @objc private func confirmAndLog() {
        
        if isLangSelected {
            
            pushVC(viewController: AppCustomTabBarController())
        }
    }
}
