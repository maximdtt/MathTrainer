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
    @IBOutlet weak var counterPoints: UILabel!
    
    // MARK: - Properties
    private let uiBuilder = UIBuilder()
    private var firstNumber = 0
    private var secondNumber = 0
    private var sign: String = ""
    private var counter: Int = 0
    
    
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
    
    private var rightAnswer: Int {
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
        
        uiBuilder.configureButtons(buttonsCollection)
        configureQuestion()
    }
    
    //MARK: - IBActions
    @IBAction func leftAction(_ sender: UIButton) {
        checkAnswer(sender.titleLabel?.text ?? "", for: sender)
    }
    @IBAction func rightAction(_ sender: UIButton) {
        checkAnswer(sender.titleLabel?.text ?? "", for: sender)
    }
    
    // MARK: - Methods
    
    /// Добавим эту функцию что бы генерировать числа для деления без остатка
    private func generateRandomDivisor(for number: Int) -> Int {
        var divisor = Int.random(in: 1...number)
        while number % divisor != 0 {
            divisor = Int.random(in: 1...number)
        }
        return divisor
    }
    
    /// генерируем вопрос
    private func configureQuestion() {

        firstNumber = Int.random(in: 1...99)
        secondNumber = generateRandomDivisor(for: firstNumber)
        let question: String = "\(firstNumber) \(sign) \(secondNumber) ="
        questionLabel.text = question
        randomNumberButtons()
    }
    
    /// устанавливаем правильный ответ на рандомную кнопку
    private func randomNumberButtons() {
        let randomPosition = Int.random(in: 0...1)
        let incorrectAnswer = Int.random(in: (rightAnswer - 10)...(rightAnswer + 10))
        
        if randomPosition == 0 {
            rightButton.setTitle(String(rightAnswer), for: .normal)
            leftButton.setTitle(String(incorrectAnswer), for: .normal)
        } else {
            leftButton.setTitle(String(rightAnswer), for: .normal)
            rightButton.setTitle(String(incorrectAnswer), for: .normal)
        }
    }

    
    private func checkAnswer(_ answer: String, for button: UIButton) {
        button.backgroundColor = (Int(answer) == rightAnswer) ? .green : .red
        
        
        (Int(answer) == rightAnswer) ? (counter += 1) : (counter -= 1)
        counterPoints.text = String(counter)
        
        /// перезапускаем игру
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            self.configureQuestion()
            self.uiBuilder.configureButtons(self.buttonsCollection)
        }
    }
}

// TODO: -
// 1 Добавить подсчет заработанных очков
// 2 Добавить логику увеличения и уменьшения очков в случае верного / не верного ответа
