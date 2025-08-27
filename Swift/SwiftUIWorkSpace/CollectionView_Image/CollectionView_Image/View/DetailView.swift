//
//  DetailView.swift
//  CollectionView_Image
//
//  Created by Jun Jong Eck on 8/7/25.
//

import SwiftUI

struct DetailView: View {
    @State var name: String = ""
    var body: some View {
        Image(name)
            .resizable()
            .scaledToFit()
            .frame(width: 300, height: 400)
            .clipShape(.buttonBorder)
            .padding()
    }
}

#Preview {
    DetailView()
}
