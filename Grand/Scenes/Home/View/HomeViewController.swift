//
//  HomeViewController.swift
//  Grand
//
//  Created by MorsyElsokary on 21/07/2022.
//

import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var newsFeedTableView: UITableView!
    @IBOutlet private weak var newsSearchBar: UISearchBar!
    @IBOutlet private weak var activityIndicator: AppActivityIndicator!
    @IBOutlet private weak var paginationController: PaginationController!
    
    // MARK: - Properties
    
    private var presenter: HomePresenter?
    
    // MARK: - init
    
    init(presenter: HomePresenter) {
        self.presenter = presenter
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
        navigationController?.setNavigationBarHidden(true, animated: animated)
        if let presenter = presenter {
            presenter.viewDelegate = self
            presenter.getArticlesAbout()
        }
    }
    
    // MARK: - Methods
    
    private func setupViews() {
        
        if let presenter = presenter {
            paginationController.changePageNumber(number: "\(presenter.currentPage)")
        }
        paginationController.delegate = self
        setupTableView()
        setupSearchBar()
    }
    
    private func setupTableView() {
        
        newsFeedTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        newsFeedTableView.register(cellType: NewsTableViewCell.self)
        newsFeedTableView.delegate = self
        newsFeedTableView.dataSource = self
        newsFeedTableView.rowHeight = UITableView.automaticDimension
        reloadTableView()
    }
    
    private func setupSearchBar() {
        
        newsSearchBar.delegate = self
        newsSearchBar.placeholder = "Enter a Topic Name"
        newsSearchBar.searchBarStyle = .minimal
    }
}

// MARK: - View Delegate

extension HomeViewController: HomePresenterViewDelegate {

    func reloadTableView() {
        DispatchQueue.main.async {
            UIView.performWithoutAnimation {
                self.newsFeedTableView.reloadData()
            }
        }
    }
    
    func startActivityIndicator() {
        
        DispatchQueue.main.async {
            UIView.performWithoutAnimation {
                self.activityIndicator.startAnimating()
                self.newsFeedTableView.isHidden = true
            }
        }
    }
    
    func stopActivityIndicator() {
        
        DispatchQueue.main.async {
            UIView.performWithoutAnimation {
                self.activityIndicator.stopAnimating()
                self.newsFeedTableView.isHidden = false
            }
        }
    }
}

// MARK: - TableView Delegate

extension HomeViewController: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath) {
        
            if let preseter = presenter {
                let detailedArticle = DetailedHomeViewController()
                detailedArticle.article = preseter.getArticle(
                    at: indexPath.row)
                pushVC(viewController: detailedArticle)
            }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layoutIfNeeded()
    }
}

// MARK: - TableView DataSource

extension HomeViewController: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            guard let preseter = presenter else {
                return 0
            }
            return preseter.getArticlesCount()
        }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let newsCell =
                    tableView.dequeueReusableCell(
                        withIdentifier: NewsTableViewCell.identifier,
                        for: indexPath) as? NewsTableViewCell else {
                fatalError("xib doesn't exist")
            }
            
            guard let presenter = presenter else {
                return newsCell
            }
            
            newsCell.article = presenter.getArticle(at: indexPath.row)
            
            return newsCell
        }
}

// MARK: - SearchBar Delegate

extension HomeViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        newsFeedTableView.isHidden = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        newsFeedTableView.isHidden = false
        self.newsSearchBar.endEditing(true)
    }
    
    func searchBar(
        _ searchBar: UISearchBar,
        textDidChange searchText: String) {
            
            guard let presenter = presenter else {
                return
            }
            presenter.searchKeyword = searchText
            presenter.currentPage = 1
            paginationController.changePageNumber(number: "\(presenter.currentPage)")
            presenter.getArticlesAbout(keyword: searchText)
    }
}

// MARK: - Pagination Delegate

extension HomeViewController: PaginationControllerDelegate {
    
    func getNextPage() {
        
        if let presenter = presenter {
            if presenter.currentPage <  Int(presenter.numberOfPages!) {
                presenter.currentPage+=1
                presenter.getArticlesAbout(
                    keyword: presenter.searchKeyword,
                    page: String(presenter.currentPage))
                paginationController.changePageNumber(number: "\(presenter.currentPage)")
            }
        }
    }
    
    func getPreviousPage() {
        
        if let presenter = presenter {
            if presenter.currentPage > 1 {
                presenter.currentPage-=1
                presenter.getArticlesAbout(
                    keyword: presenter.searchKeyword,
                    page: String(presenter.currentPage))
                paginationController.changePageNumber(number: "\(presenter.currentPage)")
            }
        }
    }
}
