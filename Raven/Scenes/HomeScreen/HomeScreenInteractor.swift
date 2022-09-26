//
//  HomeScreenInteractor.swift
//  Raven
//
//  Created by Jorge Torres on 24/09/22.
//

import Foundation

protocol HomeScreenInteractor: AnyObject {
    var presenter: HomeScreenPresenter! { get set }
    var localStorage: LocalStorage! { get set }

    func loadData()
    func deletePost(at position: Int)
}

class HomeScreenInteractorImpl: HomeScreenInteractor {

    weak var presenter: HomeScreenPresenter!
    var data: [PostVM]
    var moreDataAvailable: Bool = true
    var localStorage: LocalStorage!

    private let service: HomeScreenService

    init(service: HomeScreenService) {
        self.service = service
        self.data = [PostVM]()
        self.localStorage = MainLocalStorage()
    }

    func shouldShowLoadingMoreDataMessage() -> Bool {
        return self.moreDataAvailable
    }

    func loadData() {
        self.service.get() { [weak self] posts, error in
            guard let self = self else { return }
            if error != nil {
                guard let data: [PostVM]  = try? self.localStorage.fetch(for: "Posts") else { return }
                self.filterData()
                self.presenter.presentData(data)
                return
            }
            guard let posts = posts else { return }
            self.process(posts)
        }
    }

    fileprivate func filterData() {
        guard let deletedData: [PostVM]  = try? self.localStorage.fetch(for: "RemovedPosts") else { return }
        let deletedSet = Set(deletedData)
        data = Array(Set(data).subtracting(deletedSet))
        data.sort()
    }

    private func process(_ rawData: Posts) {
        data = PostVM.setupModel(usgin: rawData)
        filterData()
        try? self.localStorage.save(data, for: "Posts")
        self.presenter.presentData(data)
    }

    func deletePost(at position: Int) {
        let removedPost = data.remove(at: position)
        var deletedData = [PostVM]()
        deletedData.append(removedPost)
        if let oldDeletedData: [PostVM]  = try? self.localStorage.fetch(for: "RemovedPosts") {
            deletedData.append(contentsOf: oldDeletedData)
        }

        try? self.localStorage.save(deletedData, for: "RemovedPosts")
        self.presenter.presentData(data)
    }
}
