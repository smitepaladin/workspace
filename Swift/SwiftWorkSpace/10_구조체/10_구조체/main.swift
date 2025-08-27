//
//  main.swift
//  10_구조체
//
//  Created by Jun Jong Eck on 8/5/25.
//

import Foundation

// 구조체 : Swift에서 Type을 정의 / 상속할 수 없는 Class

struct Sample{
    // Property
    var sampleProperty: Int = 10 // 가변 프로퍼티 var니까
    let fixedSampleProperty: Int = 10 // 불변 프로퍼티 let이니까
    static var typeProperty: Int = 100 // Type property
    
    func instanceMethod(){
        print("instance method")
    }
    
    static func typeMethod(){
        print("type method")
    }
}

// 구조체 사용
var samp: Sample = Sample()
print(samp.sampleProperty)
samp.sampleProperty = 20
// samp.fixedSampleProperty = 30 // 못바꾼다.

var samp1: Sample = Sample()
print(samp1.sampleProperty) // 위의 samp와는 관련이 없다.

// 타입 프로퍼티 메서드
Sample.typeProperty = 200 // 원래 struct도 200으로 바뀐다.
print(Sample.typeProperty)
Sample.typeMethod()

// 학생 구조체
struct Student{
    var name: String = "unkown"
    var `class`: String = "swift"
    
    static func selfIntroduce(){
        print("학생 타입 입니다.")
    }
    
    func selfIntroduce(){
        print("저는 \(`class`)반 \(name) 입니다.")
    }
}

Student.selfIntroduce()

var student: Student = Student()
student.name = "kenny"
student.class = "Swift"
student.selfIntroduce()
// class처럼 사용, 상속불가 받는것은 됨
struct Student1{
    var name: String
    var klass: String
    
    init(name: String, klass: String) {
        self.name = name
        self.klass = klass
    }
    
    static func selfIntroduce(){
        print("학생 타입 입니다.")
    }
    
    func selfIntroduce(){
        print("저는 \(klass)반 \(name) 입니다.")
    }
}

var student1: Student1 = Student1(name: "James", klass: "Java")

student1.selfIntroduce()
