//
//  ContentView.swift
//  PhotoLibrary
//
//  Created by Jun Jong Eck on 8/7/25.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    
    @State var selectedItem: PhotosPickerItem? // 선택 안 할 수도 있으니 optional
    @State var image: UIImage?
    
    var body: some View {
        VStack(content: {
            PhotosPicker("Select an image", selection: $selectedItem, matching: .images)
                .onChange(of: selectedItem, {
                    Task{
                        if let data = try? await selectedItem?.loadTransferable(type: Data.self) { // Data는 모든타입을 다 포함함
                            image = UIImage(data: data)
                        }
                    }
                    
                    
                })
            Spacer()
            
            if let image{
                Image(uiImage : image)
                    .resizable()
                    .scaledToFit()
            }
            
            Spacer()
        })

    } //Body
}//View

#Preview {
    ContentView()
}
