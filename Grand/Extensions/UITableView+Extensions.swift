//
//  UITableView+Extensions.swift
//  Grand
//
//  Created by MorsyElsokary on 21/07/2022.
//

import UIKit

extension UITableView {
    
    func register<T: UITableViewCell>(cellType: T.Type) {
        let nib = UINib(nibName: cellType.identifier, bundle: nil)
        self.register(nib, forCellReuseIdentifier: cellType.identifier)
    }
}
