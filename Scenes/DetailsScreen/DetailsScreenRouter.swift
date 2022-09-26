//
//  DetailScreenRouter.swift
//  Raven
//
//  Created by Jorge Torres on 25/09/22.
//

import UIKit

protocol DetailsScreenRouter: NavigateToMainRouter { }

class DetailsScreenRouterImpl: DetailsScreenRouter {

    var uiEntryPoint: UIEntryPoint
    var viewControllerFactory: ViewControllerFactory

    init(viewControllerFactory: ViewControllerFactory, uiEntryPoint: UIEntryPoint) {
        self.viewControllerFactory = viewControllerFactory
        self.uiEntryPoint = uiEntryPoint
    }
}
