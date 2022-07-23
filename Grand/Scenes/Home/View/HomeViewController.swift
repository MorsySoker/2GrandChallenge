//
//  HomeViewController.swift
//  Grand
//
//  Created by MorsyElsokary on 21/07/2022.
//

import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private var newsFeedTableView: UITableView!
    @IBOutlet private var newsSearchBar: UISearchBar!
    @IBOutlet private var pageCountLabel: UILabel!
    
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
            pageCountLabel.text = "Page: \(presenter.currentPage)"
        }
        
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
    
    // MARK: - Actions
    
    @IBAction private func nextPagePressed() {
        
        if let presenter = presenter {
            if presenter.currentPage <  Int(presenter.numberOfPages!) {
                presenter.currentPage+=1
                presenter.getArticlesAbout(
                    keyword: presenter.searchKeyword,
                    page: String(presenter.currentPage))
                pageCountLabel.text = "Page: \(presenter.currentPage)"
            }
        }
    }
    
    @IBAction private func previousPagePressed() {

        if let presenter = presenter {
            if presenter.currentPage > 1 {
                presenter.currentPage-=1
                presenter.getArticlesAbout(
                    keyword: presenter.searchKeyword,
                    page: String(presenter.currentPage))
                pageCountLabel.text = "Page: \(presenter.currentPage)"
            }
        }
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
            pageCountLabel.text = "Page: \(presenter.currentPage)"
            presenter.getArticlesAbout(keyword: searchText)
    }
}
