//
//  DetailedHomeViewController.swift
//  Grand
//
//  Created by MorsyElsokary on 22/07/2022.
//

import UIKit

class DetailedHomeViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var articleImage: UIImageView!
    @IBOutlet private weak var articleSource: UILabel!
    @IBOutlet private weak var articleDescription: UILabel!
    @IBOutlet private weak var articlePublishedAt: UILabel!
    @IBOutlet private weak var articleAuthor: UILabel!
    
    // MARK: - Properties
    
    var article: Article? {
        didSet {
            guard let article = article else {
                return
            }
            view.layoutIfNeeded()
            setData(with: article)
        }
    }
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupViews()
    }
    
    // MARK: - Methods
    
    private func setupViews() {

        articleImage.layer.cornerRadius = 10
        articleImage.clipsToBounds = true
    }
    
    private func setData(with article: Article) {
        
        articleImage.downloaded(from: article.urlToImage!)
        articleSource.text = article.source?.name?.uppercased() ?? "Unknown"
        articleDescription.text = article.articleDescription
        articlePublishedAt.text = article.publishedAt
        articleAuthor.text = article.author ?? "Unknown"
    }
    
    // MARK: - Actions
    
    @IBAction private func popView() {
        
        navigationController?.popViewController(animated: true)
    }
}
