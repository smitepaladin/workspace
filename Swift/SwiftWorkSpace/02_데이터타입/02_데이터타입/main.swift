//
//  main.swift
//  02_데이터타입
//
//  Created by Jun Jong Eck on 8/1/25.
//

import Foundation

/*
 기본 데이터 타입
 : Bool, Int, Uint, Float, Double, Character, String
 */
// Bool
var someBool: Bool = true
someBool = false

// 내PC의 OS크기 알기
print("Int :" + String(Int.min) + " ~ " + String(Int.max))
print("Int :" + String(Int8.min) + " ~ " + String(Int8.max))
print("Int :" + String(Int16.min) + " ~ " + String(Int16.max))
print("Int :" + String(Int32.min) + " ~ " + String(Int32.max))
print("Int :" + String(Int64.min) + " ~ " + String(Int64.max))


// Int
var someInt:Int = -100
//someInt = 100.1
someInt = 100_00_00
print(someInt)

// Uint
var someUInt:UInt = 100
//someUInt = -100

// Float
var someFloat:Float = 3.14
someFloat = 3
someFloat = 10_000.44_556

// Double
var someDouble:Double = 3.14

//someDouble = someFloat 불가능. 크기가 다르다.

print(type(of : someDouble))
// 타입을 알려준다

// 숫자 Type 변환
let doubleNum = 4.99999
var castToInt = Int(doubleNum)
var roundtoInt = Int(round(doubleNum))
print(castToInt, roundtoInt)


// Character 한글자!
var someCharacter:Character = "a"
someCharacter = "가"
someCharacter = "😁" // 이모지는 글자다!

// String
var someString:String = "하하하 🤣"

someString = """
12345
            abcde
                가나다라마
"""

print(someString)


// 문자열과 특수문자
print("aa\t\tbb\n\tcc\r\ndd\tef")

let wiseWords = "\'Imaginatioin is more important than knowledge\' - Albert Einstein"
print(wiseWords)
// ' 앞에 역슬래시를 쓰면 찍어낼 수 있다.

// Unicode : 전 세계의 모든 문자를 컴퓨터에서 일관되게 표현하고 다룰 수 있도록 설계된 국제 표준
let dollarSign = "\u{0024}"
let blackHear = "\u{1F600}"
let sparklingHeart = "\u{1F496}"
print(dollarSign, blackHear, sparklingHeart)

let han: Character = "\u{D55C}"
let han1: Character = "\u{1112}\u{1161}\u{11AB}"
print(han, han1)
// 이 유니코드를 가지고 자연어처리를 한다.
// 아래는 조합형(자음 모음 받침)
// 한글은 특이하다. (자음 모음 받침) 을 합친것이 하나의 캐릭터!

// 빈문자열 초기화
var emptyString = "" // String 타입 안써줘도 된다
var emptyString2 = String() // 이런식으로도 초기화 할 수 있다.

if emptyString.isEmpty {
    print("빈문자열")
}

// 문자배열을 이용한 문자열 출력
let strArray: [Character] = ["a", "p", "p", "l", "e"]
print(String(strArray))


// 문자열과 문자의 결합
let string1 = "hello"
let string2 = " there"
var welcome = string1 + string2
print(welcome)

var instruction =  "look over"
instruction += string2
print(instruction)
// ++는 없다.

let exclamationMark: Character = "!"
welcome.append(exclamationMark)
print(welcome)


let str = "12345,6789"
print("str hans : \(str.count) characters.")

if str.count == 0{
    print("Data가 없습니다")
}else{
    print("Data는 \(str) 입니다.")
}

// 문자열 안덱스
let greeting = "Guten Tag!"
print(greeting[greeting.startIndex])
print(greeting[greeting.index(after: greeting.startIndex)])
print(greeting[greeting.index(greeting.startIndex, offsetBy: 7)])
// print(greeting[greeting.endIndex])


// 문자열의 개별 문자 접근
print(greeting)
for index in greeting.indices {
    print(greeting[index], terminator: ",")
}
// indices는 한글자씩 가져온다.

var welcome1 = "hello"
welcome1.insert("!", at: welcome1.endIndex)
print(welcome1)


welcome1.insert(contentsOf: " there", at: welcome1.index(before: welcome1.endIndex))
print(welcome1)

welcome1.remove(at: welcome1.index(before: welcome1.endIndex))
print(welcome1)

let range = welcome1.index(welcome1.endIndex, offsetBy: -6)..<welcome1.endIndex
welcome1.removeSubrange(range)
print(welcome1)
// ... 은 처음부터 끝까지
// ..< 는 거기까지

let greeting1 = "Hello, Wolrd!"
let index1 = greeting1.firstIndex(of: ",") ?? greeting1.endIndex
let beginning = greeting1[..<index1]
print(beginning)
// ?? false면 뒤에 조건 사용

// 접두사와 접미사의 비교

let romeoAndJuliet = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's mansion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    "Act 1 Scene 4: A street outside Capulet's mansion",
    "Act 1 Scene 5: The Great Hall in Capulet's mansion",
    "Act 2 Scene 1: Outside Capulet's mansion",
    "Act 2 Scene 2: Capulet's orchard",
    "Act 2 Scene 3: Outside Friar Lawrence's cell",
    "Act 2 Scene 4: A street in Verona",
    "Act 2 Scene 5: Capulet's mansion",
    "Act 2 Scene 6: Friar Lawrence's cell"
]

var act1SceneCount = 0
for scene in romeoAndJuliet {
    if scene.hasPrefix("Act 1 Scene") {
        act1SceneCount += 1
    }
}

var mansionCount = 0
var cellCount = 0

for scene in romeoAndJuliet {
    if scene.hasSuffix("Capulet's mansion") {
        mansionCount += 1
    } else if scene.hasSuffix("Friar Lawrence's cell") {
        cellCount += 1
    }
}

// Any, nil
// Any : Swift의 모든 Type을 지칭하는 키워드
// nil : 없음을 의미하는 키워드


// Any
var someAny: Any = 100
someAny = "Hello, World!"
someAny = 123.12

var someAny1: Double = 234.56
print(someAny as! Double + someAny1)
// 타입변환

// Tuple
// Tuple전
var dialCode = 82
var isocode = "KR"
var name = "Korea"

print(dialCode, isocode, name)

// Tuple의 사용
var country = (82, "KR", "Korea")
print(country.0, country.1, country.2)


var country1 = (dialCode1 :82, isocode1: "KR", name1: "Korea" )
print(country1.dialCode1, country1.isocode1, country1.name1)
print(country1.0, country1.1, country1.2)

// Type Alias
// : 기본 타입이든 사용자 정의 Type이든 별칭을 사용할 수 있음
typealias Myint = Int
typealias YourInt = Int
typealias MyDouble = Double

let age: Myint = 20

typealias person1 = (name: String, height: Int, marriage : Bool)

var t1:person1 = ("유비", 180, true)
print(t1.name)

/*
 Tuple을 사용하여 직사각형의 넓이와 둘레를 구현
 - 직사각형 속성 : 이름, 가로, 세로, 넓이, 둘레
 - 넓이 : 가로 * 세로
 - 둘레 : (가로+세로) * 2
 */


typealias Rectangle = (name: String, width: Double, height: Double, area: Double, border: Double)

// 직사각형 , 가로 = 5, 세로 = 6
var r1: Rectangle = ("직사각형", 5, 6, 0, 0)
var r2: Rectangle = ("직사각형2", 15, 7, 0, 0)

// 면적
r1.area = r1.width * r1.height
r1.border = (r1.width + r1.height) * 2


