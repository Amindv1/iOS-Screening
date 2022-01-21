//
//  UserDetailPage.swift
//  UserDetailPage
//
//  Created by Amin on 1/19/22.
//

import UIKit

class UserDetailPageViewController : UIViewController {
    let imageView = UIImageView()
    let firstNameTextView = UITextView()
    let lastNameTextView = UITextView()
    let firstNameLabel = UILabel()
    let lastNameLabel = UILabel()
    let saveButton = UIButton(type: .system)
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        view.addSubview(firstNameLabel)
        view.addSubview(lastNameLabel)
        view.addSubview(firstNameTextView)
        view.addSubview(lastNameTextView)
        view.addSubview(saveButton)
        view.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        firstNameLabel.translatesAutoresizingMaskIntoConstraints = false
        lastNameLabel.translatesAutoresizingMaskIntoConstraints = false
        firstNameTextView.translatesAutoresizingMaskIntoConstraints = false
        lastNameTextView.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = user?.image
        firstNameLabel.text = "First Name:"
        lastNameLabel.text = "Last Name:"
        firstNameTextView.text = user?.first
        lastNameTextView.text = user?.last
        saveButton.setTitle("Save", for: .normal)
        saveButton.addTarget(self, action: #selector(save), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 120),
            imageView.heightAnchor.constraint(equalToConstant: 120),
            
            firstNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            firstNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            firstNameLabel.widthAnchor.constraint(equalToConstant: 100),
            firstNameLabel.heightAnchor.constraint(equalToConstant: 30),
            
            lastNameLabel.topAnchor.constraint(equalTo: firstNameLabel.bottomAnchor, constant: 10),
            lastNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lastNameLabel.widthAnchor.constraint(equalToConstant: 100),
            lastNameLabel.heightAnchor.constraint(equalToConstant: 30),
            
            firstNameTextView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            firstNameTextView.leadingAnchor.constraint(equalTo: firstNameLabel.trailingAnchor, constant: 10),
            firstNameTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            firstNameTextView.heightAnchor.constraint(equalToConstant: 30),
            
            lastNameTextView.topAnchor.constraint(equalTo: firstNameTextView.bottomAnchor, constant: 10),
            lastNameTextView.leadingAnchor.constraint(equalTo: lastNameLabel.trailingAnchor, constant: 10),
            lastNameTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            lastNameTextView.heightAnchor.constraint(equalToConstant: 30),
            
            saveButton.topAnchor.constraint(equalTo: lastNameTextView.bottomAnchor, constant: 20),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            saveButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc func save() {
        user?.first = firstNameTextView.text
        user?.last = lastNameTextView.text
        
        navigationController?.popViewController(animated: true)
    }
}
