//
//  HomeScreenPresenter.swift
//  Raven
//
//  Created by Jorge Torres on 24/09/22.
//

import UIKit

protocol HomeScreenPresenter: AnyObject, AlertEmiiter {
    var view: HomeScreenViewController! { get set }
    var interactor: HomeScreenInteractor! { get set }
    var router: HomeScreenRouter! { get set }

    func presentData(_ response: [PostVM])
    func tryToPresentDetails(for model: PostVM)
    func deletePost(at position: Int)
}

class HomeScreenPresenterImpl: HomeScreenPresenter {

    weak var view: HomeScreenViewController!
    var interactor: HomeScreenInteractor!
    var router: HomeScreenRouter!

    var alertService: AlertService!

    func presentData(_ data: [PostVM]) {
        guard let view = self.view else { return }

        view.displayData(data)
    }

    func tryToPresentDetails(for model: PostVM) {
        guard let view = self.view as? UIViewController else { return }
        guard model.url != nil else {
            let alert = self.alertService.alertController(title: "This Post dosnt have an URL", message: "Please check another post")
            alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
            self.router.displayAlert(alert, from: view)
            return
        }
        self.router.navigateToDetails(with: model, from: view)
    }

    func deletePost(at position: Int) {
        self.interactor.deletePost(at: position)
    }
}
