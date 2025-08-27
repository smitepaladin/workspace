//
//  main.swift
//  06_조건문
//
//  Created by Jun Jong Eck on 8/4/25.
//

import Foundation

// IF 조건문
let personAge = 14

if personAge < 1 {
    print("baby")
}else if personAge < 3{
    print("toddler")
}else if personAge < 5{
    print("preschooler")
}else if personAge < 13{
    print("gradeschooler")
}else if personAge < 18{
    print("teen")
}else{
    print("adult")
}

// Switch 조건문
switch personAge{
case 0..<1: print("baby")
case 1..<3: print("toddler")
case 3..<5: print("preschooler")
case 5..<13: print("gradeschooler")
case 13..<18: print("teen")
default: print("adult")
}

let someCharater: Character = "Z"
switch someCharater {
case "a", "A": print("The first letter of the alphabet")
case "z", "Z": print("The last letter of the alphabet")
default : print("Some other character")
}

let someInteger = 100
switch someInteger{
case 0: print("zero")
case 1..<100 : print("1~99")
case 100: print("100")
case 101...Int.max: print("over 100")
default: print("unknown")
}

// Tuple과 Switch
let somePoint = (1, 1)
switch somePoint {
case (0, 0):
    print("origin")
case (_, 0):
    print("y axis")
case (0, _):
    print("x axis")
case(-2...2, -2...2):
    print("inside the box")
default:
    print("somewhere else")
}


// avg가 85일때의 수우미양가 표시
// if 문으로
let score = 85
var grade = ""

if score >= 90{
    print("수")
}else if score >= 80{
    print("우")
}else if score >= 70{
    print("미")
}else if score >= 60{
    print("양")
}else{
    print("가")
}


// switch 문으로

switch score{
case 90...100: print("수")
case 80..<90: print("우")
case 70..<80: print("미")
case 60..<70: print("양")
default: print("가")
}

// 3항연산자로
print(score >= 90 ? "수" : score >= 80 ? "우" : score >= 70 ? "미" : score >= 60 ? "양" : "가")

// 배열을 만들어 for 문으로 해보기

let grades = ["수", "우", "미", "양", "가"]
var score1 = [90,80,70,60,0]

for i in 0..<score1.count{
    if score >= score1[i]{
        grade = grades[i]
        break
    }
}

print("점수 등급은 \(grade)입니다.")
