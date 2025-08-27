//
//  main.swift
//  07_반복문
//
//  Created by Jun Jong Eck on 8/4/25.
//

import Foundation

// 반복문 : For-In Loop
// 반복문을 통한 배열 처리
let names = ["Anna", "Alex", "Brain", "Jack"]
for name in names {
    print("Hello \(name) ~~!")
}

for (index, text) in names.enumerated() {
    print("The namme at index \(index) is \(text)")
}

//  반복문을 통한 Dictionary 처리
let numberOfLegs = ["Spider": 8, "ant": 6, "cat": 4]
for(animalName, legCount) in numberOfLegs {
    print( "\(animalName)'s have \(legCount) legs")
}

// 반복문을 통한 범위 연산자 처리
let seq1 = 1...5
for index in seq1 {
    print("\(index) time 5 is \(index * 5).")
}

let seq2 = (1...5).reversed()
for index in seq2 {
    print("\(index) time 5 is \(index * 5).")
}

// 증가치 간격 조정
let minutes = 60
let minuteInterval = 5

for tickMark in stride(from: 0, to: minutes, by: minuteInterval) {
    print(tickMark)
}

for tickMark in stride(from: 0, through: minutes, by: minuteInterval) {
    print(tickMark)
}

let strings = ["First String", "Second String", "Third String", "Fourth String"]

for string in strings {
    if string.starts(with: "F") { // F로 시작하는
        print(string)
    }
}


for string in strings{
    if string.starts(with: "T") {
        break
    }
    print(string)
}

for string in strings{
    if string.starts(with: "T") {
        continue // 제외
    }
    print(string)
}


// while
var startIndex = 0
var endIndex = 100
var sum = 0

while startIndex <= endIndex {
    sum += startIndex
    startIndex += 1
}

print(sum)

// ---
startIndex = 0
endIndex = 100
sum = 0

while true {
    sum += startIndex
    startIndex += 1
    
    if startIndex > endIndex {
        break
    }
}
print(sum)


/*
 1부터 100까지의 수 중 짝수의 합과 홀수의 합을 while문을 사용하여 작성하기
 */

var startIndex2 = 0
var endIndex2 = 100
var evenSum = 0
var oddSum = 0

while startIndex2 <= endIndex2 {
    if startIndex2 % 2 == 0 {
        evenSum += startIndex2
    } else {
        oddSum += startIndex2
    }
    startIndex2 += 1
}

print("Even sum: \(evenSum)")
print("Odd sum: \(oddSum)")
