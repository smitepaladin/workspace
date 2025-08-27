//
//  main.swift
//  03.기본연산자
//
//  Created by Jun Jong Eck on 8/1/25.
//

import Foundation

// Tuple을 사용한 연산자 할당
let (x1, x2) = (1, 2)
let (y1, y2) = (3, "Kim")

// 단항 음수 연산자
let one = 1
let minusOne = -one
let plusOne = -minusOne

print((1, "zebra") < (2, "apple")) // 첫번째에서 true이기 때문에 그대로 끝남
print((1, "apple") < (1, "bird")) // 첫번째 false면 두번째로 가서 ASC코드비교
print((1, "apple") == (1, "app")) // 두번째까지 가서 비교
print((1, "apple") > (1, "app")) // 두번째까지 가서 비교
print((1, true) == (1, false)) // swift에서 true false는 0, 1이 아니다.

// 삼항 조건 연산자
let contentHeight = 40
let hasHeader = true
let rowHeight = contentHeight + (hasHeader ? 55 : 20)

// nil병합 연산자
let defaultColorName = "red"
var userDefinedColorName: String?
var colorName = userDefinedColorName ?? defaultColorName
print(colorName)


// 범위 연산자
for i in 1...10{
    print(i)
}

// 1부터 10까지의 합계 구하기
// 출력예 : 1~10의 합계는 55 입니다.

var sum: Int = 0
for i in 1...10{
    sum += i
}
print("1부터 10까지의 합계는 \(sum) 입니다.")

// 구구단 2단에서 9단까지 출력
for i in 2...9 {
    print("----\(i)단----")
    for j in 1...9 {
        print("\(i) * \(j) = \(i*j)")
    }
    print()
}

// 반닫힌 범위 연산자
//for i in 1..<10{
//    
//}

let names = ["Alice", "Bob", "Charlie", "Kenny"]

for i in 0..<names.count {
    print(names[i])
}

// 배열을 다른 배열로 할당 후 출력
let a1 = [-1, -2, -3, 0, 1, 2, 3]
let b1 = a1[2...]
let c1 = a1[...2]
print(b1, c1)

print(b1.contains(-1))

// 논리 연산자
// 논리 부정 연산자
let allowedEntry = false
if !allowedEntry{
    print("Access Denied")
}

// 논리 곱 연산자
let enteredDoorCode = true
let passRetinaScan = false

if enteredDoorCode && passRetinaScan{
    print( "Access Granted")
} else {
    print("Access Denied")
}

// 논리 합 연산자

if enteredDoorCode || passRetinaScan{
    print( "Access Granted")
} else {
    print("Access Denied")
}


//print("숫자를 입력하세요!", terminator: "")
//var temp = readLine()!
//print(temp)

/*
 Ex :
 단을 입력하세요 : __
 구구단 출력하기
 */

print("단을 입력하세요!", terminator: "__")
var guguDan: String = readLine()!
print(guguDan)

for i in 1...9 {
    print("\(guguDan) * \(i) = \(Int(guguDan)! * i)")
}
