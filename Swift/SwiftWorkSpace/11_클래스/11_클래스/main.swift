//
//  main.swift
//  11_클래스
//
//  Created by Jun Jong Eck on 8/5/25.
//

import Foundation

// Parent Class
class Animal{
    var name : String
    
    init(name : String){
        self.name = name
    }
    
    func speak(){
        print("\(name)이 소리를 냅니다.")
    }
}

let animal = Animal(name: "동물")
animal.speak()

// Sub Class
class Dog : Animal{// animal에서 Dog로 상속받는다.
    
    override func speak(){
        print("\(name)이 멍멍 짖습니다.")
    }
}

let dog = Dog(name: "제임스")
dog.speak()


// Sub Class - 2 : init <- Property를 추가하고 싶다
class Cat : Animal{
    var breed: String
    
    init(name: String, breed: String){
        self.breed = breed
        super.init(name: name) // 부모 클래스 초기화
    }
    
    override func speak(){
        print("\(name) \(breed) 가 야옹하고 웁니다.")
    }
    
}

let cat: Cat = Cat(name: "고양이", breed: "제임스")
cat.speak( )
