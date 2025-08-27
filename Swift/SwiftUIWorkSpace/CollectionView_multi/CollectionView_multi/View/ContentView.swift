//
//  ContentView.swift
//  CollectionView_multi
//
//  Created by Jun Jong Eck on 8/7/25.
//


import SwiftUI

struct ContentView: View {
    @State var animals: [Animal] = [
        Animal(name: "벌", category: "파충류", flyabel: "있습니다.", imageFileName: "bee"),
        Animal(name: "고양이", category: "포유류", flyabel: "없습니다.", imageFileName: "cat"),
        Animal(name: "젖소", category: "포유류", flyabel: "없습니다.", imageFileName: "cow"),
        Animal(name: "강아지", category: "포유류", flyabel: "없습니다.", imageFileName: "dog"),
        Animal(name: "여우", category: "포유류", flyabel: "없습니다.", imageFileName: "fox"),
        Animal(name: "원숭이", category: "영장류", flyabel: "없습니다.", imageFileName: "monkey"),
        Animal(name: "돼지", category: "포유류", flyabel: "없습니다.", imageFileName: "pig"),
        Animal(name: "늑대", category: "포유류", flyabel: "없습니다.", imageFileName: "wolf"),
    ]
    var body: some View {
        
        NavigationView{
            VStack{
                ScrollView(.vertical){
                    LazyVGrid(columns: Array(repeating: GridItem(), count: 2)) {
                        ForEach(animals) { item in
                            NavigationLink(destination: DetailView(animal: item)) {
                                VStack {
                                    Image(item.imageFileName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 150, height: 120)
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                    
                                    
                                    Text(item.name)
                                        .font(.headline)
                                        .foregroundColor(.blue)
                                }
                                
                            }

                        }
                    }
                    .padding()
                }
                .navigationTitle("Main View")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
      

    }//Body
    
    // --- functions ---
    
//    // 삭제 함수
//    func deleteItem(at indexSet: IndexSet) {
//        animals.remove(atOffsets: indexSet)
//    }

}//View


struct BasicImageRow: View {
    var animal: Animal
    
    var body: some View {
        HStack {
            Image(animal.imageFileName)
                .resizable()
                .frame(width: 40, height: 40)
                .clipShape(.buttonBorder)
            
            Text(animal.name)
            
        }
    }
    
        

}
#Preview {
    ContentView()
}
