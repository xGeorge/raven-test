//
//  HomeViewController.swift
//  Raven
//
//  Created by Jorge Torres on 24/09/22.
//

import UIKit

protocol HomeScreenViewController: AnyObject {
    var presenter: HomeScreenPresenter! { get set }

    func displayData(_ viewModel: [PostVM])
}

class HomeScreenViewControllerImpl: HomeScreenVC, HomeScreenViewController {

    var presenter: HomeScreenPresenter!
    var posts: [PostVM] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.interactor.loadData()
    }

    func displayData(_ viewModel: [PostVM]) {
        self.posts = viewModel
        self.updateDatasource(insertData: viewModel)
    }

    override func reloadDataAction(_ sender: Any) {
        super.reloadDataAction(sender)
        self.presenter.interactor.loadData()
    }

    override func rowSelected(using model: PostVM) {
        self.presenter.tryToPresentDetails(for: model)
    }

    override func saveModelDeleted(at indexPath: IndexPath) {
        self.presenter.deletePost(at: indexPath.row)
    }

}
