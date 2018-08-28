//
//  ViewController.swift
//  UITestConfigurations
//
//  Created by Aly Yakan on 8/26/18.
//  Copyright © 2018 Instabug. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let controller = Controller(withSnapshot: Snapshot())
    
    lazy var submitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.backgroundColor = .gray
        button.setTitle("Submit Bug", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(submitButton)
        submitButton.addTarget(self, action: #selector(submit), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            submitButton.widthAnchor.constraint(equalToConstant: 150),
            submitButton.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        view.layoutIfNeeded()
    }
    
    @objc
    func submit() {
        controller.submit(withEmail: "mail@mail.com")
    }
}

