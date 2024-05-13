//
//  TrainViewController.swift
//  MathTrainer
//
//  Created by Maksims Šalajevs on 12/05/2024.
//

import UIKit

final class TrainViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var buttonsCollection: [UIButton]!
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    
    @IBOutlet weak var questionLabel: UILabel!
    // MARK: - Properties
    private let uiBuilder = UIBuilder()
    
    private var counter: Int = 0 {
        didSet {
            print("count")
        }
    }
    
    private var firstNumber = 0
    private var secondNumber = 0
    var sign: String = ""

    var type: MathTypes = .add {
        didSet {
            switch type {
            case .add:
                sign = "+"
            case .subtract:
                sign = "-"
            case.multiply:
                sign = "*"
            case .divide:
                sign = "/"
            }
        }
    }
    
    private var answer: Int {
        switch type {
        case .add:
            return firstNumber + secondNumber
        case .subtract:
            return firstNumber - secondNumber
        case .multiply:
            return firstNumber * secondNumber
        case .divide:
            return firstNumber / secondNumber
        }
    }
    

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureQuestion()
        randomNumberButtons()
        uiBuilder.configureButtons(buttonsCollection)
    }
    
    //MARK: - IBActions
    @IBAction func leftAction(_ sender: UIButton) {
        check(answer: sender.titleLabel?.text ?? "", for: sender)
    }
    @IBAction func rightAction(_ sender: UIButton) {
        check(answer: sender.titleLabel?.text ?? "", for: sender)
    }
    
    
    
    // MARK: - Methods
    
    private func randomNumberButtons() {
        let isRightButton = Bool.random()
        var randomAnswer: Int
        
        repeat {
            randomAnswer = Int.random(in: (answer - 10)...(answer + 10))
        } while randomAnswer == answer
        
                    rightButton.setTitle(isRightButton ? String(answer) : String(randomAnswer), for: .normal)
                    leftButton.setTitle(isRightButton ? String(randomAnswer) : String(answer), for: .normal)
        // 
        uiBuilder.configureButtons(buttonsCollection)
    }
    
    private func configureQuestion() {
        firstNumber = Int.random(in: 1...99)
        secondNumber = Int.random(in: 1...99)
        
        let question: String = "\(firstNumber) \(sign) \(secondNumber) ="
        questionLabel.text = question
    }
    
    private func check(answer: String, for button: UIButton ) {
        let isRightAnswer = Int(answer) == self.answer
        
        button.backgroundColor = isRightAnswer ? .green : .red
        if isRightAnswer {
            counter += 1
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                
                self?.configureQuestion()
                self?.randomNumberButtons()
                //self?.uiBuilder.configureButtons(buttonsCollection)
            }
        }
    }
}
