//
//  AddTaskController.swift
//  ToDosRX
//
//  Created by Dariya Bengraf on 11.10.2020.
//  Copyright © 2020 Dariya Bengraf. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class AddTaskController: UIViewController {
    
    let taskSubject = PublishSubject <TaskDTO>()
    
    let textField: UITextField = {
        // TODO: Вынести в отдельную вьюшку
        let textField = UITextField()
        textField.layer.borderWidth = 1.5
        textField.layer.cornerRadius = 4
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.adjustsFontSizeToFitWidth = true
        textField.placeholder = "What do you do today?"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: textField.frame.size.height))
        textField.leftViewMode = .always
        
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: textField.frame.size.height))
        textField.rightViewMode = .always
        
        return textField
    }()
    
    
    let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: Aim.titles())
        sc.backgroundColor = .systemGreen
        sc.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.normal)
        sc.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemGreen], for: UIControl.State.selected)
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async {
            self.textField.becomeFirstResponder()
        }
    }
    
    private func setupViews() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self,action: #selector(save))
        view.backgroundColor = .white
        navigationItem.title = "New event"
        view.addSubview(segmentedControl)
        view.addSubview(textField)
        addConstraints ()
    }
    
    private func addConstraints () {
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.centerYAnchor.constraint(equalTo:view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        textField.centerXAnchor.constraint(equalTo:view.safeAreaLayoutGuide.centerXAnchor ).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        
    }
    
    @objc func save () {
        guard let aim = Aim(rawValue: self.segmentedControl.selectedSegmentIndex),
            let text = self.textField.text else {
                print("No valid task")
                return
            }
        
        taskSubject.onNext(TaskDTO(
            title: text,
            aim: aim
        ))
        self.dismiss(animated: true, completion: nil)
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    
}
