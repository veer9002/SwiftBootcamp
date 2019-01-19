//
//  QuestionBank.swift
//  SwiftBootcamp
//
//  Created by Manish Sharma on 06/01/19.
//  Copyright © 2019 Manish Sharma. All rights reserved.
//

import Foundation

class QuestionBank {
    
    var list = [Question]()
    
    init() {
        list.append(Question(text: "My name is Manish", correctAns: true))
        list.append(Question(text: "My name is Bhaarat", correctAns: false))
        list.append(Question(text: "I am software eng ", correctAns: true))
        list.append(Question(text: "I practice coding daily", correctAns: false))
        list.append(Question(text: "I commute to baroda daily", correctAns: true))
        list.append(Question(text: "I live in Nadiad", correctAns: true))
    }
    
}
