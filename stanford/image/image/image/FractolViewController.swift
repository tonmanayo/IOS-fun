//
//  FractolViewController.swift
//  image
//
//  Created by tony mack on 10/11/17.
//  Copyright © 2017 tony mack. All rights reserved.
//

import UIKit

class FractolViewController: UIViewController, UISplitViewControllerDelegate {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.splitViewController?.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let url = NewUrls.URLs[segue.identifier ?? ""] {
            if let imageVC = (segue.destination.contents as? ImageViewController) {
                imageVC.imageURL = URL(string: url)
                imageVC.title = (sender as? UIButton)?.currentTitle
            }
        }
    }
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary seconderyViewController: UIViewController, onto primaryViewController:  UIViewController) -> Bool {
        if primaryViewController.contents == self {
            if let ivc = seconderyViewController.contents as? ImageViewController, ivc.imageURL == nil {
                return true
            }
        }
        return false
    }
}

extension UIViewController {
    var contents: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? self
        } else {
            return self
        }
    }
}
