//
//  MainUI.swift
//  WeatherNow
//
//  Created by Yevhenii Vladichuk on 05/03/2023.
//

import Foundation
import UIKit

class MainUI: UIView {
    
    let backgroundImage: UIImageView = {
        let backgroundImage = UIImageView()
        backgroundImage.image = UIImage(named: "background.pdf")
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImage
    }()
    
    let vStack: UIStackView = {
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.spacing = 10
        vStack.distribution = .fill
        vStack.alignment = .trailing
        vStack.translatesAutoresizingMaskIntoConstraints = false
        return vStack
    }()
    
    let hStackTop: UIStackView = {
        let hStackTop = UIStackView()
        hStackTop.axis = .horizontal
        hStackTop.spacing = 10
        hStackTop.translatesAutoresizingMaskIntoConstraints = false
        return hStackTop
    }()
    
    let locationButton: UIButton = {
        let locationButton = UIButton()
        locationButton.setBackgroundImage(UIImage(systemName: "location.circle.fill"), for: .normal)
        locationButton.tintColor = .systemBackground
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        return locationButton
    }()
    
    let searchField: UITextField = {
        let searchField = UITextField()
        searchField.textColor = .systemBackground
        searchField.font = searchField.font?.withSize(25)
        searchField.textAlignment = .right
        
        //indent from the edge
        searchField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        searchField.rightViewMode = .always
        
        searchField.tintColor = .systemBackground
        searchField.placeholder = "Search"
        searchField.backgroundColor = UIColor.systemFill
        searchField.layer.cornerRadius = 5
        return searchField
    }()
    
    let searchButton: UIButton = {
        let searchButton = UIButton()
        searchButton.setBackgroundImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .systemBackground
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        return searchButton
    }()
    
    let conditionImage: UIImageView = {
        let conditionImage = UIImageView()
        conditionImage.image = UIImage(systemName: "sun.max")
        conditionImage.tintColor = .systemBackground
        return conditionImage
    }()
    
    let temperatureStack: UIStackView = {
        let temperatureStack = UIStackView()
        temperatureStack.axis = .horizontal
        return temperatureStack
    }()
    
    let temperatureLabel: UILabel = {
        let temperatureLabel = UILabel()
        temperatureLabel.text = "21"
        temperatureLabel.textColor = .systemBackground
        temperatureLabel.font = .systemFont(ofSize: 80)
        temperatureLabel.textAlignment = .right
        return temperatureLabel
    }()
    
    let celsiusLabel: UILabel = {
        let celsiusLabel = UILabel()
        celsiusLabel.text = "°C"
        celsiusLabel.textColor = .systemBackground
        celsiusLabel.font = .systemFont(ofSize: 100, weight: .light)
        celsiusLabel.textAlignment = .left
        return celsiusLabel
    }()
    
    let cityLabel: UILabel = {
        let cityLabel = UILabel()
        cityLabel.text = "Kyiv"
        cityLabel.textColor = .systemBackground
        cityLabel.font = .systemFont(ofSize: 35)
        return cityLabel
    }()
    
    let emptyView: UIView = {
        let emptyView = UIView()
        return emptyView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addElements()
    }
    
    func addElements() {
        addSubview(backgroundImage)
        addSubview(vStack)
        
        vStack.addArrangedSubview(hStackTop)
        
        hStackTop.addArrangedSubview(locationButton)
        hStackTop.addArrangedSubview(searchField)
        hStackTop.addArrangedSubview(searchButton)
        
        vStack.addArrangedSubview(conditionImage)
        vStack.addArrangedSubview(temperatureStack)
        
        temperatureStack.addArrangedSubview(temperatureLabel)
        temperatureStack.addArrangedSubview(celsiusLabel)
        
        vStack.addArrangedSubview(cityLabel)
        vStack.addArrangedSubview(emptyView)
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            vStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            vStack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            vStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            vStack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            hStackTop.leadingAnchor.constraint(equalTo: vStack.leadingAnchor),
            hStackTop.trailingAnchor.constraint(equalTo: vStack.trailingAnchor),
            
            hStackTop.heightAnchor.constraint(equalToConstant: 40),
            locationButton.widthAnchor.constraint(equalToConstant: 40),
            searchButton.widthAnchor.constraint(equalToConstant: 40),
            
            conditionImage.heightAnchor.constraint(equalToConstant: 120),
            conditionImage.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
}
