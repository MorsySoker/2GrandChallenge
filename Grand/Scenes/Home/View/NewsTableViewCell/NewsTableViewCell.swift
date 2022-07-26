//
//  NewsTableViewCell.swift
//  Grand
//
//  Created by MorsyElsokary on 21/07/2022.
//

import UIKit

final class NewsTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var articleImage: UIImageView!
    @IBOutlet private weak var articleDescription: UILabel!
    @IBOutlet private weak var articlePublishedAt: UILabel!
    @IBOutlet private weak var articleAuthor: UILabel!
    @IBOutlet private weak var contanierView: UIView!
    
    // MARK: - Properties
    
    var article: Article? {
        didSet {
            guard let article = article else {
                return
            }

            setData(with: article)
        }
    }

    // MARK: - Nib Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupViews()
    }
    
    // MARK: - Methods
    
    private func setupViews() {
        
        contanierView.setBorder(borderWidth: 1, color: .systemGray2)
        contanierView.layer.cornerRadius = 10
        articleImage.layer.cornerRadius = 10
        articleImage.clipsToBounds = true
    }
    
    private func setData(with article: Article) {
        
        articleImage.downloaded(from: article.urlToImage!)
        articleAuthor.text = article.author?.uppercased() ?? "Unknown"
        articleDescription.text = article.articleDescription
        articlePublishedAt.text = article.publishedAt
    }
}
