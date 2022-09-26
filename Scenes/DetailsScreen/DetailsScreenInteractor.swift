//
//  DetailsScreenInteractor.swift
//  Raven
//
//  Created by Jorge Torres on 25/09/22.
//

import Foundation

protocol DetailsScreenInteractor {
     var presenter: DetailsScreenPresenter! { get set }

    func presentView()
    func getData(data: PostVM)
}

class DetailsScreenInteractorImpl: DetailsScreenInteractor {

     var presenter: DetailsScreenPresenter!

    func presentView() {
        presenter.presentViewType()
     }

    func getData(data: PostVM) {
        presenter.presentData(data)
    }
}
