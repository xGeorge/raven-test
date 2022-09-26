//
//  HomeScreenService.swift
//  Raven
//
//  Created by Jorge Torres on 24/09/22.
//

import Foundation
import Alamofire

typealias ServicePostResponse = (Posts?, Error?) -> Void

protocol HomeScreenService {
    func get(_ closure: @escaping ServicePostResponse)
}

class HomeScreenServiceImpl: HomeScreenService {

    private let url: String

    init() {
        url = "https://hn.algolia.com/api/v1/search_by_date?query=mobile"
    }

    func get(_ closure: @escaping ServicePostResponse) {
        AF.request(url, method: .get, encoding: JSONEncoding.default)
            .responseDecodable(of: SearchResponse.self) { response in
                guard let posts = response.value?.hits else {
                    closure(nil, response.error)
                    return
                }
                closure(posts, nil)
        }

    }
}
