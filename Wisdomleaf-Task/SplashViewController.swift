//
//  SplashViewController.swift
//  Wisdomleaf-Task
//
//  Created by Dinesh Kumar on 21/04/23.
//

import UIKit

class SplashViewController: UIViewController {
    
    lazy var splashImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "SplashImage"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(splashImageView)
        addConstraints()
    }
    
    //constraints to center the splash image view
    func addConstraints() {
        
        NSLayoutConstraint.activate([
            splashImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            splashImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            splashImageView.heightAnchor.constraint(equalToConstant: 300),
            splashImageView.widthAnchor.constraint(equalToConstant: 300),
        ])
        
    }
    
}
