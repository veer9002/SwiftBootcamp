//
//  QuizViewController.swift
//  SwiftBootcamp
//
//  Created by Manish Sharma on 06/01/19.
//  Copyright © 2019 Manish Sharma. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    // IBOutlets
    @IBOutlet weak var lblQuetion: UILabel!
    @IBOutlet weak var lblProgress: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    // properties
    var allQuestion = QuestionBank()
    var pickedAns = false
    var questionNum: Int = 0
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextQuestion()
    }
    
    @IBAction func btnAction(_ sender: UIButton) {
        
        if sender.tag == 1 {
            pickedAns = true
        } else if sender.tag == 2 {
            pickedAns = false
        }
        checkAnwer()
        
        questionNum += 1
        nextQuestion()
        
    }
    
    func checkAnwer() {
        let correctAns = allQuestion.list[questionNum].answer
        if correctAns == pickedAns {
            print("Right")
            score += 1
        } else {
            print("False")
        }
    }
    
    func restart() {
        questionNum = 0
        score = 0
        self.progressBar.setProgress(0, animated: false)
        nextQuestion()
    }
    
    func nextQuestion() {
        if questionNum <= 5 {
            lblQuetion.text = allQuestion.list[questionNum].question
            updateUI()
        } else {
            questionNum = 0
            print("Reset now")
            let alert = UIAlertController(title: "Great", message: "You completed", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart", style: .default) { (UIAlertAction) in
                self.restart()
            }
            alert.addAction(restartAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func updateUI() {
        self.lblScore.text = "Score: \(score)"
        self.lblProgress.text = "\(questionNum + 1) /6"
        print(questionNum)
        self.progressBar.setProgress(Float(questionNum + 1) / 6, animated: true)
        print(questionNum + 1)
    }
    
}
