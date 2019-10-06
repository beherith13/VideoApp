//
//  UICollectionView+VideoApp.swift
//  VideoApp
//
//  Created by Beherith on 08.09.19.
//  Copyright © 2019 Beherith. All rights reserved.
//

import UIKit

extension UICollectionView {
    func dequeueReusableCell<Cell: UICollectionViewCell>(for indexPath: IndexPath) -> Cell {
        let identifier = String(describing: Cell.self)
        return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! Cell
    }    
}
