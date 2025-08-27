//
//  ContentView.swift
//  AlertAction
//
//  Created by Jun Jong Eck on 8/6/25.
//

import SwiftUI

struct ContentView: View {
    @State var isAlert = false
    @State var isActionSheet = false
    
    var body: some View {
        VStack(content: {
            Text("Alert와 Action Sheet")
                .bold()
                .padding()
        
            HStack(spacing: 50,content: {
                Button("Alert", action: {
                    isAlert = true
                })
                .alert("Title", isPresented: $isAlert, actions: {
                    Button("Action Default", role: .none , action: {
                        print("Action Default")
                    })
                    Button("Action Destructive", role: .destructive , action: {
                        print("Action Destructive")
                    })
                    Button("Action Cancel", role: .cancel , action: {
                        print("Action Cancel")
                    })
                },
                message: {
                    Text("Message")
                })
                
                Button("Action Sheet", action: {
                    isActionSheet = true
                })
                .confirmationDialog("Title", isPresented: $isActionSheet, titleVisibility: .visible, actions: {
                    Button("Action Default", role: .none , action: {
                        print("Action Default")
                    })
                    Button("Action Destructive", role: .destructive , action: {
                        print("Action Destructive")
                    })
                    Button("Action Cancel", role: .cancel , action: {
                        print("Action Cancel")
                    })
                },
                message: {
                    Text("Message")
                }
                )
            })
            
            Spacer()
        })
    } // body
} // view

#Preview {
    ContentView()
}
