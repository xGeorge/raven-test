//
//  LaunchScreenRouter.swift
//  Raven
//
//  Created by Jorge Torres on 24/09/22.
//

import UIKit

protocol LaunchScreenRouter {
    func navigateToStart(from viewController: UIViewController)
}

class LaunchScreenRouterImpl: LaunchScreenRouter {

    let viewControllerFactory: ViewControllerFactory

    init(viewControllerFactory: ViewControllerFactory) {
        self.viewControllerFactory = viewControllerFactory
    }

    func navigateToStart(from viewController: UIViewController) {
        let next = self.viewControllerFactory.navigateMainPage()

        let navController = self.viewControllerFactory.navController()
        navController.setViewControllers([next as! UIViewController], animated: false)
        navController.modalPresentationStyle = .fullScreen

        viewController.present(navController, animated: true)
    }
}
