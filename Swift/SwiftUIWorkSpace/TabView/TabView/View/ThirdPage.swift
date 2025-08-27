//
//  ThirdPage.swift
//  TabView
//
//  Created by Jun Jong Eck on 8/6/25.
//


import SwiftUI

struct ThirdPage: View {
    @State var currentDate = Date()
    @State var selectedDate = Calendar.current.date(byAdding:.hour, value: 1, to: Date())! // 선택시간이 현재시간보다 1시간 뒤로 가게 된다.
    @State var bgColor : Color = .white
    @State var cnt: Int = 0
    
    let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    
    var dateFomatter : DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        return formatter
    }
    
    
    

    var body: some View {
        ZStack {
            bgColor
                .ignoresSafeArea()
            VStack(content: {
                Text("알람 시간 맞추기")
                    .bold()

                Text("현재시간 : \(currentDate, formatter: dateFomatter)")
                    .onReceive(timer, perform: {input in // closure
                        checkTime(input)
                    })
                /*
                 Date()... : 현재일 부터 미래만 선택
                 ...Date() : 현재일 부터 과거만 선택
                 in을 없애면 날짜 제한 없이 사용
                 */
                DatePicker("", selection: $selectedDate, in: Date()...,
                           displayedComponents: [.date, .hourAndMinute])
                .labelsHidden()
                .datePickerStyle(.wheel)
                .padding()
                
                Text("선택시간 : \(selectedDate, formatter: dateFomatter)")
            })
            .padding()
        }
    }// Body
    // -- Functions ----
    func checkTime(_ t: Date) {
        currentDate = t
        let fommater = DateFormatter()
        
        fommater.dateFormat = "hh:mm aaa"
        let alarmTime = fommater.string(from: selectedDate)
        let currentTime = fommater.string(from: t)
        
        cnt += 1
        
        if alarmTime == currentTime {
            if cnt % 2 == 0 {
                bgColor = .blue
            }else{
                bgColor = .red
            }
        }else{
            bgColor = .white
            cnt = 0
        }
    }
}// View

#Preview {
    ContentView()
}
