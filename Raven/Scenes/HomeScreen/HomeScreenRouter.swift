//
//  HomeScreenRouter.swift
//  Raven
//
//  Created by Jorge Torres on 24/09/22.
//

import UIKit

protocol HomeScreenRouter {
    func navigateToDetails(with model: PostVM, from viewController: UIViewController)
    func displayAlert(_ alert: UIAlertController, from viewController: UIViewController)
}

class HomeScreenRouterImpl: HomeScreenRouter {

    internal let viewControllerFactory: ViewControllerFactory

    init(viewControllerFactory: ViewControllerFactory ) {

        self.viewControllerFactory = viewControllerFactory
    }

    func navigateToDetails(with model: PostVM, from viewController: UIViewController) {
        var next = viewControllerFactory.navigateDetailPage()
        next.config = model
        guard let nextVC = next as? UIViewController else { return }
        nextVC.loadViewIfNeeded()
        viewController.navigationController?.pushViewController(nextVC, animated: true)
    }

    func displayAlert(_ alert: UIAlertController, from viewController: UIViewController) {
        alert.loadViewIfNeeded()
        viewController.present(alert, animated: true)
    }
}
