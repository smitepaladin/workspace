//
//  main.swift
//  01_상수와변수
//
//  Created by Jun Jong Eck on 8/1/25.
//

import Foundation
// 문자열은 무조건 쌍따옴표!
// 홑따옴표는 문자 하나만.
// cmd + d 한줄복사
print("Hello, World!")
print("안녕하세요!")
print(12345)
print("123+456=", 123+456)
print("🥶") // 이모지도 변수명으로 선언 가능

/*
 -- 상수와 변수 --
 상수 : let으로 선언
 변수 : var로 선언
 let variable : Type = 값
 var variable : Type = 값
 */

// 상수로 변수 선언
var message = "Hello, World!"
print(message)

message = "apple"

let intLetNum1: Int = 10
let intLetNum2: Int = 20

print(intLetNum1 + intLetNum2)

let intLetNum3: Int
let intLetNum4 = 30

let inputA = 100
let inputB = 200
let sum: Int
// 상수는 반드시 타입을 정해줘야만 쓸 수 있다.
// Swift의 타입은 맨앞 반드시 대문자
sum = inputA + inputB
print("sum: \(sum)") // String Inerpolation

var nickName: String
nickName = "유비"
nickName = "관우"
nickName = "장비"

print("Name :", nickName) // ,는 한칸 띄기
print("Name :"+nickName) // + 는 그냥 붙여서
print("Name : \(nickName)") // 역슬래시 가로는 String interpolation!

let aNum = 9, bNum = 10

let age: Int = 10
print("저는 \(age)살 입니다.")


let age1: Int = 14
print("저의형은 \(age1)살 입니다.")
// 저의 형은 14살 입니다.
print("저는 \(age+2)살 입니다.")

var price = 300
var cnt = 5


// 초코파이 가격은 300원이고 수량은 5이며 합계는 1500원 입니다.

print ("초코파이 가격은 \(price)원이고 수량은 \(cnt)이며 합계는 \(price*cnt)원 입니다.")


