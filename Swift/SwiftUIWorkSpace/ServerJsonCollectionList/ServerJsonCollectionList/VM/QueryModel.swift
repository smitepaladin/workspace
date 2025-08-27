//
//  QueryModel.swift
//  ServerJson_01
//
//  Created by Jun Jong Eck on 8/7/25.
//

import Foundation

struct QueryModel{
    func loadData(url : URL) async throws -> [MovieJSON] {
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([MovieJSON].self, from: data)
    }
}
