//
//  LocalStorage.swift
//  Raven
//
//  Created by Jorge Torres on 26/09/22.
//

import UIKit

class LocalStorage {
    private let storage: DiskStorage
    private let decoder: JSONDecoder = .init()
    private let encoder: JSONEncoder = .init()
    init(storage: DiskStorage = DiskStorage()) {
        self.storage = storage
    }
    func fetch<T: Decodable>(for key: String) throws -> T {
        let data = try storage.fetchValue(for: key)
        return try decoder.decode(T.self, from: data)
    }
    
    func save<T: Encodable>(_ value: T, for key: String) throws {
        let data = try encoder.encode(value)
        try storage.save(value: data, for: key)
    }
}

final class MainLocalStorage: LocalStorage {
    private static let plistFolder = "MainLocalFolder"

    override init(storage: DiskStorage = DiskStorage()) {
        guard let documentSubdirectoryURL = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true) else {
            super.init(storage: storage)
            return
        }

        let plistURL = URL(
            fileURLWithPath: "MainViewStorage",
            relativeTo: documentSubdirectoryURL.appendingPathComponent(MainLocalStorage.plistFolder))
        super.init(storage: DiskStorage(path: plistURL))
    }
}
