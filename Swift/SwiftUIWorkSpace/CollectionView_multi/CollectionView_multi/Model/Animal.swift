//
//  Animal.swift
//  CollectionView_multi
//
//  Created by Jun Jong Eck on 8/7/25.
//

import Foundation

struct Animal: Identifiable {
    var id = UUID()
    var name: String
    var category: String
    var flyabel: String
    var imageFileName: String
}
