//
//  main.swift
//  12_Extension
//
//  Created by Jun Jong Eck on 8/5/25.
//

import Foundation

// Extension
// 익스텐션은 Struct, Class 타입에 새로운 기능을 추가할 수 있는 기능

extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
    var isOdd: Bool {
        return self % 2 != 0
    }
}

print(1.isEven)
