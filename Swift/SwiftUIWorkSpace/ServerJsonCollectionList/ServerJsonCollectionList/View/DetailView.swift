//
//  DetailView.swift
//  ServerJsonCollectionList
//
//  Created by Jun Jong Eck on 8/8/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
    var movie: MovieJSON
    var body: some View {
        Text(movie.title)
        
        WebImage(url: movie.image)
            .resizable()
            .frame(width: 100, height: 150)
            .clipShape(.rect)
            .shadow(radius: 10)
    }
}
