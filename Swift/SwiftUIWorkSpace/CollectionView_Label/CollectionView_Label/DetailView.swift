//
//  DetailView.swift
//  CollectionView_Label
//
//  Created by Jun Jong Eck on 8/6/25.
//

import SwiftUI

struct DetailView: View {
    @State var name: String = ""
    var body: some View {
        Text(name)
    }
}

#Preview {
    DetailView()
}
