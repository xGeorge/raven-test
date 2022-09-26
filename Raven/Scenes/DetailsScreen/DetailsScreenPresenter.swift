//
//  DetailScreenPresenter.swift
//  Raven
//
//  Created by Jorge Torres on 25/09/22.
//

import UIKit

protocol DetailsScreenPresenter {
    var view: DetailsScreenViewContoller! { get set }

    func presentViewType()
    func presentData(_ data: PostVM)
}

class DetailsScreenPresenterImpl: DetailsScreenPresenter {

    var view: DetailsScreenViewContoller!

    func presentViewType() {
//        let viewModel = { () -> ProductDetails.InitUI.ViewModel in
//             return ProductDetails.InitUI.ViewModel(title: "ÜRÜN DETAYI", color: UIColor.bundleGrey)
//        }()
//        self.view.displayView(viewModel)
    }

    func presentData(_ data: PostVM) {
        self.view.showDetails(for: data)
    }
}

