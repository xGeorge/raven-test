//
//  Post.swift
//  Raven
//
//  Created by Jorge Torres on 25/09/22.
//

import Foundation

typealias Posts = [Post]

struct Post: Codable, Hashable {
    let title: String?
    let story_title: String?
    let author: String?
    let created_at: String?
    let story_url: String?
    let story_id: UInt?

    func hash(into hasher: inout Hasher) {
        hasher.combine(story_id)
    }

    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.story_id == rhs.story_id
    }
}
