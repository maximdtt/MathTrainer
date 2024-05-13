//
//  UIBuilder.swift
//  MathTrainer
//
//  Created by Alex on 13.05.2024.
//

import UIKit

final class UIBuilder {
    func configureButtons(_ buttons: [UIButton]) {
        
        buttons.forEach { button in
            button.backgroundColor = .yellow
        }
        
        buttons.forEach { button in
            button.layer.shadowColor = UIColor.darkGray.cgColor
            button.layer.shadowOffset = CGSize.init(width: 0, height: 2)
            button.layer.shadowOpacity = 0.4
            button.layer.shadowRadius = 3
        }
        
    }
}
