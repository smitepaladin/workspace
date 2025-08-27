//
//  SecondPage.swift
//  TabView
//
//  Created by Jun Jong Eck on 8/6/25.
//

import SwiftUI

struct SecondPage: View {
    @State var lampWidth:[CGFloat] = [320.0, 130.0]
    @State var lampHeight:[CGFloat] = [500.0, 200.0]
    @State var imageLamp:[String] = ["lamp_on","lamp_off"]
    @State var imageLargeSmallSeq:Int = 0
    @State var toggleStatus:Bool = true // Swift에서 스위치는 토글이다.
    @State var buttonString:String = "축소"
    
    var body: some View {
        VStack(content: {
            Image(toggleStatus ? imageLamp[0] : imageLamp[1])
                .resizable()
                .frame(width: lampWidth[imageLargeSmallSeq], height: lampHeight[imageLargeSmallSeq])
                .fixedSize()
                .padding()
                .frame(width: 400, height: 550) // padding까지 하고 이걸 해줘야 크기가 고정이 된다.
            
            HStack(content: {
                Button(buttonString, action:{
                    displayImage(buttonString)
                })
                .padding(.trailing)
                
                Text(toggleStatus ? "켜짐" : "꺼짐")
                
                Toggle("", isOn: $toggleStatus)
                    .labelsHidden() // 이걸 해야 화면에서 제대로 나온다.
            })

        })
    } // Body
    
    // --- Functions ---
    func displayImage(_ s: String){
        if s == "축소" {
            imageLargeSmallSeq = 1
            buttonString = "확대"
        }else{
            imageLargeSmallSeq = 0
            buttonString = "축소"
        }
    }
} // View

#Preview {
    ContentView()
}
