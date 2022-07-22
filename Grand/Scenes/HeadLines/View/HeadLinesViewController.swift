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

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Methods
    
    private func setCollectionView() {
        
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        UICollectionViewCell()
    }
}
