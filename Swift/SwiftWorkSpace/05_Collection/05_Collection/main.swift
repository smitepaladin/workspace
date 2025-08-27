//
//  main.swift
//  05_Collection
//
//  Created by Jun Jong Eck on 8/4/25.
//

import Foundation

/*
 Collection : 여러 값들을 묶어서 하나의 변수로 사용
 
 1) Array : 순서가 있는 리스트 컬렉션
 2) Dictionary : key와 value의 쌍으로 이루어진 컬렉션
 3) Set : 순서가 없고, data가 중복되지 않는 컬렉션
 4) Tuple : 여러개의 값을 하나의 복합 값으로 묶을 수 있는 간단한 방법
 */

// Array
// var intVariable: Array<Int> = Array<Int>()
var intVariable: [Int] = [] // 윗줄보다 이런 방식으로 많이 쓴다.
intVariable.append(1)
intVariable.append(100)
intVariable.append(10)

print(intVariable)
// intVariable.append(100.2)

print(intVariable.contains(100))
print(intVariable.contains(90))

print(intVariable[0])
print(intVariable[0...1])

intVariable.remove(at: 0)
intVariable.removeLast()
intVariable.removeAll()

print(intVariable.count)

var doubleVariable: [Double] = []
var stringVariable: [String] = []

// 문자열 배열
var shoppingList: [String] = ["Eggs", "Milk"]

for i in 0..<shoppingList.count {
        print(shoppingList[i])
}

for i in shoppingList{
    print(i)
}


if shoppingList.isEmpty {
    print ("The shopping list is empty")
}else{
    print("The shopping list is not empty")
}

// 배열에 데이텉 추가
shoppingList.append("Four")
shoppingList += ["Baking Powder"]
shoppingList += ["Chocolate Spread", "cheese", "Butter"]

print(shoppingList)

// 배열 데이터의 수정
shoppingList[0] = "Egg"
print(shoppingList, shoppingList.count)

// 배열 특정 위치 데이터 변경 및 제거
shoppingList[4...6] = ["Banana", "Apple"]
print(shoppingList, shoppingList.count) // 2개가 변경되고 한개가 삭제

// 배열의 삽입
shoppingList.insert("Myple Syrup", at: 0)
print(shoppingList, shoppingList.count)

// 배열의 값과 인덱스가 필요한 경우
for (index, value) in shoppingList.enumerated() {
    print("index: \(index), value: \(value)")
}


// 배열의 합계 구하기 및 최대값 찾기
var tot = 0
var arr = [23, 42, 78, 91, 57, 68, 52, 26, 15, 72]
for i in arr {
    tot += i
}
print("합계 : \(tot)")

tot = 0
for i in 0..<arr.count{
    tot += arr[i]
}
print("합계 : \(tot)")

// 최대값
var max = arr[0]
for i in arr {
    if max < i{
        max = i
    }
}
print("최대값 : \(max)")

// ---
print(arr.max() ?? 0)
print(arr.max()!)

// ----
// Dictionary

// var scoreDictionary: Dictionary<String, Int> = Dictionary<String, Int>()
var scoreDictionary: [String: Int] = [:] // 이 형태를 많이 사용한다.

scoreDictionary["유비"] = 100
scoreDictionary["관우"] = 90
scoreDictionary["장비"] = 80

print(scoreDictionary)
print(scoreDictionary["유비"]!) // key값이 없어도 데이터가 없을 수 없기 때문에 optional을 벗겨주어야 한다.
print(scoreDictionary.count)

// Set
var oddDigits : Set = [1,3,5,7,9]
var evenDigits : Set = [2,4,6,8]
let singleDigitPrimeNumber : Set = [2,3,5,7]

oddDigits.insert(11) // set은 append가 아니라 insert다
print(oddDigits.sorted())

// 합집합
print(oddDigits.union(evenDigits).sorted())

// 교집합
print(oddDigits.intersection(evenDigits).sorted())

// 차집합
print(oddDigits.subtracting(singleDigitPrimeNumber).sorted())

// 여집합
print(oddDigits.symmetricDifference(singleDigitPrimeNumber).sorted())

let houseAnimals: Set = ["dog", "cat"]
let farmAnimals: Set = ["cow", "chicken", "sheep", "dog", "cat"]
let cityAnimals: Set = ["duck", "rabble"]

print(houseAnimals.isSubset(of: farmAnimals)) // 부분집합인지 체크 -> true
print(farmAnimals.isSuperset(of: houseAnimals)) // 모집합인지 체크 -> true
print(farmAnimals.isDisjoint(with: cityAnimals)) // 독립집합인지 체크 -> true

// Tuple
// 이름이 없는 Tuple
var person = ("John", 30)
print(person.0)
print(person.1)

// 이름이 있는 Tuple
let person1 = (name: "James", age: 28)

print(person1.name, person1.0)
print(person1.age, person1.1)

// 함수 이용
func getUserInfo() -> (name: String, age: Int) { // 리턴값! tuple로 리턴해라
    return ("Alex", 40)
}

let user = getUserInfo()

print("이름 : \(user.name), 나이: \(user.age)")
