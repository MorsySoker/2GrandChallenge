//
//  HeadLinesPresenter.swift
//  Grand
//
//  Created by MorsyElsokary on 22/07/2022.
//

import Foundation

protocol HeadLinesViewDelegate: AnyObject {
    
    func reloadCollectionView()
}

final class HeadLinesPresenter {
    
    // MARK: - Properties
    
    private var articles: [Article]?
    private let headlineService: HeadLinesService
    weak var headlinesDelegate: HeadLinesViewDelegate!
    var currentPage: Int = 1
    var numberOfPages: Double?
    
    // MARK: - init
    
    init(headlineService: HeadLinesService) {
        
        self.headlineService = headlineService
    }
    
    // MARK: - Methods
    
    func getHeadlines() {
        
        headlineService.getHeadlines { [weak self] result in
            
            guard let self = self else {
                return
            }
            
            switch result {
                
            case .success(let articles):
                self.articles = articles.articles
                self.headlinesDelegate.reloadCollectionView()
                if let totalResults = articles.totalResults {
                    self.numberOfPages = (Double(totalResults)/10).rounded(.up)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getHeadlines(pageNumber: String) {
        
        headlineService.getHeadlines(page: pageNumber) { [weak self] result in
            
            guard let self = self else {
                return
            }
            
            switch result {
                
            case .success(let articles):
                self.articles = articles.articles
                self.headlinesDelegate.reloadCollectionView()

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func healinesCount() -> Int {
        
        guard let articles = articles else {
            return 0
        }

        return articles.count
    }
    
    func getArticle(at indexPath: Int) -> HeadLineCellViewModel? {
        
        guard let articles = articles else {
            return nil
        }
        
        return articles[indexPath].toHeadLineCellViewModel()
    }
}
