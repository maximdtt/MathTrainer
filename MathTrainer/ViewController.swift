//
//  ViewController.swift
//  MathTrainer
//
//  Created by Maksims Šalajevs on 12/05/2024.
//

import UIKit

enum MathTypes: Int, CaseIterable {
    case add, subtract, multiply, divide
    
    var key: String {
        switch self {
        case .add:
            "addCount"
        case .subtract:
            "subtractCount"
        case .multiply:
            "multiplyCount"
        case .divide:
            "divideCount"
        }
    }
}

final class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var buttonsCollection: [UIButton]!
    
    @IBOutlet weak var addCountLabel: UILabel!
    @IBOutlet weak var subtractCountLabel: UILabel!
    @IBOutlet weak var divideCountLabel: UILabel!
    @IBOutlet weak var multiplyCountLabel: UILabel!
    
    
    // MARK: - Properties
    private let uiBuilder = UIBuilder()
    private var selectedType: MathTypes = .add
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        uiBuilder.configureButtons(buttonsCollection)
        setCountLabels()
    }
    
    // MARK: - Actions
    @IBAction func buttonsAction(_ sender: UIButton) {
        selectedType = MathTypes(rawValue: sender.tag) ?? .add
        performSegue(withIdentifier: "goToNext", sender: sender)
    }
    
    @IBAction func clearAction(_ sender: UIButton) {
        MathTypes.allCases.forEach { type in
            let key = type.key
            UserDefaults.standard.removeObject(forKey: key)
            addCountLabel.text = "-"
            subtractCountLabel.text = "-"
            divideCountLabel.text = "-"
            multiplyCountLabel.text = "-"
        }
    }
    
    @IBAction func unwindAction(unwindSegue: UIStoryboardSegue) {
        setCountLabels()
    }
    
    // MARK: - Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? TrainViewController {
            viewController.type = selectedType
        }
    }
    
    private func setCountLabels() {
        MathTypes.allCases.forEach { type in
            let key = type.key
            guard let count = UserDefaults.standard.object(forKey: key) as? Int else { return }
            let stringValue = String(count)
            
            switch type {
            case .add:
                addCountLabel.text = stringValue
            case .subtract:
                subtractCountLabel.text = stringValue
            case .multiply:
                multiplyCountLabel.text = stringValue
            case .divide:
                divideCountLabel.text = stringValue
            }
        }
    }
}
