//
//  HomeScreenContext.swift
//  Raven
//
//  Created by Jorge Torres on 24/09/22.
//

import UIKit
import Swinject

class HomeScreenContext: Assembly {

    func assemble(container: Container) {
        container.register(HomeScreenViewController.self) { r in
            let view = HomeScreenViewControllerImpl()

            var interactor = r.resolve(HomeScreenInteractor.self)!
            var presenter = r.resolve(HomeScreenPresenter.self)!
            let router = r.resolve(HomeScreenRouter.self)!

            let serviceStorage = r.resolve(LocalStorage.self)!

            presenter.view = view
            presenter.interactor = interactor
            presenter.router = router
            presenter.alertService = r.resolve(AlertService.self)

            view.presenter = presenter

            interactor.presenter = presenter
            interactor.localStorage = serviceStorage

            return view
        }

        container.register(HomeScreenInteractor.self) { r in
            HomeScreenInteractorImpl(service: r.resolve(HomeScreenService.self)!)
        }

        container.register(HomeScreenPresenter.self) { r in
            HomeScreenPresenterImpl()
        }

        container.register(HomeScreenRouter.self) { r in
            HomeScreenRouterImpl(
                viewControllerFactory: r.resolve(ViewControllerFactory.self)!
            )
        }
    
        container.register(LocalStorage.self) { r in
            MainLocalStorage()
            }.inObjectScope(.container)

        container.register(HomeScreenService.self) { r in
            HomeScreenServiceImpl()
            }.inObjectScope(.container)
    }
}
