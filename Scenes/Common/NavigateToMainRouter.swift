//
//  NavigateToMainRouter.swift
//  Raven
//
//  Created by Jorge Torres on 25/09/22.
//

import UIKit

protocol NavigateToMainRouter {
    var uiEntryPoint: UIEntryPoint { get }
    var viewControllerFactory: ViewControllerFactory { get }

    func navigateToMain(from viewController: UIViewController)
}

extension NavigateToMainRouter {

    func navigateToMain(from viewController: UIViewController) {
        let next = self.viewControllerFactory.navigateMainPage()

        let navController = self.viewControllerFactory.navController()
        navController.setViewControllers([next as! UIViewController], animated: false)
        navController.modalPresentationStyle = .fullScreen

        let launchScreenExtensionViewController = self.uiEntryPoint.rootViewController!
        let startNavController = launchScreenExtensionViewController.presentedViewController! as! UINavigationController

        let startViewController = startNavController.children.first!
        startNavController.setViewControllers([startViewController], animated: false)

        viewController.dismiss(animated: true)

        startNavController.modalPresentationStyle = .fullScreen

        startNavController.present(navController, animated: true)
    }
}

