import SwiftUI

struct ContentView: View {
    let arrNumber = ["10", "20", "25", "35", "40", "51", "61", "71", "81", "91"]
    @State var dispNumber = ""
    @State var indexNumber = 0
    @State var dispArr = ""

    var body: some View {
        VStack {
            Text(dispArr)
                .padding()

            Text(dispNumber)
                .bold()
                .font(.system(size: 50))
            
            HStack{
                
                Button("Prev", action: {
                    prevData()
                })
                
                Button("Next", action: {
                    nextData()
                })

            }
            .padding()
            .onAppear(perform: {
                dispNumber = arrNumber[indexNumber]
                for i in arrNumber {
//                    dispArr += i == arrNumber[arrNumber.count - 1] ? i : i+","
                    if i == arrNumber[arrNumber.count - 1] {
                        dispArr += i
                    } else {
                        dispArr += i+","
                    }
                }
            })
        }
    }// Body

    // --- Functions ---
    func nextData() {
        indexNumber += 1
        if indexNumber >= arrNumber.count {
            indexNumber = 0
        }
        dispNumber = arrNumber[indexNumber]
    }
    
    func prevData() {
        indexNumber -= 1
        if indexNumber < 0 {
            indexNumber = arrNumber.count - 1
        }
        dispNumber = arrNumber[indexNumber]
    }
    
}// View

#Preview {
    ContentView()
}
