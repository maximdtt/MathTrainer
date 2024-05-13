//
//  ViewController.swift
//  MathTrainer
//
//  Created by Maksims Šalajevs on 12/05/2024.
//

import UIKit

enum MathTypes: Int {
    case add, subtract, multiply, divide
}

final class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var buttonsCollection: [UIButton]!
    
    // MARK: - Properties
    private let uiBuilder = UIBuilder()
    private var selectedType: MathTypes = .add
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        uiBuilder.configureButtons(buttonsCollection)
    }
    
    // MARK: - Actions
    @IBAction func buttonsAction(_ sender: UIButton) {
        selectedType = MathTypes(rawValue: sender.tag) ?? .add
        performSegue(withIdentifier: "goToNext", sender: sender)
    }
    
    @IBAction func unwindAction(unwindSegue: UIStoryboardSegue) {}
    
    // MARK: - Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? TrainViewController {
            viewController.type = selectedType
        }
    }
}
