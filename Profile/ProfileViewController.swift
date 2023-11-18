//
//  ProfileViewController.swift
//  ImageFeed
//
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private var imageView: UIImageView!
    private var button: UIButton!
    private var nLabel: UILabel!
    private var lNLabel: UILabel!
    private var dLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage()
        logoutButton()
        nameLabel()
        loginNameLabel()
        descriptionLabel()
    }
    
    private func profileImage() {
        
        let profileImage = UIImage(named: "avatar")!
        let imageView = UIImageView(image: profileImage)
        imageView.layer.cornerRadius = 35
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        self.imageView = imageView
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            imageView.widthAnchor.constraint(equalToConstant: 70),
            imageView.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    private func logoutButton() {
        
        let button = UIButton.systemButton(
            with: UIImage(named: "logoutButton")!,
            target: self,
            action: nil
        )
        button.tintColor = .ypRed
        
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        self.button = button
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 44),
            button.heightAnchor.constraint(equalToConstant: 44),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            button.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
    }
    
    private func nameLabel() {
        let nameLabel = UILabel()
        
        nameLabel.text = "Екатерина Новикова"
        nameLabel.textColor = .ypWhite
        nameLabel.font = .boldSystemFont(ofSize: 23)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        self.nLabel = nameLabel
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    private func loginNameLabel() {
        let loginNameLabel = UILabel()
        
        loginNameLabel.text = "@ekaterina_nov"
        loginNameLabel.textColor = .ypGray
        loginNameLabel.font = .systemFont(ofSize: 13)
        
        loginNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginNameLabel)
        self .lNLabel = loginNameLabel
        
        NSLayoutConstraint.activate([
            loginNameLabel.trailingAnchor.constraint(equalTo: nLabel.trailingAnchor),
            loginNameLabel.leadingAnchor.constraint(equalTo: nLabel.leadingAnchor),
            loginNameLabel.topAnchor.constraint(equalTo: nLabel.bottomAnchor, constant: 8)
        ])
    }
    
    private func descriptionLabel() {
        let descriptionLabel = UILabel()
        
        descriptionLabel.text = "Hello, World!"
        descriptionLabel.textColor = .ypWhite
        descriptionLabel.font = .systemFont(ofSize: 13)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionLabel)
        self .dLabel = descriptionLabel
        
        NSLayoutConstraint.activate([
            descriptionLabel.trailingAnchor.constraint(equalTo: nLabel.trailingAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: nLabel.leadingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: lNLabel.bottomAnchor, constant: 8)
        ])
    }
}
