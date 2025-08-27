//
//  main.swift
//  08_함수
//
//  Created by Jun Jong Eck on 8/4/25.
//

import Foundation

// 함수 (function)

func integerSum(num1: Int, num2: Int) -> Int{
    return num1 + num2
}

print(integerSum(num1: 10, num2: 20))

func greet(person: String) -> String{
    let greeting = "Hello, \(person)!"
    return greeting
}

print(greet(person: "Anna"))

// _로 시작하면 ㅎ마수 호출시 변수명이 출력되지 않음
func buildAddress(_ name: String, 주소 address: String, 시도 city: String) -> String{
    return """
        \(name)
        \(address)
        \(city)
        """
}

print(buildAddress("James", 주소: "서울시 강남구 역삼동", 시도: "서울"))

// 시작 숫자 부터 끝 수자까지의 합계를 구하는 함수

// print(addRange(start:1, end:100))
// 1부터 100까지의 합은 5050 입니다.

func addRange(start: Int, end: Int) -> String{
    var sum = 0
    for i in start...end {
        sum += i
    }
    return "\(start) 부터 \(end)까지의 합은 \(sum) 입니다."
}
print(addRange(start:1, end:100))


// Overloading : 함수의 이름은 중복되도 매개변수의 갯수로 구분이 가능
// 도형의 면적, 둘레를 구하는 함수

func shape(_ r:Double){ // 원의 면적과 둘레
    let pi = 3.14
    let area = r * r * pi
    let border = 2 * pi * r
    print("원 : \(area), \(border)")
}


func shape(_ w:Double, _ h:Double){ // 직사각형의 면적과 둘레
    let area = w * h
    let border = (w+h)*2
    print("직사각형 : \(area), \(border)")
}


func shape(_ w:Int, _ h:Int, _ l:Int){ // 직각삼각형의 면적과 둘레
    let area = w*h / 2
    let border = w+h+l
    print("직각삼각형 : \(area), \(border)")
}

shape(10)
shape(10,20)
shape(10,20,30)

// 여러개의 return value 처리
func sizeConvert(_ length: Float) -> (yards: Float, centimeters: Float, meters: Float){
    let yards = length * 0.2777777777777778
    let centimeters = length * 2.54
    let meters = length * 0.0254
    return (yards, centimeters, meters)
}

let lengthTuple = sizeConvert(20)
print(lengthTuple)
print(lengthTuple.yards)
print(lengthTuple.meters)
print(lengthTuple.centimeters)

