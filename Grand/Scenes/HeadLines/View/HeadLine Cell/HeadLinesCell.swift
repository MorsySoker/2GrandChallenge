//
//  HeadLinesCell.swift
//  Grand
//
//  Created by MorsyElsokary on 22/07/2022.
//

import UIKit

class HeadLinesCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var articleImage: UIImageView!
    @IBOutlet private weak var articleAuthor: UILabel!
    @IBOutlet private weak var articleTitle: UILabel!
    
    // MARK: - Properties
    
    var article: HeadLineCellViewModel? {
        didSet {
            guard let article = article else {
                return
            }
            setData(with: article)
        }
    }
    
    // MARK: - Nib Awake
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupViews()
    }
    
    // MARK: - Methods
    
    private func setupViews() {
        
        articleImage.layer.cornerRadius = 10
        articleImage.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.setBorder()
    }
    
    private func setData(with article: HeadLineCellViewModel) {
        
        articleImage.downloaded(from: article.imageURL)
        articleAuthor.text = article.auther
        articleTitle.text = article.title
    }
}
