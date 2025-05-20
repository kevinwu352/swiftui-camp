//
//  Storage.swift
//  Design
//
//  Created by Kevin Wu on 4/28/25.
//

import Foundation

public class Storage: @unchecked Sendable {

    public let path: String

    public private(set) var map: [String: Any] {
        didSet {
            guard !path.isEmpty else { return }
            work?.cancel()
            let item = DispatchWorkItem {
                if let data = json_encode(self.map, .prettyPrinted) {
                    data_write(data, self.path)
                }
            }
            queue.asyncAfter(deadline: .now() + 1, execute: item)
            work = item
        }
    }
    private weak var work: DispatchWorkItem?

    private let queue: DispatchQueue

    public init(path: String) {
        self.path = path
        path_create_file(path)

        map = json_decode(data_read(path)) as? [String: Any] ?? [:]

        queue = DispatchQueue(label: "queue-storage-\(UUID().uuidString.lowercased())", attributes: .concurrent)
    }
}

public extension Storage {
    func getBool(_ key: String) -> Bool? {
        queue.sync { map[key] as? Bool }
    }
    func setBool(_ value: Bool?, _ key: String) {
        queue.async(flags: .barrier) { self.map[key] = value }
    }

    func getInt(_ key: String) -> Int? {
        queue.sync { map[key] as? Int }
    }
    func setInt(_ value: Int?, _ key: String) {
        queue.async(flags: .barrier) { self.map[key] = value }
    }

    func getDouble(_ key: String) -> Double? {
        queue.sync { map[key] as? Double }
    }
    func setDouble(_ value: Double?, _ key: String) {
        queue.async(flags: .barrier) { self.map[key] = value }
    }

    func getString(_ key: String) -> String? {
        queue.sync { map[key] as? String }
    }
    func setString(_ value: String?, _ key: String) {
        queue.async(flags: .barrier) { self.map[key] = value }
    }

    func getDate(_ key: String) -> Date? {
        queue.sync {
            if let time = map[key] as? TimeInterval {
                return Date(timeIntervalSince1970: time)
            } else {
                return nil
            }
        }
    }
    func setDate(_ value: Date?, _ key: String) {
        queue.async(flags: .barrier) { self.map[key] = value?.timeIntervalSince1970 }
    }

    func getObject<T: Decodable>(_ key: String) -> T? {
        queue.sync {
            if let json = map[key],
               let data = json_encode(json),
               let value = try? JSONDecoder().decode(T.self, from: data) {
                return value
            } else {
                return nil
            }
        }
    }
    func setObject<T: Encodable & Sendable>(_ value: T?, _ key: String) {
        queue.async(flags: .barrier) {
            if let value = value,
               let data = try? JSONEncoder().encode(value),
               let json = json_decode(data) {
                self.map[key] = json
            } else {
                self.map[key] = nil
            }
        }
    }
}
