//
//  HeadLineCategories.swift
//  Grand
//
//  Created by MorsyElsokary on 26/07/2022.
//

import UIKit

protocol HeadLineCategoriesDelegate: AnyObject {
    
    func didSelect(category: String)
}

class HeadLineCategories: NibLoadingView {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var categoriesCollection: UICollectionView!
    
    // MARK: - Properties
    
    private enum Categories: String, CaseIterable {
        
        case business
        case entertainment
        case general
        case health
        case science
        case sports
        case technology
    }
    
    weak var delegate: HeadLineCategoriesDelegate?
    
    // MARK: - Methods
    
    private func setupCollectionView() {
        
        categoriesCollection.register(cellType: CategoryCell.self)
        categoriesCollection.dataSource = self
        categoriesCollection.delegate = self
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.scrollDirection  = .horizontal
        categoriesCollection!.collectionViewLayout = layout
        
        categoriesCollection.reloadData()
    }
    
    override func setupView() {
        setupCollectionView()
    }
}

// MARK: - Collection DataSource

extension HeadLineCategories: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
            
            Categories.allCases.count
        }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoryCell.identifier,
                for: indexPath) as? CategoryCell else {
                
                fatalError("Could Not Find CategoryCell")
            }
            
            cell.text =
            Categories
                .allCases[indexPath.row]
                .rawValue
                .capitalized
            
            return cell
        }
}

// MARK: - Collection Delegate

extension HeadLineCategories: UICollectionViewDelegate {
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath) {
            
            let category = Categories.allCases[indexPath.row].rawValue
            if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCell,
            let delegate = delegate {
                
                cell.backgroundColor = .systemBlue
                delegate.didSelect(category: category)
            }
        }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didDeselectItemAt indexPath: IndexPath) {
            
            if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCell {
                
                cell.backgroundColor = .systemGreen
            }
        }
}

// MARK: - Collection FlowLayout

extension HeadLineCategories: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = categoriesCollection.frame.size.width / 2.5
            
            return CGSize(width: width, height: 56)
        }
    
}
