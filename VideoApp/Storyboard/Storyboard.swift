//
//  File.swift
//  VideoApp
//
//  Created by Beherith on 07.09.19.
//  Copyright © 2019 Beherith. All rights reserved.
//

import UIKit

enum Storyboard: String {
    case main = "Main"
}

extension Storyboard {
    func viewController<ViewController: UIViewController>(withIdentifier identifier: String) -> ViewController {
        let storyboard = UIStoryboard(name: rawValue, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! ViewController
    }
}
