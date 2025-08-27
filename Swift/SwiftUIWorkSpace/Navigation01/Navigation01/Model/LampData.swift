//
//  LampData.swift
//  Navigation01
//
//  Created by Jun Jong Eck on 8/6/25.
//

import SwiftUI

// 데이터 모델 정의

class LampData: ObservableObject {
    @Published var sharedData: String = ""
    @Published var sharedLampStatus: String = "lamp_on"
}
