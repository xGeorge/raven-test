//
//  NavigationController.swift
//  Raven
//
//  Created by Jorge Torres on 24/09/22.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.topItem?.title = ""
        self.modalPresentationStyle = .fullScreen
        self.navigationBar.barTintColor = .white
    }
}
