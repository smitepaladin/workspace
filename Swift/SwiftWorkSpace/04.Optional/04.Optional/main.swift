//
//  main.swift
//  04.Optional
//
//  Created by Jun Jong Eck on 8/4/25.
//

import Foundation

// --- Optional
// : 데이터가 있을 수도 있고 없을 수도 있다.
// : nil값을 포함할 수도 있고, 포함 안 할수도 있다.

var constantNum = 100
// constantNum = nil
var optionalNum: Int? = nil
var optionalNum1: Int! = nil // 둘 다 된다. 보통 정의할 때는 ? 를 쓰고 사용할 때는 ! 를 쓰는 경향이 있다.

optionalNum = 100
print(optionalNum! + 10) // ! 로 optional을 벗긴것이다. Unwrapping

// Optional Unwrapping
// - Forced Unwrapping : !로 무조건 wrapping
// - Optional Binding
// : nil check + 안전한 값 추출 : memory안의 변수의 값이 있는지 없는지를 확인하고 추출한다.


var myName: String? = nil
// print(myName)
if let name = myName {
    print(name)
} else {
    print("found nil")
}


var myName2: String? = "James"
var yourName2: String? = nil

if let name = myName2, let friend = yourName2{
    print("\(name) and \(friend)")
}else{
    print("found nil")
}

// guard let

func multiplyByTen(value: Int?){ // value라는 parameter값. 내가 보는 parameter와 사용자가 보는 parameter가 다를 수 있다.
    guard let number = value, number > 10 else {
        print("Number is too low")
        return
    }
    
    let result = number * 10
    print(result)
}

multiplyByTen(value: 20)
