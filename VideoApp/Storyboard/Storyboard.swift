//
//  File.swift
//  VideoApp
//
//  Created by Beherith on 07.09.19.
//  Copyright © 2019 Beherith. All rights reserved.
//

import UIKit

protocol IdentifiableStoryboard: RawRepresentable where RawValue == String {
    static var identifier: String { get }
}

enum Storyboard {
    enum Main: String, IdentifiableStoryboard {
        static let identifier = "Main"
        
        case videoGallery = "VideoGallery"
    }
}

extension IdentifiableStoryboard {
    static func viewController<ViewController: UIViewController>(withIdentifier identifier: Self) -> ViewController {
        let storyboard = UIStoryboard(name: self.identifier, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier.rawValue) as! ViewController
    }
}
