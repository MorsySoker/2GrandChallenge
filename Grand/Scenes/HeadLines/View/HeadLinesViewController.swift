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
    }
}

// MARK: - CollectionView Delegate

extension HeadLinesViewController: UICollectionViewDelegate {
    
    
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
            
            return headlineCell
    }
}
