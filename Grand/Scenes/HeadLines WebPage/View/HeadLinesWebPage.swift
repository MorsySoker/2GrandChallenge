//
//  HeadLinesWebPage.swift
//  Grand
//
//  Created by MorsyElsokary on 22/07/2022.
//

import UIKit
import WebKit

final class HeadLinesWebPage: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var headlineWebPage: WKWebView!
    
    // MARK: - Properties
    
    private var webPageURL: String?
    
    // MARK: - init
    
    init(webPageURL: String) {
        
        self.webPageURL = webPageURL
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        loadWebPage()
    }
    
    // MARK: - Methods
    
    private func loadWebPage() {
        
        guard let webPageURL = webPageURL,
              let url = URL(string: webPageURL) else {
            return
        }
        
        let request = URLRequest(url: url)
        headlineWebPage.load(request)
    }
}
