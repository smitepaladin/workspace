//
//  ContentView.swift
//  ImageView
//
//  Created by Jun Jong Eck on 8/5/25.
//

import SwiftUI

struct ContentView: View {
    @State var lampWidth:[CGFloat] = [320.0, 130.0]
    @State var lampHeight:[CGFloat] = [500.0, 200.0]
    @State var imageLamp:[String] = ["lamp_on","lamp_off"]
    @State var imageLargeSmallSeq:Bool = true
    @State var toggleStatus:Bool = true // Swift에서 스위치는 토글이다.

    
    var body: some View {
        VStack(content: {
            Image(toggleStatus ? imageLamp[0] : imageLamp[1])
                .resizable()
                .frame(
                    width: imageLargeSmallSeq ? lampWidth[0] : lampWidth[1],
                    height: imageLargeSmallSeq ? lampHeight[0] : lampHeight[1]
                )
                .fixedSize()
                .padding()
                .frame(width: 400, height: 550) // padding까지 하고 이걸 해줘야 크기가 고정이 된다.
            
            HStack(content:{
                
                VStack(content: {
                    
                    Text("전구 확대")
                    
                    Toggle("", isOn: $imageLargeSmallSeq)
                        .labelsHidden() // 이걸 해야 화면에서 제대로 나온다.
                })
                .padding()
                
                VStack(content: {
                    
                    Text("전구스위치")
                    
                    Toggle("", isOn: $toggleStatus)
                        .labelsHidden() // 이걸 해야 화면에서 제대로 나온다.
                })
                .padding()
            })
        })
    } // Body
} // View

#Preview {
    ContentView()
}
