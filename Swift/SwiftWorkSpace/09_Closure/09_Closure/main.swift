//
//  main.swift
//  09_Closure
//
//  Created by Jun Jong Eck on 8/5/25.
//

import Foundation

// closure 변수에 함수를 담아 사용하는것
let sayHello = {
    print("Hello")
}

sayHello()

// Function
func sumFunction(num1: Int, num2: Int) -> Int{
    return num1 + num2
}

var sumResult: Int = sumFunction(num1: 10, num2: 20)
print(sumResult) // 요새는 이렇게 안 쓴다. 아래 Closure로 확인하자

// Closure
var sumClosure = {
    (num1: Int, num2: Int) -> Int in // 받는 타입, 주는 타입 설정
    return num1 + num2 // 함수 코딩
}

