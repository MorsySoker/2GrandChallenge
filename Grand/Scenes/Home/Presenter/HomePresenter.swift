//
//  HomePresenter.swift
//  Grand
//
//  Created by MorsyElsokary on 21/07/2022.
//

import Foundation

protocol HomePresenterViewDelegate: AnyObject {
    
    func reloadTableView()
}

final class HomePresenter {
    
    // MARK: - Properties
    
    private var filterdArticles: [Article]?
    private let networkService: FilterdNewsService
    weak var viewDelegate: HomePresenterViewDelegate!
    
    // MARK: - init
    
    init(networkService: FilterdNewsService) {
        self.networkService = networkService
    }
    
    // MARK: - Methods
    
    func getArticlesAbout(keyword: String) {
        
        networkService.getArticlesWith(keyword: keyword)
        { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                
            case .success(let articals):
                self.filterdArticles = articals.articles
                self.viewDelegate.reloadTableView()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getArticlesCount() -> Int {
        
        guard let filterdArticles = filterdArticles else {
            return 0
        }
        
        return filterdArticles.count
    }
    
    func getArticle(at indexpath: Int) -> Article? {
        guard let filterdArticles = filterdArticles else {
            return nil
        }

        return filterdArticles[indexpath]
    }
}
