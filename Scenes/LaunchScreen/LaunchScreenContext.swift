//
//  LaunchContextAssembly.swift
//  Raven
//
//  Created by Jorge Torres on 24/09/22.
//

import UIKit
import Swinject

class LaunchScreenContext: Assembly {

    func assemble(container: Container) {
        container.register(LaunchScreenInteractor.self) { r in
            LaunchScreenInteractorImpl()
        }

        container.register(LaunchScreenRouter.self) { r in
            LaunchScreenRouterImpl(viewControllerFactory: r.resolve(ViewControllerFactory.self)!)
        }

        container.register(LaunchScreenViewController.self) { r in
            let view = LaunchScreenViewControllerImpl(nibName: "LaunchScreenViewController", bundle: nil)

            let interactor = r.resolve(LaunchScreenInteractor.self)!
            let router = r.resolve(LaunchScreenRouter.self)!

            view.interactor = interactor
            view.router = router

            return view
        }
    }
}
