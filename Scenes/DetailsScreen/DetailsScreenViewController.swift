//
//  DetailsScreenViewController.swift
//  Raven
//
//  Created by Jorge Torres on 25/09/22.
//

import UIKit

protocol DetailsScreenViewContoller {

    var router: DetailsScreenRouter! { get set }
    var interactor: DetailsScreenInteractor! { get set }
    var config: PostVM! { get set }

//    func displayView(_ viewModel:  ProductDetails.InitUI.ViewModel)
    func showDetails(for data: PostVM)
}

class DetailsScreenViewControllerImpl: DetailsScreenVC, DetailsScreenViewContoller {

    var router: DetailsScreenRouter!
    var interactor: DetailsScreenInteractor!

    var config: PostVM!
//    var uiModel:  ProductDetails.InitUI.ViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactor.presentView()
        self.interactor.getData(data: config)
    }

    func showDetails(for data: PostVM) {
        webView.load(URLRequest(url: data.url!))
        webView.allowsBackForwardNavigationGestures = true
    }
}
