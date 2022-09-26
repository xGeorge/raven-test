//
//  Array.swift
//  Raven
//
//  Created by Jorge Torres on 25/09/22.
//

import Foundation

//extension Array where Element: Hashable {
//    func distinct() -> Array<Element> {
//        var set = Set<Element>()
//        return filter { set.insert($0).inserted }
//    }
//}

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
