//
//  Observable.swift
//  LoginProject
//
//  Created by Allen H on 2022/11/14.
//

import Foundation

class 클래스로감싸진데이터<T> {
    
    // 값이 변할때마다 "나중에호출될수있는함수"(클로저/함수) 호출
    var 데이터값: T {
        didSet {
            나중에호출될수있는함수?(데이터값)
        }
    }
    
    // "데이터값"이 변할때 =====> 함수호출 ⭐️⭐️⭐️
    var 나중에호출될수있는함수: ((T) -> Void)?
    
    init(_ 값: T) {
        self.데이터값 = 값
    }
    
    func 바인딩하기(콜백함수: @escaping (T) -> Void) {
        self.나중에호출될수있는함수 = 콜백함수
    }

}
