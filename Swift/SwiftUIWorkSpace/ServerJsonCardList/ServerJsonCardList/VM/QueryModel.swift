//
//  QueryModel.swift
//  ServerJson_03
//
//  Created by Jun Jong Eck on 8/7/25.
//

import Foundation

struct QueryModel{
    func loadData(url : URL) async throws -> [newsJSON] {
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([newsJSON].self, from: data)
    }
}
