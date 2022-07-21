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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    // MARK: - Methods
    
    private func setupTableView() {
        
        newsFeedTableView.register(cellType: NewsTableViewCell.self)
        newsFeedTableView.delegate = self
        newsFeedTableView.dataSource = self
        newsFeedTableView.reloadData()
    }
}

extension HomeViewController: UITableViewDelegate {
    
    
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            10
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
           
            let artical = Article(
                source: Source(id: "1", name: "Meroo"),
                author: "Morsy",
                title: "Morsy's legacy",
                articleDescription: "baskdjhaskjdbaksjdbakjsdbakjsdbaksjdbakjsdbakjsdbakjsdbakjsdbakjsdbakjsdbaksjdbakjsdbakjsdbakjsdbakjsdbakjsdbakjsdbakjsdbakjsdbakjsdbakjsdbakjsdbakjsbddasndbasmndbasdnbamsndbmasndbmansdbmansdbmansdbmansdbamnsdbmasndbm",
                url: "",
                urlToImage: "https://www.reuters.com/resizer/oiXutKfCRq-clmZjgSL4a2DvKq4=/1200x628/smart/filters:quality(80)/cloudfront-us-east-2.images.arcpublishing.com/reuters/WN7VZDNMNRLC3FN2F327ABM3NY.jpg",
                publishedAt: Date(),
                content: "baskdjhaskjdbaksjdbakjsdbakjsdbaksjdbakjsdbakjsdbakjsdbakjsdbakjsdbakjsdbaksjdbakjsdbakjsdbakjsdbakjsdbakjsdbakjsdbakjsdbakjsdbakjsdbakjsdbakjsdbakjsbddasndbasmndbasdnbamsndbmasndbmansdbmansdbmansdbmansdbamnsdbmasndbm")
            
            newsCell.article = artical
            
            return newsCell
        }
}
