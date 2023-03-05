//
//  ViewController.swift
//  WeatherNow
//
//  Created by Yevhenii Vladichuk on 05/03/2023.
//

import UIKit

class ViewController: UIViewController {
    
    let mainUI = MainUI()
    
    override func loadView() {
        super.loadView()
        view = mainUI
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
}

