//
//  CategoryCell.swift
//  Grand
//
//  Created by MorsyElsokary on 26/07/2022.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var categoryName: UILabel!
    
    
    // MARK: - Properties
    
    var text: String? {
        didSet {
            if let text = text {
                categoryName.text =  text
            }
        }
    }

    // MARK: - Awake from nib
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .systemGreen
        categoryName.textColor = .white
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
    }
}
