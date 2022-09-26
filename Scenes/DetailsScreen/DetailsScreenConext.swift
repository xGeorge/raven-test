//
//  DetailsScreenConext.swift
//  Raven
//
//  Created by Jorge Torres on 25/09/22.
//

import UIKit
import Swinject

class DetailsScreenConext: Assembly {

    func assemble(container: Container) {
        container.register(DetailsScreenViewContoller.self) { r in
            let view = DetailsScreenViewControllerImpl()

            var interactor = r.resolve(DetailsScreenInteractor.self)!
            var presenter = r.resolve(DetailsScreenPresenter.self)!
            let router = r.resolve(DetailsScreenRouter.self)!

            view.interactor = interactor
            interactor.presenter = presenter
            presenter.view = view
            view.router = router

            return view
        }

        container.register(DetailsScreenInteractor.self) { r in
            DetailsScreenInteractorImpl()
        }

        container.register(DetailsScreenPresenter.self) { r in
            DetailsScreenPresenterImpl()
        }

        container.register(DetailsScreenRouter.self) { r in
            DetailsScreenRouterImpl(
                viewControllerFactory: r.resolve(ViewControllerFactory.self)!,
                uiEntryPoint: r.resolve(UIEntryPoint.self)!
            )
        }
    }
}
