//
//  PostVM.swift
//  Raven
//
//  Created by Jorge Torres on 25/09/22.
//

import Foundation

struct PostVM: Codable, Hashable, Comparable {

    let dislplayTitle: String
    let author: String
    let created_at: String
    let url: URL?
    let story_id: UInt?

    var fixedDate: String {
        guard let updatedDate = created_at.convertDate() else { return "NA" }
        let interval = Date() - updatedDate
        if interval.month ?? 0 >= 12 {
            return "+1y"
        }
        if interval.month ?? 0 > 0 {
            return "\(interval.month!)M"
        }
        if interval.day ?? 0 > 0 {
            return "\(interval.day!)d"
        }
        if interval.hour ?? 0 > 0 {
            return "\(interval.hour!)h"
        }
        if interval.minute ?? 0 > 0 {
            return "\(interval.minute!)m"
        }
        return "\(interval.second!)s"
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(story_id)
    }

    static func == (lhs: PostVM, rhs: PostVM) -> Bool {
        return lhs.story_id == rhs.story_id
    }

    static func < (lhs: PostVM, rhs: PostVM) -> Bool {
        lhs.story_id! > rhs.story_id!
    }

init(post: Post) {
        dislplayTitle = (post.story_title ?? post.title ?? "NA").htmlDecoded
        author = (post.author ?? "NA").htmlDecoded
        url = URL(string: post.story_url ?? "")
        created_at = post.created_at ?? ""
        story_id = post.story_id
    }

    static func setupModel(usgin model: Posts) -> [PostVM] {
        return Set(model).map({PostVM(post: $0)})
    }
}
