//
//  DetailView.swift
//  CollectionView_multi
//
//  Created by Jun Jong Eck on 8/7/25.
//

import SwiftUI

struct DetailView: View {
    var animal: Animal
    
    var body: some View {
        VStack(content: {
            Image(animal.imageFileName)
                .resizable()
                .frame(width: 100, height: 100)
                .fixedSize()
                .padding(.bottom, 10)
                .scaledToFit()
            
            Text("이 동물의 이름은 \(animal.name) 이며 \n 분류는 \(animal.category) 이며 날 수 \(animal.flyabel)")
        })
        .navigationTitle("Detail View")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    DetailView(animal: Animal(name: "벌", category: "파충류", flyabel: "있습니다.", imageFileName: "bee"))
}
