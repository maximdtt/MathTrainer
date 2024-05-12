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

class ViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet var buttonsCollection: [UIButton]!
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureButtons()
    }
    
    
    //MARK: - Actions
    @IBAction func buttonsAction(_ sender: UIButton) {
        performSegue(withIdentifier: "goToNext", sender: sender)
    }
    
    //MARK: - Methods
    private func configureButtons() {
        
        //add shadow
        buttonsCollection.forEach { button in
            button.layer.shadowColor = UIColor.darkGray.cgColor
            button.layer.shadowOffset = CGSize.init(width: 0, height: 2)
            button.layer.shadowOpacity = 0.4
            button.layer.shadowRadius = 3
        }
    }

}

