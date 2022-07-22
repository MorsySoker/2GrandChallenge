//
//  HeadLinesViewController.swift
//  Grand
//
//  Created by MorsyElsokary on 22/07/2022.
//

import UIKit

class HeadLinesViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private var headLinesCollection: UICollectionView!

    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setCollectionView()
    }
    
    // MARK: - Methods
    
    private func setCollectionView() {
        
        headLinesCollection.register(cellType: HeadLinesCell.self)
        headLinesCollection.delegate = self
        headLinesCollection.dataSource = self
        
        headLinesCollection.reloadData()
        configureLayout()
    }
}

// MARK: - CollectionView Delegate

extension HeadLinesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("shit")
    }
}

// MARK: - CollectionView DataSource

extension HeadLinesViewController: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
            
        10
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let headlineCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HeadLinesCell.identifier,
            for: indexPath) as? HeadLinesCell else {
                
                fatalError("Couldn't dequeue Cell")
            }
            
            let model = HeadLineCellViewModel(
                imageURL: "https://www.reuters.com/pf/resources/images/reuters/reuters-default.png?d=101",
                title: "Morsyljkndaskjdaksjdbakjsdbakjsdbajksdbakjsdbaksjdbakjsdbakjsdbakjsdbakjsdbakjsdbakjsdbakjsdbakjsdbjkasbdakjsdbakjsdbaksjdbakjsdbakjsdbakjsdbakjsdbakjsdbakjsdbakjsdbakjsbdkajsdbkajbsd",
                auther: "Morsy",
                articleURL: "")
            
            headlineCell.article = model
            
            return headlineCell
    }
}

// MARK: - Layout Handling

extension HeadLinesViewController {
    
    private func configureLayout() {
        
        headLinesCollection.collectionViewLayout = UICollectionViewCompositionalLayout(
            sectionProvider: { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
                
                let spacing = 16.0
                let isPhone =
                layoutEnvironment.traitCollection.userInterfaceIdiom == UIUserInterfaceIdiom.phone
                let size = NSCollectionLayoutSize(
                    widthDimension: NSCollectionLayoutDimension.fractionalWidth(1.0),
                    heightDimension: NSCollectionLayoutDimension.estimated(80.0)
                )
                let itemCount = isPhone ? 1 : 4
                let item = NSCollectionLayoutItem(layoutSize: size)
                item.contentInsets = NSDirectionalEdgeInsets(
                    top: spacing,
                    leading: spacing/2,
                    bottom: spacing,
                    trailing: spacing/2)
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: itemCount)
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(
                    top: spacing,
                    leading: spacing,
                    bottom: spacing,
                    trailing: spacing)
                section.interGroupSpacing = spacing
                
                return section
            })
    }
}
