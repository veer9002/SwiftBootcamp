//
//  Questions.swift
//  SwiftBootcamp
//
//  Created by Manish Sharma on 06/01/19.
//  Copyright © 2019 Manish Sharma. All rights reserved.
//

import Foundation

class Question {
    
    let question: String
    let answer: Bool
    
    init(text: String, correctAns: Bool) {
        question = text
        answer = correctAns
    }
    
}
