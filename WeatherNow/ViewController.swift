//
//  ViewController.swift
//  WeatherNow
//
//  Created by Yevhenii Vladichuk on 05/03/2023.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    let mainUI = MainUI()
    
    override func loadView() {
        super.loadView()
        view = mainUI
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainUI.searchField.delegate = self
        
        mainUI.searchButton.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
    }
    
    
    @objc func searchButtonPressed(_ sender: UIButton) {
        mainUI.searchField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        mainUI.searchField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }else {
            textField.placeholder = "No results"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //
        
        textField.text = ""
    }
}



