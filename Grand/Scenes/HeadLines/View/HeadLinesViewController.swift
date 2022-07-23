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
    @IBOutlet private var pageCountLabel: UILabel!
    
    // MARK: - Properties
    
    private var headlinesPresenter: HeadLinesPresenter?
    
    // MARK: - init
    
    init(headlinesPresenter: HeadLinesPresenter) {
        self.headlinesPresenter = headlinesPresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let headlinesPresenter = headlinesPresenter {
            
            headlinesPresenter.headlinesDelegate = self
            headlinesPresenter.getHeadlines()
        }
    }
    
    // MARK: - Methods
    
    private func setupViews() {
        
        if let headlinesPresenter = headlinesPresenter {
            pageCountLabel.text = "Page: \(headlinesPresenter.currentPage)"
        }
        
        setCollectionView()
    }
    
    private func setCollectionView() {
        
        headLinesCollection.register(cellType: HeadLinesCell.self)
        headLinesCollection.delegate = self
        headLinesCollection.dataSource = self
        
        configureLayout()
    }
    
    // MARK: - Actions
    
    @IBAction private func nextPagePressed() {
        
        if let headlinesPresenter = headlinesPresenter {
            if headlinesPresenter.currentPage <
                Int(headlinesPresenter.numberOfPages!) {
                
                headlinesPresenter.currentPage+=1
                headlinesPresenter.getHeadlines(pageNumber: "\(headlinesPresenter.currentPage)")
                pageCountLabel.text = "Page: \(headlinesPresenter.currentPage)"
                
            }
        }
    }
    
    @IBAction private func previousPagePressed() {
        if let headlinesPresenter = headlinesPresenter {
            if headlinesPresenter.currentPage > 1 {
                headlinesPresenter.currentPage-=1
                headlinesPresenter.getHeadlines(pageNumber: "\(headlinesPresenter.currentPage)")
                pageCountLabel.text = "Page: \(headlinesPresenter.currentPage)"
            }
        }
    }
}

// MARK: - View Delegate

extension HeadLinesViewController: HeadLinesViewDelegate {
    
    func reloadCollectionView() {
        
        DispatchQueue.main.async {
            UIView.performWithoutAnimation {
                self.headLinesCollection.reloadData()
            }
        }
    }
}

// MARK: - CollectionView Delegate

extension HeadLinesViewController: UICollectionViewDelegate {
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath) {
            
            guard let presenter = headlinesPresenter else {
                
                return
            }
            
            let headlinePageVC = HeadLinesWebPage(
                webPageURL: presenter.getArticle(
                    at: indexPath.row)?.articleURL ?? "www.google.com")
            
            present(headlinePageVC, animated: true)
        }
}

// MARK: - CollectionView DataSource

extension HeadLinesViewController: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
            
            guard let presenter = headlinesPresenter else {
                
                return 0
            }
            
            return presenter.healinesCount()
        }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            guard let headlineCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HeadLinesCell.identifier,
                for: indexPath) as? HeadLinesCell else {
                
                fatalError("Couldn't dequeue Cell")
            }
            
            guard let presenter = headlinesPresenter else {
                
                return headlineCell
            }
            
            headlineCell.article = presenter.getArticle(at: indexPath.row)
            
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
