//
//  TrainViewController.swift
//  MathTrainer
//
//  Created by Maksims Šalajevs on 12/05/2024.
//

import Foundation
import UIKit

final class TrainViewController: UIViewController {
    // MARK: - Properties
    var type: MathTypes = .add {
        didSet {
            print(type)
        }
    }
}
